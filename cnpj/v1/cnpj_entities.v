module v1

pub struct Cnpj {
pub:
	uf  string
	cep string
	qsa []Qsa // Pode conter dados ou não

	cnpj              string
	pais              string
	email             string
	porte             string
	bairro            string
	numero            string
	ddd_fax           string
	municipio         string
	logradouro        string
	cnae_fiscal       int
	codigo_pais       string
	complemento       string
	codigo_porte      int
	razao_social      string
	nome_fantasia     string
	capital_social    int
	ddd_telefone1     string
	ddd_telefone2     string
	opcao_pelo_mei    string
	descricao_porte   string
	codigo_municipio  int
	cnaes_secundarios []CnaesSecundarios // Pode conter dados ou não

	natureza_juridica                     string
	situacao_especial                     string
	opcao_pelo_simples                    string
	situacao_cadastral                    int
	data_opcao_pelo_mei                   string
	data_exclusao_do_mei                  string
	cnae_fiscal_descricao                 string
	codigo_municipio_ibge                 int
	data_inicio_atividade                 string
	data_situacao_especial                string
	data_opcao_pelo_simples               string
	data_situacao_cadastral               string
	nome_cidade_no_exterior               string
	codigo_natureza_juridica              int
	data_exclusao_dosimples               string
	motivo_situacao_cadastral             int
	ente_federativo_responsavel           string
	identificador_matriz_filial           int
	qualificacao_do_responsavel           int
	descricao_situacao_cadastral          string
	descricao_tipo_de_logradouro          string
	descricao_motivo_situacao_cadastral   string
	descricao_identificador_matriz_filial string
}
