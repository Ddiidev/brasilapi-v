module v1

pub struct Capital {
pub:
	codigo_icao         string
	atualizado_em       string
	pressao_atmosferica string
	visibilidade        string
	vento               int
	direcao_vento       int
	umidade             int
	condicao            string
	condicao_desc       string @[json: 'condicao_Desc']
	temp                int
}
