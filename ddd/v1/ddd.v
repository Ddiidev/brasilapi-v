module v1

import net.http
import ddd.errors
import json

// https://brasilapi.com.br/docs#tag/DDD
const uri = 'https://brasilapi.com.br/api/ddd/v1/'

// get_ddd Retorna estado e lista de cidades por DDD
//
// https://brasilapi.com.br/docs#tag/DDD/paths/~1ddd~1v1~1{ddd}/get
//
// Exemplo de uso:
// ```
// if ddd_ := get_ddd("83") {
//  dump(ddd_)
// } else {
//  println(err.msg())
//
//  // For more details about the error
//  // if err is ddd.errors.DddError {
//  //     dump(err)
//  // }
// }
// ```
pub fn get_ddd(ddd string) !Ddd {
	resp := http.get('${v1.uri}/${ddd}') or { return errors.DddError{
		message: err.msg()
	} }

	if resp.status_code in [404, 500] {
		return json.decode(errors.DddError, resp.body) or {
			return errors.DddError{
				message: err.msg()
			}
		}
	} else {
		return json.decode(Ddd, resp.body) or { return errors.DddError{
			message: err.msg()
		} }
	}
}
