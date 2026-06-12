module errors

pub struct TickersError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err TickersError) msg() string {
	return err.message
}
