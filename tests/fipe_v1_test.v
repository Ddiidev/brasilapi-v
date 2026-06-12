module tests

import fipe.v1 as fipe_
import fipe.errors

fn test_listar_tabelas_de_referencia() {
	if tabelas := fipe_.get_tabelas_referencia() {
		assert tabelas.len > 0
	} else {
		if err.code() >= 500 {
			assert true
		} else {
			assert false, err.msg()
		}
	}
}

fn test_get_precos_veiculos_when_codigo_fipe_invalid() {
	codigo_fipe := '038003-0'

	if precos := fipe_.get_precos(codigo_fipe: codigo_fipe) {
		assert false
	} else {
		assert true
	}
}

fn test_get_precos_veiculos_when_codigo_fipe_valid() {
	tabela_referencia := 294
	codigo_fipe := '038003-2'

	if precos := fipe_.get_precos(codigo_fipe: codigo_fipe, tabela_referencia: tabela_referencia) {
		assert precos.len > 0
		assert precos.all(it.marca == 'Acura')
	} else {
		if err.code() >= 500 {
			assert true
		} else {
			assert false, err.msg()
		}
	}
}

fn test_get_marcas_valid() {
	tipo_veiculo := fipe_.TiposVeiculo.caminhoes

	if marcas := fipe_.get_marcas(tipo_veiculo: tipo_veiculo) {
		assert true
	} else {
		if err.code() >= 500 {
			assert true
		} else {
			assert false, err.msg()
		}
	}
}

fn test_object_error_when_data_invalid() {
	tabela_referencia := 0
	tipo_veiculo := fipe_.TiposVeiculo.motos

	if marcas := fipe_.get_marcas(tipo_veiculo: tipo_veiculo, tabela_referencia: tabela_referencia) {
		assert false
	} else {
		if err is errors.FipeError {
			assert err.@type == 'bad_request'
				&& ['Tabela', 'inválida'].all(err.message.contains(it))
		} else if err.code() >= 500 {
			assert true
		} else {
			assert false, err.msg()
		}
	}
}

fn test_get_veiculos_valid() {
	tipo_veiculo := fipe_.TiposVeiculo.carros
	codigo_marca := 21

	if veiculos := fipe_.get_veiculos(tipo_veiculo: tipo_veiculo, codigo_marca: codigo_marca) {
		assert veiculos.len > 0
		assert veiculos.any(it.modelo != '')
	} else {
		if err.code() >= 500 {
			assert true
		} else {
			assert false, err.msg()
		}
	}
}
