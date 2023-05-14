module tests

import ncm.v1 as ncm
import ncm.errors { NcmError }

fn test_get_all_ncm() {
	if ncms := ncm.get() {
		assert ncms.len > 0
	} else {
		assert false
	}
}

fn test_search_ncm() {
	names := ['refrigerante', 'águas', 'cerveja', 'vinhos espumosos']

	for name in names {
		if ncms := ncm.get(search: name) {
			assert ncms.first().descricao.contains(name)
		} else {
			assert false, 'ncm(${name}) not found'
		}
	}
}

fn test_get_ncm_by_code() {
	codes := ['22021000', '33051000']

	for code in codes {
		if ncms := ncm.get(code: code) {
			assert ncms.first().codigo.replace('.', '') == code, 'code ncm(${code}) not found'
		} else {
			assert false, 'code ncm(${code}) not found'
		}
	}
}

fn test_get_ncm_by_invalid_code() {
	code := '220210333'

	ncm.get(code: code) or {
		assert true
		if err is NcmError {
			assert err.@type == 'NCM_CODE_NOT_FOUND'
		}
		return
	}

	assert false
}
