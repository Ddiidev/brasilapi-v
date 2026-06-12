module v1

pub struct TickerAcao {
pub:
	code_cvm string @[json: 'code_CVM']
	issuing_company string
	company_name string
	trading_name string
	cnpj string
	market_indicator string
	type_bdr string @[json: 'type_BDR']
	date_listing string
	status string
	segment string
	segment_eng string
	@type string
	market string
}

pub struct TickerFundo {
pub:
	id int
	type_name string
	acronym string
	fund_name string
	trading_name string
}
