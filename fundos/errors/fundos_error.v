module errors

pub struct FundosError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err FundosError) msg() string {
	return err.message
}
