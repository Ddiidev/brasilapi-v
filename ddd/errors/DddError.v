module errors

pub struct DddError {
	Error
pub:
	message string
	@type   string
	name    string
}
