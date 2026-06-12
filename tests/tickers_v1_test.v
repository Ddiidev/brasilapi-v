module tests

import tickers.v1 as tickers
import tickers.errors

fn test_get_tickers_acoes() {
	if acoes := tickers.get_acoes() {
		assert acoes.len > 0
	} else {
		if err.code() >= 500 {
			assert true
		} else if err is errors.TickersError {
			assert false, err.msg()
		} else {
			assert false, err.msg()
		}
	}
}

fn test_get_tickers_fundos() {
	if fundos := tickers.get_fundos(.fii) {
		assert fundos.len > 0
	} else {
		if err.code() >= 500 {
			assert true
		} else if err is errors.TickersError {
			assert false, err.msg()
		} else {
			assert false, err.msg()
		}
	}
}
