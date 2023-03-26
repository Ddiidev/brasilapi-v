module tests

import utils

fn test_adjust_string_cnpj_to_removed_format() {

	cnpj_code_without_format := "34925681000110"
	cnpj_code_with_format := "34.925.681/0001-10"

	assert utils.adjust_string_cnpj(cnpj_code_with_format) == cnpj_code_without_format
}
