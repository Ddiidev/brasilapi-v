module tests

import cambio.v1 as cambio
import cambio.errors

fn test_get_moedas() {
	if moedas := cambio.get_moedas() {
		assert moedas.len > 0
		assert moedas.any(it.simbolo == 'USD')
	} else {
		if err.code() >= 500 {
			assert true
		} else if err is errors.CambioError {
			assert false, err.msg()
		} else {
			assert false, err.msg()
		}
	}
}

fn test_get_cotacao() {
	if cotacao := cambio.get_cotacao('USD', '2025-02-13') {
		assert cotacao.moeda == 'USD'
		assert cotacao.data == '2025-02-13'
		assert cotacao.cotacoes.len > 0
	} else {
		if err.code() >= 500 {
			assert true
		} else if err is errors.CambioError {
			assert false, err.msg()
		} else {
			assert false, err.msg()
		}
	}
}
