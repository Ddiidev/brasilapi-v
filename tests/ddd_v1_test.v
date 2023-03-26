module tests

import ddd.v1 as ddd
import ddd.errors

fn test_ddd_valid() {
	state := "PB"
	ddd_code := "83"

	if detail := ddd.get_ddd(ddd_code) {
		assert detail.state == state
	} else {
		assert false
	}

}

fn test_ddd_invalid() {
	ddd_code := "00"

	if detail := ddd.get_ddd(ddd_code) {
		assert false
	} else {
		assert true
	}
}

fn test_object_error_when_ddd_is_invalid() {
	ddd_code := "00"

	if detail := ddd.get_ddd(ddd_code) {
		assert false
	} else {
		if err is errors.DddError {
			assert err.@type == "ddd_error" && err.name == "DDD_NOT_FOUND"
		} else {
			assert false
		}
	}
}

