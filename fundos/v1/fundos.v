module v1

import fundos.errors { FundosError }
import json
import net.http
import net.urllib

const uri = 'https://brasilapi.com.br/api/cvm/fundos/v1'

@[params]
pub struct ParamsGetFundos {
pub:
	page ?int
	size ?int
}

fn build_query(params ParamsGetFundos) string {
	mut query := []string{}
	if page := params.page {
		query << 'page=${page}'
	}
	if size := params.size {
		query << 'size=${size}'
	}
	if query.len == 0 {
		return ''
	}
	return '?${query.join('&')}'
}

// get Retorna lista paginada de fundos de investimentos registrados na CVM.
pub fn get(params ParamsGetFundos) !FundosResponse {
	resp := http.get('${v1.uri}${build_query(params)}') or {
		return FundosError{
			message: err.msg()
		}
	}

	if resp.status_code >= 500 {
		return error_with_code(resp.status_msg, resp.status_code)
	}

	if resp.status_code != 200 {
		return json.decode(FundosError, resp.body) or {
			return FundosError{
				message: err.msg()
			}
		}
	}

	return json.decode(FundosResponse, resp.body) or {
		return FundosError{
			message: err.msg()
		}
	}
}

// get_by_cnpj Busca detalhes de um fundo na CVM pelo CNPJ.
pub fn get_by_cnpj(cnpj string) !Fundo {
	resp := http.get('${v1.uri}/${urllib.path_escape(cnpj)}') or {
		return FundosError{
			message: err.msg()
		}
	}

	if resp.status_code >= 500 {
		return error_with_code(resp.status_msg, resp.status_code)
	}

	if resp.status_code != 200 {
		return json.decode(FundosError, resp.body) or {
			return FundosError{
				message: err.msg()
			}
		}
	}

	return json.decode(Fundo, resp.body) or {
		return FundosError{
			message: err.msg()
		}
	}
}
