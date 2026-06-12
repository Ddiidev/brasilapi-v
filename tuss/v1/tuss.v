module v1

import json
import net.http
import net.urllib
import tuss.errors { TussError }

const uri = 'https://brasilapi.com.br/api/tuss/v1'

@[params]
pub struct ParamsGetTuss {
pub:
	name   ?string
	tuss   ?string
	limit  ?int
	offset ?int
}

@[params]
pub struct ParamsSearchTuss {
pub:
	q      ?string
	name   ?string
	tuss   ?string
	@match ?string
	sort   ?string
	order  ?string
	fields ?string
	limit  ?int
	offset ?int
}

@[params]
pub struct ParamsAutocompleteTuss {
pub:
	q     ?string
	name  ?string
	tuss  ?string
	limit ?int
}

fn query_value(value string) string {
	return urllib.path_escape(value)
}

fn get_query(params ParamsGetTuss) string {
	mut query := []string{}
	if name := params.name {
		query << 'name=${query_value(name)}'
	}
	if tuss := params.tuss {
		query << 'tuss=${query_value(tuss)}'
	}
	if limit := params.limit {
		query << 'limit=${limit}'
	}
	if offset := params.offset {
		query << 'offset=${offset}'
	}
	if query.len == 0 {
		return ''
	}
	return '?${query.join('&')}'
}

fn search_query(params ParamsSearchTuss) string {
	mut query := []string{}
	if q := params.q {
		query << 'q=${query_value(q)}'
	}
	if name := params.name {
		query << 'name=${query_value(name)}'
	}
	if tuss := params.tuss {
		query << 'tuss=${query_value(tuss)}'
	}
	if match_ := params.@match {
		query << 'match=${query_value(match_)}'
	}
	if sort := params.sort {
		query << 'sort=${query_value(sort)}'
	}
	if order := params.order {
		query << 'order=${query_value(order)}'
	}
	if fields := params.fields {
		query << 'fields=${query_value(fields)}'
	}
	if limit := params.limit {
		query << 'limit=${limit}'
	}
	if offset := params.offset {
		query << 'offset=${offset}'
	}
	if query.len == 0 {
		return ''
	}
	return '?${query.join('&')}'
}

fn autocomplete_query(params ParamsAutocompleteTuss) string {
	mut query := []string{}
	if q := params.q {
		query << 'q=${query_value(q)}'
	}
	if name := params.name {
		query << 'name=${query_value(name)}'
	}
	if tuss := params.tuss {
		query << 'tuss=${query_value(tuss)}'
	}
	if limit := params.limit {
		query << 'limit=${limit}'
	}
	if query.len == 0 {
		return ''
	}
	return '?${query.join('&')}'
}

// get Lista termos TUSS com suporte a busca por nome, código e paginação.
pub fn get(params ParamsGetTuss) !TussResponse {
	resp := http.get('${v1.uri}${get_query(params)}') or { return TussError{
		message: err.msg()
	} }

	if resp.status_code >= 500 {
		return error_with_code(resp.status_msg, resp.status_code)
	}

	if resp.status_code != 200 {
		return json.decode(TussError, resp.body) or { return TussError{
			message: err.msg()
		} }
	}

	return json.decode(TussResponse, resp.body) or { return TussError{
		message: err.msg()
	} }
}

// get_by_code Detalha um termo TUSS pelo código.
pub fn get_by_code(tuss string) !TussItem {
	resp := http.get('${v1.uri}/${urllib.path_escape(tuss)}') or { return TussError{
		message: err.msg()
	} }

	if resp.status_code >= 500 {
		return error_with_code(resp.status_msg, resp.status_code)
	}

	if resp.status_code != 200 {
		return json.decode(TussError, resp.body) or { return TussError{
			message: err.msg()
		} }
	}

	return json.decode(TussItem, resp.body) or { return TussError{
		message: err.msg()
	} }
}

// search Executa busca avançada de termos TUSS.
pub fn search(params ParamsSearchTuss) !TussResponse {
	resp := http.get('${v1.uri}/search${search_query(params)}') or { return TussError{
		message: err.msg()
	} }

	if resp.status_code >= 500 {
		return error_with_code(resp.status_msg, resp.status_code)
	}

	if resp.status_code != 200 {
		return json.decode(TussError, resp.body) or { return TussError{
			message: err.msg()
		} }
	}

	return json.decode(TussResponse, resp.body) or { return TussError{
		message: err.msg()
	} }
}

// autocomplete Retorna sugestões de termos TUSS a partir de texto livre.
pub fn autocomplete(params ParamsAutocompleteTuss) ![]TussItem {
	resp := http.get('${v1.uri}/autocomplete${autocomplete_query(params)}') or { return TussError{
		message: err.msg()
	} }

	if resp.status_code >= 500 {
		return error_with_code(resp.status_msg, resp.status_code)
	}

	if resp.status_code != 200 {
		return json.decode(TussError, resp.body) or { return TussError{
			message: err.msg()
		} }
	}

	return json.decode([]TussItem, resp.body) or { return TussError{
		message: err.msg()
	} }
}
