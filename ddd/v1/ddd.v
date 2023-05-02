module v1

import net.http
import ddd.errors
import json

// https://brasilapi.com.br/docs#tag/DDD
const uri = 'https://brasilapi.com.br/api/ddd/v1/'

// get Retorna estado e lista de cidades por DDD
//
// https://brasilapi.com.br/docs#tag/DDD/paths/~1ddd~1v1~1{ddd}/get
//
// Exemplo de uso:
// ```v
// if ddd := ddd_.get_ddd("83") {
//  dump(ddd)
// } else {
//  println(err.msg())
//
//  // For more details about the error
//  // if err is ddd_.errors.DddError {
//  //     dump(err)
//  // }
// }
// ```
//
// Caso o DDD não exista, será retornado um erro do tipo `errors.DddError`
// Caso ocorra alguma falha na api, será retornado um erro do tipo `IError`
pub fn get(ddd string) !Ddd {
	resp := http.get('${v1.uri}/${ddd}') or { return errors.DddError{
		message: err.msg()
	} }

	if resp.status_code in [404, 500] {
		return json.decode(errors.DddError, resp.body) or {
			return errors.DddError{
				message: err.msg()
			}
		}
	} else if resp.status_code == 504 {
		return error('timeout')
	} else {
		return json.decode(Ddd, resp.body) or { return errors.DddError{
			message: err.msg()
		} }
	}
}
