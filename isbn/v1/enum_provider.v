module v1

import utils

[flag]
pub enum Provider {
	cbl
	mercado_editorial
	open_library
	google_books
}

const names_provider = {
	Provider.cbl:               'cbl'
	Provider.mercado_editorial: 'mercado-editorial'
	Provider.open_library:      'open-library'
	Provider.google_books:      'google-books'
}

pub fn get_enum_by_name(name string) !Provider {
	for key, v in v1.names_provider {
		if v == name {
			return key
		}
	}

	return error('Provider not found')
}

pub fn (p Provider) get_names_setad() []string {
	return utils.get_names_enum_setad[Provider](type_enum: p, source_data: v1.names_provider)
}
