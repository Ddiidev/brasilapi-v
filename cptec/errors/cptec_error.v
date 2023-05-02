module errors

pub struct CptecError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err CptecError) msg() string {
	return err.message
}
