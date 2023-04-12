module v1

import net.http
import ibge.errors { IBGEError }
import json

// Para referência: https://brasilapi.com.br/docs#tag/IBGE/paths/~1ibge~1municipios~1v1~1{siglaUF}?providers=dados-abertos-br,gov,wikipedia/get
const uri_municipios = 'https://brasilapi.com.br/api/ibge/municipios/v1'

// Para referência https://brasilapi.com.br/docs#tag/IBGE/paths/~1ibge~1uf~1v1/get
const uri_uf = 'https://brasilapi.com.br/api/ibge/uf/v1'

[params]
pub struct ParamsGet {
pub:
	uf        string    [required]
	providers Providers [required]
}

// get_municipios Retorna os municípios da unidade federativa
//
// https://brasilapi.com.br/docs#tag/IBGE/paths/~1ibge~1municipios~1v1~1{siglaUF}?providers=dados-abertos-br,gov,wikipedia/get
//
// Exemplos de uso:
//
// ```v
// if municipios := ibfe.get_municipios(uf: "PB", providers: ibge.Providers.dados_aberto_br | Wikipedia) {
//  dump(municipios)
// } else {
// dump(err)
// }
// ```
//
// Caso ocorro algum erro, o retorno será um IBGEError
pub fn get_municipios(param ParamsGet) ![]IBGE {
	providers := param.providers.get_names_setad()
	uri := '${v1.uri_municipios}/${param.uf}?providers=${providers.join(',')}'

	resp := http.get(uri) or { return IBGEError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(IBGEError, resp.body) or { return IBGEError{
			message: err.msg()
		} }
	}

	return json.decode([]IBGE, resp.body) or { return IBGEError{
		message: err.msg()
	} }
}

// get_estados Retorna informações de todos estados do Brasil
//
// https://brasilapi.com.br/docs#tag/IBGE/paths/~1ibge~1uf~1v1/get
//
// Exemplos de uso:
//
// ```v
// if estados := _ibge.get_estados() {
//  dump(estados)
// } else {
//  dump(err)
// }
// ```
//
// Caso ocorro algum erro, o retorno será um IBGEError
pub fn get_estados() ![]Estado {
	resp := http.get(v1.uri_uf) or { return IBGEError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return IBGEError{
			message: resp.body
		}
	}

	return json.decode([]Estado, resp.body) or { return IBGEError{
		message: err.msg()
	} }
}

// get_estado_por_sigla_ou_codigo Retorna informações de um estado do Brasil
//
// https://brasilapi.com.br/docs#tag/IBGE/paths/~1ibge~1uf~1v1~1{siglaOuCodigo}/get
//
// Exemplos de uso:
//
// ```v
// if estado := _ibge.get_estado_por_sigla_ou_codigo(sigla_ou_codigo: "PB") {
//  dump(estado)
// } else {
//  dump(err)
// }
// ```
//
// Caso ocorro algum erro, o retorno será um IBGEError
pub fn get_estado_por_sigla_ou_codigo(sigla_ou_codigo SiglaCodigo) !Estado {
	resp := http.get('${v1.uri_uf}/${sigla_ou_codigo}') or {
		return IBGEError{
			message: err.msg()
		}
	}

	if resp.status_code != 200 {
		return json.decode(IBGEError, resp.body) or { return IBGEError{
			message: err.msg()
		} }
	}

	return json.decode(Estado, resp.body) or { return IBGEError{
		message: err.msg()
	} }
}
