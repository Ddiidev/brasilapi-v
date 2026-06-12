module tests

import tuss.v1 as tuss
import tuss.errors

fn test_get_tuss() {
	if response := tuss.get(limit: 2) {
		assert response.items.len > 0
		assert response.limit == 2
	} else {
		if err.code() >= 500 {
			assert true
		} else if err is errors.TussError {
			assert false, err.msg()
		} else {
			assert false, err.msg()
		}
	}
}

fn test_get_tuss_by_code() {
	code := '10101012'

	if item := tuss.get_by_code(code) {
		assert item.tuss == code
		assert item.name != ''
	} else {
		if err.code() >= 500 {
			assert true
		} else if err is errors.TussError {
			assert false, err.msg()
		} else {
			assert false, err.msg()
		}
	}
}

fn test_search_tuss() {
	if response := tuss.search(q: 'consulta', limit: 2) {
		assert response.items.len > 0
	} else {
		if err.code() >= 500 {
			assert true
		} else if err is errors.TussError {
			assert false, err.msg()
		} else {
			assert false, err.msg()
		}
	}
}

fn test_autocomplete_tuss() {
	if items := tuss.autocomplete(q: 'consu', limit: 2) {
		assert items.len > 0
	} else {
		if err.code() >= 500 {
			assert true
		} else if err is errors.TussError {
			assert false, err.msg()
		} else {
			assert false, err.msg()
		}
	}
}
