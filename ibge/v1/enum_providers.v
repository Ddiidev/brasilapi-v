module v1

@[flag]
pub enum Providers {
	dados_abertos_br
	gov
	wikipedia
}

const names_providers = {
	Providers.dados_abertos_br: 'dados-abertos-br'
	Providers.gov:              'gov'
	Providers.wikipedia:        'wikipedia'
}

pub fn (p Providers) get_names_setad() []string {
	mut names := []string{}

	$for value in Providers.values {
		if p.has(value.value) {
			names << v1.names_providers[value.value]
		}
	}
	return names
}
