module v1

import time

struct TempPix {
pub:
	ispb                    string
	nome                    string
	nome_reduzido           string
	modalidade_participacao string
	tipo_participacao       string
	inicio_operacao         string
}

pub struct Pix {
pub:
	ispb                    string
	nome                    string
	nome_reduzido           string
	modalidade_participacao string
	tipo_participacao       string
	inicio_operacao         time.Time
}

pub fn (temp_pix []TempPix) get_pixs() ![]Pix {
	date_default := time.Time{}

	return temp_pix.map(fn [date_default] (t TempPix) Pix {
		return Pix{
			ispb: t.ispb
			nome: t.nome
			nome_reduzido: t.nome_reduzido
			modalidade_participacao: t.modalidade_participacao
			tipo_participacao: t.tipo_participacao
			inicio_operacao: time.parse_iso8601('${t.inicio_operacao}') or { date_default }
		}
	})
}
