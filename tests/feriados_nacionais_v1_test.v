module tests

import feriados_nacionais.v1 as feriados_nacionais
import feriados_nacionais.errors


fn test_feriado_valid() {

	ano := "2023"

	if feriados := feriados_nacionais.get_feriados_nacionais(ano) {
		assert feriados.len > 0
	} else {
		assert false
	}
}


fn test_feriado_invalid() {

	ano := "1500"

	if feriados := feriados_nacionais.get_feriados_nacionais(ano) {
		assert false
	} else {
		assert true
	}
}

fn test_object_error_when_feriado_is_invalid() {

	ano := "1550"

	if feriados := feriados_nacionais.get_feriados_nacionais(ano) {
		assert false
	} else {
		if err is errors.FeriadosNacionaisError {
			assert err.@type == "feriados_range_error" && err.name == "NotFoundError"
		}
	}
}
