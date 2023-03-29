module tests

import cnpj { CNPJ }

fn test_cnpj_to_removed_format() {
	cnpj_code_without_format := '34925681000110'
	cnpj_code_with_format := CNPJ('34.925.681/0001-10')

	assert cnpj_code_with_format.remove_format_cnpj() == cnpj_code_without_format
}
