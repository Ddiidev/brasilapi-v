module v1

import net.http
import fipe.errors { FipeError }
import json

// Para referências:  https://brasilapi.com.br/docs#tag/FIPE/paths/~1fipe~1marcas~1v1~1{tipoVeiculo}/get
const uri_marcas = 'https://brasilapi.com.br/api/fipe/marcas/v1'

// Para referências:  https://brasilapi.com.br/docs#tag/FIPE/paths/~1fipe~1preco~1v1~1{codigoFipe}/get
const uri_precos = 'https://brasilapi.com.br/api/fipe/preco/v1'

// Para referências: https://brasilapi.com.br/docs#tag/FIPE/paths/~1fipe~1tabelas~1v1/get
const uri_tabelas_referencia = 'https://brasilapi.com.br/api/fipe/tabelas/v1'

// Parâmetros para a função get_marcas
[params]
pub struct ParamMarcas {
pub:
	tipo_veiculo      TiposVeiculo [required]
	tabela_referencia ?i32
}

// Parâmetros para a função get_precos
[params]
pub struct ParamPrecos {
pub:
	codigo_fipe       string [required]
	tabela_referencia ?i32
}

// get_marcas Lista as marcas de veículos referente ao tipo de veículo
//
// https://brasilapi.com.br/docs#tag/FIPE/paths/~1fipe~1marcas~1v1~1%7BtipoVeiculo%7D/get
//
// Exemplos de uso:
// ```v
// // Ou referencie a tabela de referência -> fipe_.get_marcas(fipe_.TiposVeiculo.carro, 294)
// if marcas := fipe_.get_marcas(fipe_.TiposVeiculo.carro) {
// 	dump(marcas)
// } else {
// 	println(err)
// }
// ```
//
// Caso ocorra algum erro, será retornado um objeto do tipo FipeError
pub fn get_marcas(params ParamMarcas) ![]FipeMarcas {
	uri := match params.tabela_referencia {
		none { '${v1.uri_marcas}/${params.tipo_veiculo.str()}' }
		else { '${v1.uri_marcas}/${params.tipo_veiculo.str()}?tabela_referencia=${params.tabela_referencia?}' }
	}

	println(uri)
	resp := http.get(uri) or { return FipeError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(FipeError, resp.body) or { return FipeError{
			message: err.msg()
		} }
	}

	return json.decode([]FipeMarcas, resp.body) or { return FipeError{
		message: err.msg()
	} }
}

// get_precos Lista os preços de veículos segundo o código fipe
//
// https://brasilapi.com.br/docs#tag/FIPE/paths/~1fipe~1preco~1v1~1{codigoFipe}/get
//
// Exemplos de uso:
// ```v
// // Ou referencie a tabela de referência -> fipe_.get_precos('001001-0', 294)
// if precos := fipe_.get_precos('001001-0') {
// 	dump(precos)
// } else {
// 	println(err)
// }
// ```
//
// Caso ocorra algum erro, será retornado um objeto do tipo FipeError
pub fn get_precos(params ParamPrecos) ![]FipeVeiculo {
	uri := match params.tabela_referencia {
		none {
			'${v1.uri_precos}/${params.codigo_fipe}'
		}
		else {
			'${v1.uri_precos}/${params.codigo_fipe}?tabela_referencia=${params.tabela_referencia?}'
		}
	}

	resp := http.get(uri) or { return FipeError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(FipeError, resp.body) or { return FipeError{
			message: err.msg()
		} }
	}

	return json.decode([]FipeVeiculo, resp.body) or { return FipeError{
		message: err.msg()
	} }
}

// get_tabelas_referencia Lista as tabelas de referência existentes
//
// https://brasilapi.com.br/docs#tag/FIPE/paths/~1fipe~1tabelas~1v1/get
//
// Exemplos de uso:
// ```v
// if tabelas := fipe_.get_tabelas_referencia() {
// 	dump(tabelas)
// } else {
// 	println(err)
// }
// ```
//
// Caso ocorra algum erro, será retornado um objeto do tipo FipeError
pub fn get_tabelas_referencia() ![]FipeTabelaReferencia {
	resp := http.get(v1.uri_tabelas_referencia) or { return FipeError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(FipeError, resp.body) or { return FipeError{
			message: err.msg()
		} }
	}

	return json.decode([]FipeTabelaReferencia, resp.body) or {
		return FipeError{
			message: err.msg()
		}
	}
}
