module errors

pub struct TaxaError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err TaxaError) msg() string {
	return err.message
}
