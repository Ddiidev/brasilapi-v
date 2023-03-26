module errors

pub struct CepError {
	Error
pub:
	message string
	@type   string
	name    string
	errors  []struct {
	pub:
		name    string
		message string
		service string
	}
}

pub fn (err CepError) msg() string {
	return err.message
}
