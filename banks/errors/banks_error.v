module errors

pub struct BanksError {
	Error
pub:
	message string
	@type   string
	name    string
}

pub fn (err BanksError) msg() string {
	return err.message
}
