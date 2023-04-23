module tests

import taxas.v1 as taxas_

fn test_taxas() {
	if taxas := taxas_.get() {
		assert taxas.len > 0 && taxas.any(it.nome == 'Selic')
	} else {
		assert false
	}
}
