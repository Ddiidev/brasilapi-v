module v1

pub struct Fundo {
pub:
	cnpj string
	denominacao_social string
	codigo_cvm string
	tipo_fundo string
	situacao string
	data_registro string
	data_constituicao string
	data_cancelamento string
}

pub struct FundosResponse {
pub:
	data []Fundo
	page int
	size int
}
