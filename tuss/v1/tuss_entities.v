module v1

pub struct TussItem {
pub:
	tuss string
	name string
}

pub struct TussResponse {
pub:
	total  int
	limit  int
	offset int
	items  []TussItem
}
