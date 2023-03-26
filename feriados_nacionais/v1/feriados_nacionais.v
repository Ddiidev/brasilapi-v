module v1

import net.http
import feriados_nacionais.errors
import json

// https://brasilapi.com.br/docs#tag/Feriados-Nacionais
const uri = "https://brasilapi.com.br/api/feriados/v1/"


pub fn get_feriados_nacionais(year string) ![]FeriadosNacional {

	resp := http.get('$uri/$year') or {
		return errors.FeriadosNacionaisError {
			message: err.msg()
		}
	}

	if resp.status_code in [404, 500] {
		return json.decode(errors.FeriadosNacionaisError, resp.body) or {
			return errors.FeriadosNacionaisError {
				message: err.msg()
			}
		}
	}

	return json.decode([]FeriadosNacional, resp.body) or {
		return errors.FeriadosNacionaisError {
			message: err.msg()
		}
	}

}
