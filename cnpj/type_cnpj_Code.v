module cnpj

pub type CNPJ = string

// remove_format_cnpj Remove caracteres especiais do CNPJ
pub fn (cnpj CNPJ) remove_format_cnpj() string {
	mut cnpj_code := cnpj

	for chr in ['.', '/', '-', ' '] {
		cnpj_code = cnpj_code.replace(chr, '')
	}

	return cnpj_code
}
