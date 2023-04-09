module v1

pub struct Estado {
pub:
	id     i32
	sigla  string
	nome   string
	regiao ?Regiao
}

pub struct Regiao {
pub:
	id    i32
	sigla string
	nome  string
}
