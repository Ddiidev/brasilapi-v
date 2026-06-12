module errors

pub struct TussError {
	Error
pub:
	message string
	@type string
	name string
}

pub fn (err TussError) msg() string {
	return err.message
}
