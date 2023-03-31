module v1

import net.http
import json
import corretora.errors { CorretoraError }
import cnpj { CNPJ }

// https://brasilapi.com.br/docs#tag/Corretoras/
const uri = 'https://brasilapi.com.br/api/cvm/corretoras/v1'

// get_all Retorna informações referentes a todas as Corretoras ativas listadas na CVM.
//
// https://brasilapi.com.br/docs#tag/Corretoras/paths/~1cvm~1corretoras~1v1/get
//
// Exemplo de uso:
// ```
// if corretoras := corretora_.get_all_corretoras() {
// 	dump(corretoras)
// } else {
// 	// print message error
// 	println(err)
// }
// ```
//
pub fn get_all() ![]Corretora {
	resp := http.get(v1.uri) or { return CorretoraError{
		message: err.msg()
	} }

	mut js := json.decode([]Corretora_temp, resp.body) or {
		return CorretoraError{
			message: err.msg()
		}
	}

	return js.get_corretoras()
}

// get_by_cnpj Retorna informações referentes a um corretora ativa listada na CVM apartir do cnpj.
//
// https://brasilapi.com.br/docs#tag/Corretoras/paths/~1cvm~1corretoras~1v1~1{cnpj}/get
//
// Exemplo de uso:
// ```
// if corretora := corretora_.get_corretora_by_cnpj('24159923000159') {
// 	dump(corretora)
// } else {
// 	// print detail message error
//  if err is corretora_.errors.CorretoraError {
//      println("Tipo: ${err.type}\nMsg: ${err.message}")
//  }
// }
// ```
//
// Caso não seja encontrado o cnpj, irá retornar um errors.CorretoraError
pub fn get_by_cnpj(cnpj_code_ CNPJ) !Corretora {
	mut cnpj_code := cnpj_code_.remove_format_cnpj()

	resp := http.get('${v1.uri}/${cnpj_code}') or { return CorretoraError{
		message: err.msg()
	} }

	if resp.status_code == 404 {
		return json.decode(CorretoraError, resp.body) or {
			return CorretoraError{
				message: err.msg()
			}
		}
	}

	mut js := json.decode(Corretora_temp, resp.body) or {
		return CorretoraError{
			message: err.msg()
		}
	}

	return js.get_corretora()
}
