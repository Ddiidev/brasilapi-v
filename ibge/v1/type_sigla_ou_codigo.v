module v1

pub type SiglaCodigo = int | string

pub fn (s SiglaCodigo) str() string {
	if s is string {
		return s as string
	} else {
		return (s as int).str()
	}
}
