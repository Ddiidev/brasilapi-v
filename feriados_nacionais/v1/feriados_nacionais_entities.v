module v1

import time

pub struct FeriadoNacional {
	date_str string @[json: 'date']
pub:
	date  time.Time
	name  string
	@type string
}
