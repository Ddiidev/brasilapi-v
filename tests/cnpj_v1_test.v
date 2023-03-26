module tests

import cnpj.v1 as cnpj
import cnpj.errors

fn test_cnpj_valid() {
	cnpj_code := '34925681000110'
	

	if cnpj_code_ := cnpj.get_cnpj(cnpj_code) {
		dump(cnpj_code_.razao_social)
		assert cnpj_code_.cnpj == cnpj_code && cnpj_code_.razao_social.starts_with('BAR DO CUSCUZ')
	} else {
		assert false
	}
}

fn test_cnpj_invalid() {
	cnpj_code := '34925681000000'

	if cnpj_code_ := cnpj.get_cnpj(cnpj_code) {
		assert false
	} else {
		assert true
	}
}

fn test_object_error_when_cnpj_is_invalid() ! {
	cnpj_code := '34925681000000'

	if cnpj_code_ := cnpj.get_cnpj(cnpj_code) {
		assert false
	} else {
		if err is errors.CnpjError {
			assert true

			assert err.@type == 'bad_request' && err.name == 'BadRequestError'
				&& err.message.ends_with('inválido.')
		}
	}
}
