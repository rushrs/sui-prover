// Copyright (c) The Diem Core Contributors
// Copyright (c) The Move Contributors
// SPDX-License-Identifier: Apache-2.0

use anyhow::Result;
use move_compiler::{
    diagnostics::filter::empty_filter_scope,
    editions::Edition,
    shared::{NumberFormat, NumericalAddress, PackageConfig, PackagePaths},
    Flags,
};
use move_model::{model::GlobalEnv, run_model_builder_with_options_and_compilation_flags};
use move_package::{
    compilation::build_plan::BuildPlan,
    resolution::resolution_graph::{Package, Renaming, ResolvedGraph, ResolvedTable},
};
use move_symbol_pool::Symbol;
use std::{collections::BTreeMap, fs, path::Path};

#[derive(Debug, Clone)]
pub struct ModelBuilderLegacy {
    resolution_graph: ResolvedGraph,
}

impl ModelBuilderLegacy {
    pub fn create(resolution_graph: ResolvedGraph) -> Self {
        Self { resolution_graph }
    }

    // NOTE: If there are now renamings, then the root package has the global resolution of all named
    // addresses in the package graph in scope. So we can simply grab all of the source files
    // across all packages and build the Move model from that.
    // TODO: In the future we will need a better way to do this to support renaming in packages
    // where we want to support building a Move model.
    pub fn build_model(&self, flags: Flags) -> Result<GlobalEnv> {
        // Make sure no renamings have been performed
        if let Some(pkg_name) = self.resolution_graph.contains_renaming() {
            anyhow::bail!(
                "Found address renaming in package '{}' when \
                    building Move model -- this is currently not supported",
                pkg_name
            )
        }

        // Targets are all files in the root package
        let root_name = self.resolution_graph.root_package();
        let root_package = self.resolution_graph.get_package(root_name).clone();
        let target = self.root_package_paths(&root_package)?;
        let deps = BuildPlan::create(&self.resolution_graph)?
            .compute_dependencies()
            .make_deps_for_compiler()?;

        let all_targets = vec![source_package_paths(target)?];
        let all_deps = deps
            .into_iter()
            .map(|(p, _)| source_package_paths(p))
            .collect::<Result<Vec<_>>>()?;
        run_model_builder_with_options_and_compilation_flags(all_targets, all_deps, flags, None)
    }

    fn root_package_paths(&self, root: &Package) -> Result<PackagePaths> {
        let root_named_addrs = apply_named_address_renaming(
            root.source_package.package.name,
            named_address_mapping_for_compiler(&root.resolved_table),
            &root.renaming,
        );
        Ok(PackagePaths {
            name: Some((
                root.source_package.package.name,
                compiler_config(root, /* is_dependency */ false, &self.resolution_graph),
            )),
            paths: root.get_sources(&self.resolution_graph.build_options)?,
            named_address_map: root_named_addrs,
        })
    }
}

fn source_package_paths(mut package_paths: PackagePaths) -> Result<PackagePaths> {
    let mut sources = vec![];
    for path in package_paths.paths {
        collect_move_sources(Path::new(path.as_str()), &mut sources)?;
    }
    package_paths.paths = sources;
    Ok(package_paths)
}

fn collect_move_sources(path: &Path, sources: &mut Vec<Symbol>) -> Result<()> {
    if path.is_file() {
        if path.extension().is_some_and(|ext| ext == "move") {
            sources.push(Symbol::from(path.to_string_lossy().as_ref()));
        }
        return Ok(());
    }

    if !path.is_dir() || path.file_name().is_some_and(|name| name == "build") {
        return Ok(());
    }

    for entry in fs::read_dir(path)? {
        collect_move_sources(&entry?.path(), sources)?;
    }

    sources.sort();
    Ok(())
}

fn compiler_config(
    package: &Package,
    is_dependency: bool,
    resolution_graph: &ResolvedGraph,
) -> PackageConfig {
    PackageConfig {
        is_dependency,
        flavor: package
            .source_package
            .package
            .flavor
            .or(resolution_graph.build_options.default_flavor)
            .unwrap_or_default(),
        edition: package
            .source_package
            .package
            .edition
            .or(resolution_graph.build_options.default_edition)
            .unwrap_or(Edition::LEGACY),
        warning_filter: empty_filter_scope(),
    }
}

fn named_address_mapping_for_compiler(
    resolution_table: &ResolvedTable,
) -> BTreeMap<Symbol, NumericalAddress> {
    resolution_table
        .iter()
        .map(|(ident, addr)| {
            let parsed_addr = NumericalAddress::new(addr.into_bytes(), NumberFormat::Hex);
            (*ident, parsed_addr)
        })
        .collect()
}

fn apply_named_address_renaming(
    current_package_name: Symbol,
    address_resolution: BTreeMap<Symbol, NumericalAddress>,
    renaming: &Renaming,
) -> BTreeMap<Symbol, NumericalAddress> {
    let package_renamings = renaming
        .iter()
        .filter_map(|(rename_to, (package_name, from_name))| {
            if package_name == &current_package_name {
                Some((from_name, *rename_to))
            } else {
                None
            }
        })
        .collect::<BTreeMap<_, _>>();

    address_resolution
        .into_iter()
        .map(|(name, value)| {
            let new_name = package_renamings.get(&name).copied();
            (new_name.unwrap_or(name), value)
        })
        .collect()
}
