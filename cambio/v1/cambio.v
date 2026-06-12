module v1

import cambio.errors { CambioError }
import json
import net.http

const uri = 'https://brasilapi.com.br/api/cambio/v1'

// get_moedas Lista todas as moedas disponíveis para consulta de câmbio.
pub fn get_moedas() ![]Moeda {
	resp := http.get('${v1.uri}/moedas') or {
		return CambioError{
			message: err.msg()
		}
	}

	if resp.status_code >= 500 {
		return error_with_code(resp.status_msg, resp.status_code)
	}

	if resp.status_code != 200 {
		return json.decode(CambioError, resp.body) or {
			return CambioError{
				message: err.msg()
			}
		}
	}

	return json.decode([]Moeda, resp.body) or {
		return CambioError{
			message: err.msg()
		}
	}
}

// get_cotacao Busca o câmbio do Real com outra moeda em uma data específica.
pub fn get_cotacao(moeda string, data string) !CambioCotacao {
	resp := http.get('${v1.uri}/cotacao/${moeda}/${data}') or {
		return CambioError{
			message: err.msg()
		}
	}

	if resp.status_code >= 500 {
		return error_with_code(resp.status_msg, resp.status_code)
	}

	if resp.status_code != 200 {
		return json.decode(CambioError, resp.body) or {
			return CambioError{
				message: err.msg()
			}
		}
	}

	return json.decode(CambioCotacao, resp.body) or {
		return CambioError{
			message: err.msg()
		}
	}
}
