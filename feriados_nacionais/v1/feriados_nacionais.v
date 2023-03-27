module v1

import net.http
import feriados_nacionais.errors
import json
import time

// https://brasilapi.com.br/docs#tag/Feriados-Nacionais
const uri = 'https://brasilapi.com.br/api/feriados/v1/'

pub fn get_feriados_nacionais(year string) ![]FeriadoNacional {
	resp := http.get('${v1.uri}/${year}') or {
		return errors.FeriadosNacionaisError{
			message: err.msg()
		}
	}

	if resp.status_code in [404, 500] {
		return json.decode(errors.FeriadosNacionaisError, resp.body) or {
			return errors.FeriadosNacionaisError{
				message: err.msg()
			}
		}
	}

	mut js := json.decode([]FeriadoNacional, resp.body) or {
		return errors.FeriadosNacionaisError{
			message: err.msg()
		}
	}

	js = js.map(fn (f FeriadoNacional) FeriadoNacional {
		feriado := FeriadoNacional{
			...f
			date: time.parse('${f.date_str} 00:00:00.000') or { time.now() }
		}

		return feriado
	})

	return js
}
