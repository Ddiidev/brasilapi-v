module v1

import json
import net.http
import taxas.errors { TaxaError }

// https://brasilapi.com.br/docs#tag/TAXAS/paths/~1taxas~1v1/get
const uri = 'https://brasilapi.com.br/api/taxas/v1'

// get Retorna as taxas de juros e alguns índices oficiais do Brasil
//
// https://brasilapi.com.br/docs#tag/TAXAS/paths/~1taxas~1v1/get
//
// Exemplo de uso:
// ```v
// if taxas := taxas_.get() {
//  dump(taxas)
// } else {
//  println(err) //print message error
// }
// ```
//
// Caso ocorra alguma falha irá retornar um errors.TaxaError
pub fn get() ![]Taxa {
	resp := http.get(v1.uri) or { return TaxaError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(TaxaError, resp.body) or {
			return TaxaError{
				message: err.msg()
			}
		}
	}

	return json.decode([]Taxa, resp.body) or { return TaxaError{
		message: err.msg()
	} }
}
