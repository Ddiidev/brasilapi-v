module v1

import net.http
import json
import cep.errors

const uri = 'https://brasilapi.com.br/api/cep/v1'

// Retorna os dados do CEP(Código de Endereçamento Postal).
// https://brasilapi.com.br/docs#tag/CEP
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
