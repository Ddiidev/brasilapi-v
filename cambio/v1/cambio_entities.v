module v1

pub struct Moeda {
pub:
	simbolo    string
	nome       string
	tipo_moeda string
}

pub struct CotacaoCambio {
pub:
	paridade_compra   f64
	paridade_venda    f64
	cotacao_compra    f64
	cotacao_venda     f64
	data_hora_cotacao string
	tipo_boletim      string
}

pub struct CambioCotacao {
pub:
	cotacoes []CotacaoCambio
	moeda    string
	data     string
}
