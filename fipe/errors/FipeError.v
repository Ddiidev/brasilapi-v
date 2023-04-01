module errors

pub struct FipeError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err FipeError) msg() string {
	return err.message
}
