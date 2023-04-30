module tests

import banks.v1 as banks
import banks.errors

fn test_bank_valid() {
	codigo := 1

	if bank := banks.get(codigo) {
		assert bank.code == codigo
		assert bank.full_name == 'Banco do Brasil S.A.', 'Possível falha no teste'
	} else {
		assert false
	}
}

fn test_bank_invalid() {
	codigo := 0

	if bank := banks.get(codigo) {
		assert false
	} else {
		assert true
	}
}

fn test_object_error_when_bank_is_invalid() {
	codigo := 0

	if bank := banks.get(codigo) {
		assert false
	} else {
		if err is errors.BanksError {
			assert true
			assert err.@type == 'BANK_CODE_NOT_FOUND'
		}
	}
}

fn test_return_all_banks() {
	if banks_ := banks.get_all() {
		assert true
		assert banks_.len > 0
	} else {
		assert false
	}
}
