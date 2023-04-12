module v1

import json
import net.http
import isbn.errors { IsbnError }

// Para referência https://brasilapi.com.br/docs#tag/ISBN/paths/~1isbn~1v1~1{isbn}/get
const uri_isbn = 'https://brasilapi.com.br/api/isbn/v1'

[params]
pub struct ParamGet {
pub:
	isbn     string   [required]
	provider Provider = Provider.google_books | .cbl | .open_library | .mercado_editorial
}

// get Informações sobre o livro a partir do ISBN
// Caso o provider não seja especificado o padrão é todos os provedores disponíveis.
// <br/>
// https://brasilapi.com.br/docs#tag/ISBN/paths/~1isbn~1v1~1%7Bisbn%7D/get
//
// Exemplo de uso:
//
// ```v
// // get(isbn: '9788532530831', provider: Provider.cbl | .mercado_editorial) {
// if book := isbn.get(isbn: '9788532530831') {
// 	println(book)
// } else {
// 	println(err)
// }
// ```
//
// Caso ocorra algum erro, o retorno será um objeto do tipo `IsbnError`
pub fn get(param ParamGet) !ISBN {
	isbn := param.isbn
	if isbn.len != 10 && isbn.len != 13 {
		return IsbnError{
			message: 'O ISBN deve ter 10 ou 13 caracteres'
		}
	}

	uri := '${v1.uri_isbn}/${isbn}?providers=${param.provider.get_names_setad().join(',')}'

	resp := http.get(uri) or { return IsbnError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(IsbnError, resp.body) or { return IsbnError{
			message: err.msg()
		} }
	}

	temp_isbn := json.decode(ISBN_, resp.body) or { return IsbnError{
		message: err.msg()
	} }

	return ISBN{
		isbn: temp_isbn.isbn
		authors: temp_isbn.authors
		cover_url: temp_isbn.cover_url
		dimensions: temp_isbn.dimensions
		subtitle: temp_isbn.subtitle
		format: temp_isbn.format
		page_count: temp_isbn.page_count
		publisher: temp_isbn.publisher
		location: temp_isbn.location
		retail_price: temp_isbn.retail_price
		synopsis: temp_isbn.synopsis
		title: temp_isbn.title
		subjects: temp_isbn.subjects
		year: temp_isbn.year
		provider: get_enum_by_name(temp_isbn.provider) or { panic(err) }
	}
}
