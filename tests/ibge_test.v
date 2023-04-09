module tests

import ibge.v1 as ibge
import ibge.errors

fn test_retorno_unidades_federativas() {
	if municipios := ibge.get_municipios(uf: 'PB', providers: .wikipedia | .gov) {
		assert municipios.len > 0
		assert !municipios[0].nome.is_blank() && !municipios[0].codigo_ibge.is_blank()
	} else {
		assert false
	}
}

fn test_retorno_todos_estados() {
	if estados := ibge.get_estados() {
		assert estados.len > 0
	} else {
		assert false
	}
}

fn test_retornar_estado_por_sigla() {
	uf := 'PB'

	if estado := ibge.get_estado_por_sigla_ou_codigo(uf) {
		assert estado.sigla == uf
	} else {
		assert false
	}
}

fn test_retornar_estado_por_codigo() {
	codigo := 25

	if estado := ibge.get_estado_por_sigla_ou_codigo(codigo) {
		assert estado.id == codigo
	} else {
		assert false
	}
}

fn test_retornos_erros() {
	codigo := 0

	if estado := ibge.get_estado_por_sigla_ou_codigo(codigo) {
		assert false
	} else {
		assert true
		if err is errors.IBGEError {
			assert err.@type == 'not_found'
		}
	}
}
