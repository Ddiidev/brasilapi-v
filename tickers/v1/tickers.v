module v1

import json
import net.http
import tickers.errors { TickersError }

const uri = 'https://brasilapi.com.br/api/tickers/b3'

// get_acoes Retorna a lista de tickers das empresas listadas na B3.
pub fn get_acoes() ![]TickerAcao {
	resp := http.get('${v1.uri}/acoes/v1') or { return TickersError{
		message: err.msg()
	} }

	if resp.status_code >= 500 {
		return error_with_code(resp.status_msg, resp.status_code)
	}

	if resp.status_code != 200 {
		return json.decode(TickersError, resp.body) or { return TickersError{
			message: err.msg()
		} }
	}

	return json.decode([]TickerAcao, resp.body) or { return TickersError{
		message: err.msg()
	} }
}

// get_fundos Retorna a lista de tickers de fundos listados na B3 de acordo com o tipo.
pub fn get_fundos(tipo TipoFundo) ![]TickerFundo {
	resp := http.get('${v1.uri}/fundos/v1/${tipo.api_value()}') or { return TickersError{
		message: err.msg()
	} }

	if resp.status_code >= 500 {
		return error_with_code(resp.status_msg, resp.status_code)
	}

	if resp.status_code != 200 {
		return json.decode(TickersError, resp.body) or { return TickersError{
			message: err.msg()
		} }
	}

	return json.decode([]TickerFundo, resp.body) or { return TickersError{
		message: err.msg()
	} }
}
