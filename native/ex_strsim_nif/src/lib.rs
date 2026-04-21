// String distance

#[rustler::nif]
fn levenshtein(a: &str, b: &str) -> usize {
    strsim::levenshtein(a, b)
}

#[rustler::nif]
fn damerau_levenshtein(a: &str, b: &str) -> usize {
    strsim::damerau_levenshtein(a, b)
}

#[rustler::nif]
fn hamming(a: &str, b: &str) -> Result<usize, rustler::Error> {
    strsim::hamming(a, b).map_err(|e| rustler::Error::Term(Box::new(e.to_string())))
}

#[rustler::nif]
fn osa_distance(a: &str, b: &str) -> usize {
    strsim::osa_distance(a, b)
}

// String similarity

#[rustler::nif]
fn normalized_levenshtein(a: &str, b: &str) -> f64 {
    strsim::normalized_levenshtein(a, b)
}

#[rustler::nif]
fn normalized_damerau_levenshtein(a: &str, b: &str) -> f64 {
    strsim::normalized_damerau_levenshtein(a, b)
}

#[rustler::nif]
fn jaro(a: &str, b: &str) -> f64 {
    strsim::jaro(a, b)
}

#[rustler::nif]
fn jaro_winkler(a: &str, b: &str) -> f64 {
    strsim::jaro_winkler(a, b)
}

#[rustler::nif]
fn sorensen_dice(a: &str, b: &str) -> f64 {
    strsim::sorensen_dice(a, b)
}

// Generic (word-level)

#[rustler::nif]
fn generic_levenshtein(a: Vec<String>, b: Vec<String>) -> usize {
    strsim::generic_levenshtein(&a, &b)
}

#[rustler::nif]
fn generic_damerau_levenshtein(a: Vec<String>, b: Vec<String>) -> usize {
    strsim::generic_damerau_levenshtein(&a, &b)
}

#[rustler::nif]
fn generic_hamming(a: Vec<String>, b: Vec<String>) -> Result<usize, rustler::Error> {
    strsim::generic_hamming(&a, &b).map_err(|e| rustler::Error::Term(Box::new(e.to_string())))
}

#[rustler::nif]
fn generic_jaro(a: Vec<String>, b: Vec<String>) -> f64 {
    strsim::generic_jaro(&a, &b)
}

#[rustler::nif]
fn generic_jaro_winkler(a: Vec<String>, b: Vec<String>) -> f64 {
    strsim::generic_jaro_winkler(&a, &b)
}

rustler::init!("Elixir.ExStrsim.Native");
