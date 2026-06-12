module errors

pub struct CambioError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err CambioError) msg() string {
	return err.message
}
