module v1

pub struct RegistroBr {
pub:
	status_code        i16
	status             string
	fqdn               string
	hosts              []string
	publication_status string   [json: 'publication-status']
	expires_at         string   [json: 'expires-at']
	suggestions        []string
}
