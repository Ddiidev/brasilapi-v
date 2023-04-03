module v1

import time

pub struct Corretora {
pub:
	cnpj                     string
	@type                    string
	nome_social              string
	nome_comercial           string
	status                   string
	email                    string
	telefone                 string
	cep                      string
	pais                     string
	uf                       string
	municipio                string
	bairro                   string
	complemento              string
	logradouro               string
	data_patrimonio_liquido  time.Time
	valor_patrimonio_liquido f64
	codigo_cvm               string
	data_inicio_situacao     time.Time
	data_registro            time.Time
}

struct Corretora_temp {
pub:
	cnpj                     string
	@type                    string
	nome_social              string
	nome_comercial           string
	status                   string
	email                    string
	telefone                 string
	cep                      string
	pais                     string
	uf                       string
	municipio                string
	bairro                   string
	complemento              string
	logradouro               string
	data_patrimonio_liquido  string
	valor_patrimonio_liquido string
	codigo_cvm               string
	data_inicio_situacao     string
	data_registro            string
}

// get_corretoras faz um parser da struct Corretora_temp para Corretora
pub fn (c []Corretora_temp) get_corretoras() []Corretora {
	return c.map(it.get_corretora())
}

// get_corretora faz um parser da struct Corretora_temp para Corretora
pub fn (c Corretora_temp) get_corretora() Corretora {
	mut c_ := Corretora{
		cnpj: c.cnpj
		@type: c.@type
		nome_social: c.nome_social
		nome_comercial: c.nome_comercial
		status: c.status
		email: c.email
		telefone: c.telefone
		cep: c.cep
		pais: c.pais
		uf: c.uf
		municipio: c.municipio
		bairro: c.bairro
		complemento: c.complemento
		logradouro: c.logradouro
		valor_patrimonio_liquido: c.valor_patrimonio_liquido.f64()
		codigo_cvm: c.codigo_cvm
		data_patrimonio_liquido: time.parse('${c.data_patrimonio_liquido} 00:00:00.000') or {
			time.now()
		}
		data_inicio_situacao: time.parse('${c.data_inicio_situacao} 00:00:00.000') or { time.now() }
		data_registro: time.parse('${c.data_registro} 00:00:00.000') or { time.now() }
	}

	return c_
}
