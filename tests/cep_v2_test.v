module tests

import cep.v2 as cep
import cep.errors

fn test_cep_code_valid() ! {
	cep_code := '58065051'
	cep_ := cep.get(cep_code)!

	assert cep_.cep == cep_code
	assert cep_.state == 'PB'
	assert cep_.city == 'João Pessoa'
	assert cep_.location.coordinates.longitude != ''
	assert cep_.location.coordinates.latitude != ''
}

fn test_cep_code_invalid_number() ! {
	cep_code := '00063520'
	if cep_ := cep.get(cep_code) {
		// Caso tenha encontrado algo, o que enquadraria em um erro
		// visto que o cep é inválido.
		assert false
	} else {
		assert true
	}
}

fn test_cep_code_invalid_empty() ! {
	cep_code := ''
	if cep_ := cep.get(cep_code) {
		// Caso tenha encontrado algo, o que enquadraria em um erro
		// visto que o cep é inválido.
		assert false
	} else {
		assert true
	}
}

fn test_object_error_when_zip_code_is_invalid() ! {
	cep_code := '00063520'
	if cep_ := cep.get(cep_code) {
		assert false
	} else {
		if err is errors.CepError {
			assert err.@type == 'service_error'
			assert err.errors.len > 0
		}
	}
}
