module tests

import taxas.v1 as taxas_

fn test_taxas() {
	if taxas := taxas_.get() {
		assert taxas.len > 0 && taxas.any(it.nome == 'Selic')
	} else {
		if err.code() >= 500 {
			assert true
		} else {
			assert false, err.msg()
		}
	}
}

fn test_taxa_by_sigla() {
	if taxa := taxas_.get_by_sigla('Selic') {
		assert taxa.nome == 'Selic'
	} else {
		if err.code() >= 500 {
			assert true
		} else {
			assert false, err.msg()
		}
	}
}

fn test_taxa_by_sigla_invalid() {
	if taxa := taxas_.get_by_sigla('invalid') {
		assert false
	} else {
		assert true
	}
}
