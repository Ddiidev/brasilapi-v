module v1

import net.http
import json
import cnpj.errors
import cnpj { CNPJ }

const uri = 'https://brasilapi.com.br/api/cnpj/v1'

// get_cnpj Retorna os dados do CNPJ(Cadastro Nacional da Pessoa Jurídica)
//
// https://brasilapi.com.br/docs#tag/CNPJ
//
// Exemplo de uso:
// ```
// if cnpj_ := cnpj.get_cnpj('34925681000110') {
// 	dump(cnpj_)
// } else {
// 	// print message error
// 	println(err)
// }
// ```
//
// Caso CNPJ não seja encontrado, então irá ser retornado um objeto de erro "errors.CnpjError"
pub fn get_cnpj(cnpj_code_ CNPJ) !Cnpj {
	mut cnpj_code := cnpj_code_.remove_format_cnpj()

	resp := http.get('${v1.uri}/${cnpj_code}') or {
		return errors.CnpjError{
			message: err.msg()
		}
	}

	if resp.status_code == 400 {
		return json.decode(errors.CnpjError, resp.body) or {
			return errors.CnpjError{
				message: err.msg()
			}
		}
	}

	return json.decode(Cnpj, resp.body)
}
