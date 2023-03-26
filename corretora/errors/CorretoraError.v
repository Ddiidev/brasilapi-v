module errors

pub struct CorretoraError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err CorretoraError) msg() string {
	return err.message
}
