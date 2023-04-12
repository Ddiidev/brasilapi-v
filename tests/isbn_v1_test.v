module tests

import isbn.v1 as isbn
import isbn.errors

fn test_info_sobre_livro_valid() {
	codigo_isbn := '9788545702870'

	if livro := isbn.get(isbn: codigo_isbn) {
		assert livro.isbn == codigo_isbn
	} else {
		assert false
	}
}

fn test_info_sobre_livro_invalido() {
	codigo_isbn := '9788545702871'

	if livro := isbn.get(isbn: codigo_isbn) {
		assert false
	} else {
		assert err is errors.IsbnError
	}
}

fn test_objeto_erro_isbn_invalido() {
	codigo_isbn := '9788545702871'

	if livro := isbn.get(isbn: codigo_isbn) {
		assert false
	} else {
		if err is errors.IsbnError {
			assert true
			assert err.@type == 'bad_request' && err.message == 'ISBN inválido'
		} else {
			assert false
		}
	}
}
