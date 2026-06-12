module tests

import fundos.v1 as fundos
import fundos.errors

fn test_get_fundos() {
	if response := fundos.get(page: 1, size: 3) {
		assert response.data.len > 0
		assert response.page == 1
		assert response.size == 3
	} else {
		if err.code() >= 500 {
			assert true
		} else if err is errors.FundosError {
			assert false, err.msg()
		} else {
			assert false, err.msg()
		}
	}
}

fn test_get_fundo_by_cnpj() {
	cnpj := '00.000.732/0001-81'

	if fundo := fundos.get_by_cnpj(cnpj) {
		assert fundo.cnpj == cnpj
		assert fundo.codigo_cvm != ''
	} else {
		if err.code() >= 500 {
			assert true
		} else if err is errors.FundosError {
			assert false, err.msg()
		} else {
			assert false, err.msg()
		}
	}
}
