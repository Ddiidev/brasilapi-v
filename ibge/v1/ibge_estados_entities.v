module v1

pub struct Estado {
pub:
	id     int
	sigla  string
	nome   string
	regiao ?Regiao
}

pub struct Regiao {
pub:
	id    int
	sigla string
	nome  string
}
