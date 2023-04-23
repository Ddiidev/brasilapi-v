module tests

import registro_br.v1 as registro_br
import registro_br.errors { RegistroBrError }

fn test_domain_registered() {
	domaing := 'brasilapi.com.br'
	if status_domain := registro_br.domain_registered(domaing) {
		assert status_domain.status_code == 2 && status_domain.status == 'REGISTERED'
			&& status_domain.fqdn == domaing
	} else {
		assert false
	}
}

fn test_domain_not_registered() {
	domaing := 'brasilwithoutapi.com.br'
	if status_domain := registro_br.domain_registered(domaing) {
		assert false
	} else {
		assert true
		if err is RegistroBrError {
			assert err.status_code != 2 && err.fqdn == domaing
		}
	}
}

fn test_domain_is_blank() {
	domaing := ''
	if status_domain := registro_br.domain_registered(domaing) {
		assert false
	} else {
		assert true
		if err is RegistroBrError {
			assert err.status_code == 0 && err.fqdn == domaing
		}
	}
}
