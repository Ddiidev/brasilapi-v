module v1

pub enum TipoFundo {
	fii
	setorial
	fiagro_fii
	fiagro_fidc
	fiagro_fip
	fip
	fia
}

pub fn (tipo TipoFundo) api_value() string {
	return match tipo {
		.fii { 'FII' }
		.setorial { 'SETORIAL' }
		.fiagro_fii { 'FIAGRO-FII' }
		.fiagro_fidc { 'FIAGRO-FIDC' }
		.fiagro_fip { 'FIAGRO-FIP' }
		.fip { 'FIP' }
		.fia { 'FIA' }
	}
}
