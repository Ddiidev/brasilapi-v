module v1

import json
import net.http
import banks.errors { BanksError }

// https://brasilapi.com.br/docs#tag/BANKS
const uri = 'https://brasilapi.com.br/api/banks/v1'

// get_all Retorna uma lista com todos os bancos no Brasil
//
// https://brasilapi.com.br/docs#tag/BANKS/paths/~1banks~1v1/get
//
// Exemplo de uso:
// ```v
// if banks := banks_.get_all_banks() {
//  dump(banks)
// } else {
//  println(err) //print message error
// }
// ```
//
// Caso ocorra alguma falha irá retornar um errors.BankError
fn get_all() ![]Bank {
	resp := http.get(v1.uri) or { return BanksError{
		message: err.msg()
	} }

	if resp.status_code != 200 {
		return json.decode(BanksError, resp.body) or {
			return BanksError{
				message: err.msg()
			}
		}
	}

	return json.decode([]Bank, resp.body) or { return BanksError{
		message: err.msg()
	} }
}

// get Busca as informações de um banco a partir de um código
//
// https://brasilapi.com.br/docs#tag/BANKS/paths/~1banks~1v1~1{code}/get
//
// Exemplo de uso:
// ```
// if bank := banks_.get_bank(1) {
//  dump(bank)
// } else {
//  println(err) //print message error
// }
// ```
//
// Caso não seja encontrado um banco irá retornar um errors.BankError
fn get(code int) !Bank {
	resp := http.get('${v1.uri}/${code}') or { return BanksError{
		message: err.msg()
	} }

	if resp.status_code == 404 {
		return json.decode(BanksError, resp.body) or {
			return BanksError{
				message: err.msg()
			}
		}
	}

	return json.decode(Bank, resp.body) or { return BanksError{
		message: err.msg()
	} }
}
