module tests

import utils

[flag]
enum EnumTest {
	name_x
	name_y
	name_z
}

fn test_get_names_setad_enum() {
	local_enum := EnumTest.name_x

	names := utils.get_names_enum_setad[EnumTest](type_enum: local_enum)

	assert names.len == 1
	assert names[0] == 'name_x'
}

fn test_get_names_setad_enum_multiple() {
	local_enum := EnumTest.name_x | EnumTest.name_y | EnumTest.name_z

	names := utils.get_names_enum_setad[EnumTest](type_enum: local_enum)

	assert names.len == 3
	assert names.all(it in ['name_x', 'name_y', 'name_z'])
}

fn test_get_names_setad_enum_source_data() {
	source_data := {
		EnumTest.name_x: 'this x'
		EnumTest.name_y: 'this y'
		EnumTest.name_z: 'this z'
	}

	local_enum := EnumTest.name_x | EnumTest.name_y | EnumTest.name_z

	names := utils.get_names_enum_setad[EnumTest](type_enum: local_enum, source_data: source_data)

	assert names.len == 3
	assert names.all(it in ['this x', 'this y', 'this z'])
}
