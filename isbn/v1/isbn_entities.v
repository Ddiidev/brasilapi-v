module v1

pub struct ISBN {
pub:
	isbn         string
	title        string
	subtitle     ?string
	authors      []string
	publisher    string
	synopsis     string
	dimensions   Dimension
	year         u32
	format       string
	page_count   u32
	subjects     []string
	location     string
	retail_price ?f32
	cover_url    ?string
	provider     Provider
}

@[noinit]
struct ISBN_ {
pub:
	isbn         string
	title        string
	subtitle     ?string
	authors      []string
	publisher    string
	synopsis     string
	dimensions   Dimension
	year         u32
	format       string
	page_count   u32
	subjects     []string
	location     string
	retail_price ?f32
	cover_url    ?string
	provider     string
}
