@tool
extends "_property_base_class.gd"


func _init(object : Node, property : Dictionary):
	var picker = OptionButton.new()
	
	for item : String in property.etp_enum_items:
		picker.add_item(item.capitalize())
		
	super(object, property, picker, "selected", "item_selected")
