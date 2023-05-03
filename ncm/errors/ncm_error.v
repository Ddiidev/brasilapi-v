module errors

pub struct NcmError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err NcmError) msg() string {
	return err.message
}
