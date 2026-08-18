@tool
extends EditorInspectorPlugin

const MAIN := preload("main.gd")
const HELPERS := preload("helpers.gd")

const CHECKBOX_PROPERTY := preload("../EditorProperties/checkbox_property.gd")
const ENUM_PROPERTY := preload("../EditorProperties/enum_property.gd")
const NODEPATH_PROPERTY := preload("../EditorProperties/nodepath_property.gd")
const NUMBER_PROPERTY := preload("../EditorProperties/number_property.gd")
const RESOURCE_PROPERTY := preload("../EditorProperties/resource_property.gd")
const STRING_PROPERTY := preload("../EditorProperties/string_property.gd")
const VECTOR2_PROPERTY := preload("../EditorProperties/vector2_property.gd")
const VECTOR3_PROPERTY := preload("../EditorProperties/vector3_property.gd")


func _can_handle(object: Object) -> bool:
	if object is not Node or object is EditorProperty:
		return false
	else:
		return true
	
			
func _parse_begin(object : Object) -> void:

	# Returns if the selected node is not an importer
	if !object.get(MAIN.IMPORTER_NODE_FLAG) and !object.has_meta(MAIN.IMPORTER_NODE_FLAG):
		return

	# Iterates every child and finds their exportable properties
	var properties := HELPERS.scan_children_nodes(object)
	for node_info in properties:
		_add_property_editors(node_info)


func _add_property_editors(node_info : Dictionary) -> void:

	var node : Node = node_info["node"]
	var node_name : String = node_info["node_name"]
	var properties : Dictionary = node_info["properties"]

	if properties.size() == 0:
		return

	HELPERS.create_group_label(self, node.name)

	# Iterates every property from the exportable resource and checks if the current object has them
	for name in properties.keys():

		var property : Dictionary = properties[name]

		if MAIN.DEBUG:
			print("Property %s (%d)" % [name, property.type])

		# Creates an EditorProperty based on the type and hint
		var editor_property : EditorProperty
		
		if property.etp_type == ETP.PROPERTY:

			match property.type:
				1: editor_property = CHECKBOX_PROPERTY.new(node, property)
				2: editor_property = NUMBER_PROPERTY.new(node, property)
				3: editor_property = NUMBER_PROPERTY.new(node, property)
				4: editor_property = STRING_PROPERTY.new(node, property)
				5: editor_property = VECTOR2_PROPERTY.new(node, property)
				9: editor_property = VECTOR3_PROPERTY.new(node, property)
				22: editor_property = NODEPATH_PROPERTY.new(node, property)
				24: editor_property = RESOURCE_PROPERTY.new(node, property)
				_: continue

		elif property.etp_type == ETP.ENUM and property.type == 2:
			editor_property = ENUM_PROPERTY.new(node, property)

		elif property.etp_type == ETP.NODEPATH and property.type == 22:
			editor_property = NODEPATH_PROPERTY.new(node, property)

		# Finally, adds the PropertyEditor to the UI
		if editor_property:
			add_property_editor(name, editor_property, true, name.capitalize())
