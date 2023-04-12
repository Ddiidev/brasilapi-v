module v1

pub enum Provider {
	cbl
	mercado_editorial
	open_library
	google_books

}

const names_provider = {
	'cbl': Provider.cbl,
	'mercado-editorial': Provider.mercado_editorial,
	'open-library': Provider.open_library,
	'google-books': Provider.google_books
}
