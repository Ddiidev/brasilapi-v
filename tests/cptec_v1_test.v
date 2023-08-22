module tests

import cptec.v1 as cptec
import cptec.errors

fn test_get_all_citys() {
	if cidades := cptec.cidades() {
		assert cidades.len > 0
	} else {
		assert false
	}
}

fn test_get_city_by_name() {
	city_name := 'São Bento'

	if cidades := cptec.cidades(city_name: city_name) {
		assert cidades.len > 0
	} else {
		assert false
	}
}

fn test_city_name_invalid() {
	city_name := 'fail'

	if cidade := cptec.cidades(city_name: city_name) {
		assert false
	} else {
		assert true
	}
}

fn test_get_all_capitais() {
	if climas := cptec.clima_capital() {
		assert climas.len > 0
	} else {
		assert false
	}
}

/*
Testes de clima por cidade
*/
fn test_get_clima_aeroporto_by_code() {
	icao := 'SBAR'

	if clima := cptec.clima_aeroporto(icao) {
		assert clima.codigo_icao == icao
	} else {
		assert false
	}
}

fn test_get_clima_aeroporto_by_code_invalid() {
	icao := '--'

	if _ := cptec.clima_aeroporto(icao) {
		assert false
	} else {
		assert true
	}
}

/*
Testes a previsões de cidades
*/
fn test_get_previsao_cidade() {
	code := 245

	if previsao := cptec.previsao_cidade(city_code: code) {
		assert previsao.clima.len > 0
	} else {
		assert false
	}
}

fn test_get_previsao_cidade_with_code_invalid() {
	code := 0

	if previsao := cptec.previsao_cidade(city_code: code) {
		assert false
	} else {
		assert true
	}
}

fn test_get_previsao_cidade_with_3_days() {
	code := 245
	days := i16(3)

	if previsao := cptec.previsao_cidade(city_code: code, days: days) {
		assert previsao.clima.len == 3
	} else {
		assert false
	}
}

fn test_get_previsao_cidade_with_0_days() {
	code := 245
	days := i16(0)

	if previsao := cptec.previsao_cidade(city_code: code, days: days) {
		assert false
	} else {
		assert true
	}
}

/*
Testes a previsões oceânicas
*/
fn test_get_previsao_oceanica() {
	code := 241

	if previsao := cptec.previsao_oceanica(city_code: code) {
		assert previsao.ondas.len > 0
	} else {
		assert false
	}
}

fn test_get_previsao_oceanicas_with_code_invalid() {
	code := 0

	if previsao := cptec.previsao_oceanica(city_code: code) {
		assert false
	} else {
		assert true
	}
}

fn test_get_previsao_oceanicas_with_3_days() {
	code := 241
	days := i16(3)

	if previsao := cptec.previsao_oceanica(city_code: code, days: days) {
		assert previsao.ondas.len == 3
	} else {
		assert false
	}
}

fn test_get_previsao_oceanicas_with_0_days() {
	code := 241
	days := i16(0)

	if previsao := cptec.previsao_oceanica(city_code: code, days: days) {
		assert false
	} else {
		assert true
	}
}

fn test_object_error_when_city_name_is_invalid() {
	city_name := 'fail'

	if cidade := cptec.cidades(city_name: city_name) {
		assert false
	} else {
		assert true
		if err is errors.CptecError {
			assert err.name == 'NO_CITY_NOT_FOUND' && err.@type == 'city_error'
		}
	}
}
