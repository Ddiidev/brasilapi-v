module errors

pub struct IBGEError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err IBGEError) msg() string {
	return err.message
}
