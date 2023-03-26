module utils

pub fn adjust_string_cnpj(cnpj_code_ string) string {
	mut cnpj_code := cnpj_code_

	for chr in ['.', '/', '-', ' '] {
		cnpj_code = cnpj_code.replace(chr, '')
	}

	return cnpj_code
}
