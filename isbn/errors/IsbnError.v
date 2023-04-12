module errors

pub struct IsbnError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err IsbnError) msg() string {
	return err.message
}
