module v1

pub struct Bank {
pub:
	ispb      string
	name      string
	code      int
	full_name string @[json: 'fullName']
}
