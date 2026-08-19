module prover::log;

#[ext(spec_only)]
public native fun text(x: vector<u8>);

#[ext(spec_only)]
public native fun var<T>(x: &T);

#[ext(spec_only)]
public native fun ghost<T, U>();
