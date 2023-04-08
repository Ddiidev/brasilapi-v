module v1

import net.http
import registro_br.errors { RegistroBrError }
import json

// Para referência:  https://brasilapi.com.br/docs#tag/REGISTRO-BR/paths/~1registrobr~1v1~1{domain}/get
const uri = 'https://brasilapi.com.br/api/registrobr/v1'

// domain_registered avalia o status de um dominio .br
//
// https://brasilapi.com.br/docs#tag/REGISTRO-BR/paths/~1registrobr~1v1~1{domain}/get
//
// Exemplos de uso:
// ```v
// if status_domain := registro_br.get('brasilapi.com.br') {
// 	dump(status_domain)
// } else {
// 	println(err)
// }
// ```
//
// Caso ocorra algum erro, será retornado um objeto do tipo RegistroBrError
pub fn domain_registered(domain string) !RegistroBr {
	if domain.is_blank() {
		return RegistroBrError{
			message: 'O domínio não pode ser vazio'
		}
	}

	resp := http.get('${v1.uri}/${domain}') or { return RegistroBrError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(RegistroBrError, resp.body) or {
			return RegistroBrError{
				message: err.msg()
			}
		}
	}

	status_domain := json.decode(RegistroBr, resp.body) or {
		return RegistroBrError{
			message: err.msg()
		}
	}

	if status_domain.status_code != 2 {
		return RegistroBrError{
			status_code: status_domain.status_code
			message: status_domain.status
			status: status_domain.status
			expires_at: status_domain.expires_at
			hosts: status_domain.hosts
			fqdn: status_domain.fqdn
			publication_status: status_domain.publication_status
			suggestions: status_domain.suggestions
		}
	}

	return status_domain
}
