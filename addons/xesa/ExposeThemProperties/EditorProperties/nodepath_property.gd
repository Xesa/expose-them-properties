extends "_property_base_class.gd"

const HELPERS := preload("../InspectorPlugin/helpers.gd")


func _init(object : Node, property : Dictionary):
	var nodepath := NodePathControl.new(object, property)
	super(object, property, nodepath, "path", "path_changed")


func update_control_property() -> void:
	control.path = get_current_value()
	control.toggle_select_button(control.path != NodePath(""))


class NodePathControl extends EditorProperty:

	var object : Node
	var container : HBoxContainer 
	var select_button : Button
	var clean_button : Button
	var property_type : Array[StringName]

	var path : NodePath

	signal path_changed(new_path : NodePath)


	func _init(_object : Node, property : Dictionary) -> void:

		object = _object

		# Sets the property type string
		var property_name = property["name"]
		var object_property := HELPERS.get_object_property(object, property_name)

		var hint_string = object_property.get("hint_string")

		if hint_string != null and hint_string != "":
			var splitted_hint := HELPERS.split_stringname(hint_string)
			splitted_hint.pop_at(0)
			property_type = splitted_hint

		# Sets the UI
		container = HBoxContainer.new()
		container.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		select_button = Button.new()
		select_button.text = "Select node"
		select_button.pressed.connect(_open_selector)
		select_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		select_button.clip_text = true
		select_button.custom_minimum_size.x = 100
		
		clean_button = Button.new()
		clean_button.text = "X"
		clean_button.disabled = true
		clean_button.pressed.connect(clean_node)
		
		container.add_child(select_button)
		container.add_child(clean_button)
		add_child(container)


	func _open_selector() -> void:
		if path != NodePath(""):
			EditorInterface.popup_node_selector(set_node, property_type, object.get_node(path))
		else:
			EditorInterface.popup_node_selector(set_node, property_type)
		


	func set_node(new_path) -> void:
		if new_path == NodePath(""):
			return

		var node := get_tree().edited_scene_root.get_node(new_path)
		path = object.get_path_to(node)
		toggle_select_button(true)
		path_changed.emit(path)
		emit_changed(get_edited_property(), path)


	func clean_node() -> void:
		path = NodePath("")
		toggle_select_button(false)
		path_changed.emit(path)
		emit_changed(get_edited_property(), path)

	
	func toggle_select_button(toggle : bool) -> void:
		if toggle:
			select_button.text = path.get_name(path.get_name_count() - 1)
			select_button.add_theme_color_override("font-color", Color.LIGHT_BLUE)
			clean_button.disabled = false
		else:
			select_button.text = "Select node"
			select_button.remove_theme_color_override("font-color")
			clean_button.disabled = true

	
