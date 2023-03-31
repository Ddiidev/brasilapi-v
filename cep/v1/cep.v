module v1

import net.http
import json
import cep.errors

// https://brasilapi.com.br/docs#tag/CEP
const uri = 'https://brasilapi.com.br/api/cep/v1'

// get Retorna os dados do CEP(Código de Endereçamento Postal).
// https://brasilapi.com.br/docs#tag/CEP/paths/~1cep~1v1~1{cep}/get
//
// Exemplo de uso:
// ```
// if cep := cep_.get_cep('63900-193') {
// 	dump(cep)
// } else {
// 	// print message error
// 	println(err)
// }
// ```
//
// Caso não seja encontrado o cep, irá retornar um errors.CepError
pub fn get(cep_code string) !Cep {
	resp := http.get('${v1.uri}/${cep_code}') or { return errors.CepError{
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
