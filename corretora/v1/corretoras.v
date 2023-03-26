module v1

import net.http
import json
import corretora.errors { CorretoraError }
const uri = 'https://brasilapi.com.br/api/cvm/corretoras/v1'


// Retorna informações referentes a todas as Corretoras ativas listadas na CVM.
//
// https://brasilapi.com.br/docs#tag/Corretoras
//
// Exemplo de uso:
// ```
// if corretoras := corretora.get_all_corretoras() {
// 	dump(corretoras)
// } else {
// 	// print message error
// 	println(err)
// }
// ```
//
pub fn get_all_corretoras() ![]Corretora {
	resp := http.get(v1.uri) or { return CorretoraError{
		message: err.msg()
	} }

	return json.decode([]Corretora, resp.body)
}


// Retorna informações referentes a um corretora ativa listada na CVM apartir do cnpj.
//
// https://brasilapi.com.br/docs#tag/Corretoras
//
// Exemplo de uso:
// ```
// if corretora_ := corretora.get_corretora_by_cnpj('24159923000159') {
// 	dump(corretora_)
// } else {
// 	// print detail message error
//  if err is errors.CorretoraError {
//      println("Tipo: ${err.type}\nMsg: ${err.message}")
//  }
// }
// ```
//
// Caso não seja encontrado o cnpj, irá retornar um errors.CorretoraError
pub fn get_corretora_by_cnpj(cnpj_code_ string) !Corretora {
	mut cnpj_code := cnpj_code_

	for chr in ['.', '/', '-', ' '] {
		cnpj_code = cnpj_code.replace(chr, '')
	}

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

	return json.decode(Corretora, resp.body) or { return CorretoraError{
		message: err.msg()
	} }
}
