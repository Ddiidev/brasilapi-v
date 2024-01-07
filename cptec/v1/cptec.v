module v1

import json
import net.http
import net.urllib
import cptec.errors { CptecError }

// https://brasilapi.com.br/docs#operation/listcities(/cptec/v1/cidade)
const uri_cidade = 'https://brasilapi.com.br/api/cptec/v1/cidade'

const uri_clima_capital = 'https://brasilapi.com.br/api/cptec/v1/clima/capital'

const uri_clima_aeroporto = 'https://brasilapi.com.br/api/cptec/v1/clima/aeroporto'

const uri_previsao_cidade = 'https://brasilapi.com.br/api/cptec/v1/clima/previsao'

const uri_previsao_oceanica_cidade = 'https://brasilapi.com.br/api/cptec/v1/ondas/'

@[params]
pub struct ParamCidades {
pub:
	city_name ?string
}

@[params]
pub struct ParamPrevisaoCidade {
pub:
	city_code int
	days      i16 = 1
}

// cidades Retorna listagem com todas as cidades junto a seus respectivos códigos presentes nos serviços da CPTEC
//
// https://brasilapi.com.br/docs#operation/listcities(/cptec/v1/cidade)
//
// Exemplo de uso:
// ```v
// if cidades := cptec.cidades() {
//  dump(cidades)
// } else {
//  println(err) //print message error
// }
// ```
//
// Caso ocorra alguma falha irá retornar um errors.CptecError
pub fn cidades(params ParamCidades) ![]Cidade {
	uri := match params.city_name {
		none {
			v1.uri_cidade
		}
		else {
			city_name := urllib.path_escape(params.city_name or { '' })
			'${v1.uri_cidade}/${city_name}'
		}
	}

	resp := http.get(uri) or { return CptecError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(CptecError, resp.body) or {
			return CptecError{
				message: err.msg()
			}
		}
	}

	return json.decode([]Cidade, resp.body) or { return CptecError{
		message: err.msg()
	} }
}

// clima_capital Retorna condições meteorológicas atuais nas capitais do país, com base nas estações de solo de seu aeroporto.
//
// https://brasilapi.com.br/docs#operation/Condi%C3%A7%C3%B5esatuaisnascapitais(/cptec/v1/clima/capital)
//
// Exemplo de uso:
// ```v
// if climas := cptec.clima_capital() {
//  dump(climas)
// } else {
//  println(err) //print message error
// }
// ```
//
// Caso ocorra alguma falha irá retornar um errors.CptecError
pub fn clima_capital() ![]Capital {
	resp := http.get(v1.uri_clima_capital) or { return CptecError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(CptecError, resp.body) or {
			return CptecError{
				message: err.msg()
			}
		}
	}

	return json.decode([]Capital, resp.body) or { return CptecError{
		message: err.msg()
	} }
}

// clima_aeroporto Retorna condições meteorológicas atuais no aeroporto solicitado. Este endpoint utiliza o código ICAO (4 dígitos) do aeroporto.
//
// https://brasilapi.com.br/docs#operation/airportcurrentcondicao(/cptec/v1/clima/aeroporto/:icaoCode)
//
// Exemplo de uso:
// ```v
// if clima := cptec.clima_aeroporto() {
//  dump(clima)
// } else {
//  println(err) //print message error
// }
// ```
//
// Caso ocorra alguma falha irá retornar um errors.CptecError
pub fn clima_aeroporto(icao_code string) !Capital {
	resp := http.get('${v1.uri_clima_aeroporto}/${icao_code}') or {
		return CptecError{
			message: err.msg()
		}
	}

	if resp.status_code != 200 {
		return json.decode(CptecError, resp.body) or {
			return CptecError{
				message: err.msg()
			}
		}
	}

	return json.decode(Capital, resp.body) or { return CptecError{
		message: err.msg()
	} }
}

// previsao_cidade Retorna Pervisão meteorológica de 1 até 6 dias da cidade informada.
//
// https://brasilapi.com.br/docs#operation/airportcurrentcondicao(/cptec/v1/clima/aeroporto/:icaoCode)
//
// Exemplo de uso:
// ```v
// if previsao := cptec.previsao_cidade() {
//  dump(previsao)
// } else {
//  println(err) //print message error
// }
// ```
//
// Caso ocorra alguma falha irá retornar um errors.CptecError
pub fn previsao_cidade(params ParamPrevisaoCidade) !Previsiao {
	if params.days < 1 || params.days > 6 {
		return CptecError{
			message: 'O valor do parâmetro days deve ser entre 1 e 6'
		}
	}

	resp := http.get('${v1.uri_previsao_cidade}/${params.city_code}/${params.days}') or {
		return CptecError{
			message: err.msg()
		}
	}

	if resp.status_code != 200 {
		return json.decode(CptecError, resp.body) or {
			return CptecError{
				message: err.msg()
			}
		}
	}

	return json.decode(Previsiao, resp.body) or { return CptecError{
		message: err.msg()
	} }
}

// previsao_oceanica Retorna Pervisão oceânica de 1 até 6 dias da cidade informada.
//
// https://brasilapi.com.br/docs#operation/airportcurrentcondicao(/cptec/v1/clima/aeroporto/:icaoCode)
//
// Exemplo de uso:
// ```v
// if previsao := cptec.previsao_oceanica() {
//  dump(previsao)
// } else {
//  println(err) //print message error
// }
// ```
//
// Caso ocorra alguma falha irá retornar um errors.CptecError
pub fn previsao_oceanica(params ParamPrevisaoCidade) !PrevisaOceanica {
	if params.days < 1 || params.days > 6 {
		return CptecError{
			message: 'O valor do parâmetro days deve ser entre 1 e 6'
		}
	}

	resp := http.get('${v1.uri_previsao_oceanica_cidade}/${params.city_code}/${params.days}') or {
		return CptecError{
			message: err.msg()
		}
	}

	if resp.status_code != 200 {
		return json.decode(CptecError, resp.body) or {
			return CptecError{
				message: err.msg()
			}
		}
	}

	return json.decode(PrevisaOceanica, resp.body) or { return CptecError{
		message: err.msg()
	} }
}
