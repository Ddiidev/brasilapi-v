module errors

pub struct RegistroBrError {
	Error
pub:
	message            string
	@type              string
	name               string
	status_code        i16
	status             string
	fqdn               string
	hosts              []string
	publication_status string
	expires_at         string
	suggestions        []string
}

pub fn (err RegistroBrError) msg() string {
	return err.message
}
