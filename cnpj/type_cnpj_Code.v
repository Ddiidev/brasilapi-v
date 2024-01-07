module cnpj

pub type CNPJ = string

// remove_format_cnpj Remove caracteres especiais do CNPJ
pub fn (c CNPJ) remove_format_cnpj() string {
	mut cnpj_code := c

	for chr in ['.', '/', '-', ' '] {
		cnpj_code = cnpj_code.replace(chr, '')
	}

	return cnpj_code
}
