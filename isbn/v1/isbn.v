module v1

import json
import net.http
import isbn.errors  { IsbnError }


// Para referência https://brasilapi.com.br/docs#tag/ISBN/paths/~1isbn~1v1~1{isbn}/get
const uri_isbn = "https://brasilapi.com.br/api/isbn/v1"


[params]
struct ParamGet {
	isbn string [required]
	provider ?Provider
}

// get Informações sobre o livro a partir do ISBN
//
//
pub fn get(param ParamGet) !ISBN {
	isbn := param.isbn
	provider :=


	if isbn.len != 10 && isbn.len != 13 {
		return IsbnError{
			message: "O ISBN deve ter 10 ou 13 caracteres"
		}
	}

	// uri :=

	resp := http.get(uri) or { return IsbnError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(IsbnError, resp.body) or { return IsbnError{
			message: err.msg()
		} }
	}

	temp_isbn := json.decode(ISBN_, resp.body) or { return FipeError{
		message: err.msg()
	} }

	return ISBN{
		isbn: temp_isbn.isbn
		authors: temp_isbn.autors
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
		provider: names_provider[temp_isbn.provider]
	}

}

