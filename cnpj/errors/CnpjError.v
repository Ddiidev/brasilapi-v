module errors

pub struct CnpjError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err CnpjError) msg() string {
	return err.message
}
