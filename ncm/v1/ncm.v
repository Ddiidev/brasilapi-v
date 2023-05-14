module v1

import json
import net.http
import ncm.errors { NcmError }
import net.urllib

// https://brasilapi.com.br/docs#tag/NCM
const uri_ncm = 'https://brasilapi.com.br/api/ncm/v1'

[params]
pub struct ParamGet {
	// search Busca pelo código NCM ou descrição.
	search ?string
	// busca por um código NCM específico.
	code ?string
}

// get Retorna informações de todos os NCMs.
//
// https://brasilapi.com.br/docs#tag/NCM/paths/~1ncm~1v1/get
//
// Exemplo de uso:
// ```v
// if ncms := ncm.get() {
//  dump(ncms)
// } else {
//  println(err) //print message error
// }
// ```
//
// Caso ocorra alguma falha irá retornar um errors.NcmError
pub fn get(find ParamGet) ![]Ncm {
	uri := if find.search != none {
		search := urllib.path_escape(find.search?.str())
		'${v1.uri_ncm}?search=${search}'
	} else if find.code != none {
		'${v1.uri_ncm}/${find.code?.str()}'
	} else {
		v1.uri_ncm
	}

	resp := http.get(uri) or { return NcmError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(NcmError, resp.body) or { return NcmError{
			message: err.msg()
		} }
	}

	if find.code != none {
		ncm := json.decode(Ncm, resp.body) or { return NcmError{
			message: err.msg()
		} }

		return [ncm]
	} else {
		return json.decode([]Ncm, resp.body) or { return NcmError{
			message: err.msg()
		} }
	}
}
