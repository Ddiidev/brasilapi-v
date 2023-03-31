module tests

import corretora.v1 as corretora
import corretora.errors

fn test_get_all_corretoras() {
	if corretoras := corretora.get_all() {
		assert corretoras.len > 0
	} else {
		if err is errors.CorretoraError {
			assert false
		}
	}
}

fn test_get_corretora_by_cnpj() {
	cnpj_code := '24159923000159'

	if corretora_ := corretora.get_by_cnpj(cnpj_code) {
		assert corretora_.cnpj == cnpj_code && corretora_.@type == 'CORRETORAS'
	} else {
		if err is errors.CorretoraError {
			assert false
		}
	}
}

fn test_get_corretora_by_invalid_cnpj() {
	cnpj_code := '24159923000000'

	if corretora_ := corretora.get_by_cnpj(cnpj_code) {
		assert false
	} else {
		assert true
	}
}

fn test_object_error_when_cnpj_is_invalid() {
	cnpj_code := '24159923000000'

	if corretora_ := corretora.get_by_cnpj(cnpj_code) {
		assert false
	} else {
		if err is errors.CorretoraError {
			assert err.@type == 'exchange_error' && err.name == 'EXCHANGE_NOT_FOUND'
		}
	}
}
