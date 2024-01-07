module v1

pub struct FipeVeiculo {
pub:
	valor             string
	marca             string
	modelo            string
	ano_modelo        string @[json: 'anoModelo']
	combustivel       string
	codigo_fipe       string @[json: 'codigoFipe']
	mes_referencia    string @[json: 'mesReferencia']
	tipo_veiculo      string @[json: 'tipoVeiculo']
	sigla_combustivel string @[json: 'siglaCombustivel']
	data_consulta     string @[json: 'dataConsulta']
}
