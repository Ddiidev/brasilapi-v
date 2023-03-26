module v2

import net.http
import cep.errors
import json

// https://brasilapi.com.br/docs#tag/CEP-V2
const uri = 'https://brasilapi.com.br/api/cep/v2'

// Retorna os dados do CEP(Código de Endereçamento Postal).
// Com a adição da geolocalização.
// https://brasilapi.com.br/docs#tag/CEP-V2/paths/~1cep~1v2~1{cep}/get
//
// Exemplo de uso:
// ```
// if cep_ := cep.get_cep('63900-193') {
// 	dump(cep_)
// } else {
// 	// print message error
// 	println(err)
// }
// ```
//
// Caso não seja encontrado o cep, irá retornar um errors.CepError
pub fn get_cep(cep_code string) !Cep {
	resp := http.get('${v2.uri}/${cep_code}') or { return errors.CepError{
		message: err.msg()
	} }

	if resp.status_code == 404 {
		return json.decode(errors.CepError, resp.body) or {
			return errors.CepError{
				message: err.msg()
			}
		}
	}

	return json.decode(Cep, resp.body) or { return errors.CepError{
		message: err.msg()
	} }
}
