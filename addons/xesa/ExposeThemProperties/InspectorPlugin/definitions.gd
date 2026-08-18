## Public constants provided by the ExposeThemProperties (ETP) plugin.
## Use these properties for flagging your [code]@export[/code] annotations.[br][br]
## See the following properties for more information:[br]
## - [constant ETP.PROPERTY][br]
## - [constant ETP.ENUM][br]
## - [constant ETP.NODEPATH][br]
## - [constant ETP.NONE]
class_name ETP extends Node


## Custom property hint used to mark properties that should be exposed by ETP.[br][br]
##
## 
## [b]Using the [code]@export_custom[/code] annotation:[/b][br][br]
## 
## The [code]@export_custom[/code] annotations need at least two arguments.
## The first one can be any of the [code]PROPERTY_HINT[/code] constants provided by GDScript.
## This will only affect how the original property is treated by the editor,
## but if you don't need any special treatment, you can use [code]ETP.NONE[/code].[br][br]
##
## The second argument must be always the [code]ETP.PROPERTY[/code] constant.
##
## [codeblock]
## @export_custom(ETP.NONE, ETP.PROPERTY)
## var my_property: float
## [/codeblock]
##
## [b]Using the [code]@export_range[/code] annotation:[/b][br][br]
##
## The [code]ETP.PROPERTY[/code] constant can also be used at the end of a
## [code]@export_range[/code] annotation. In this case, you don't need to apply
## any additional flag.
##
## [codeblock]
## @export_range(0.0, 100.0, 1.0, ETP.PROPERTY)
## var my_property: float
## [/codeblock]
const PROPERTY := "etp_property"


## Custom property hint used to mark enum properties that should be exposed by ETP.[br][br]
##
## In order to expose an enum you must use the [code]@export_custom[/code] annotation
## and a real enum definition. The [code]@export_enum[/code] annotation won't work.[br][br]
##
## The [code]@export_custom[/code] annotations need at least two arguments.
## The first argument must be always the [code]ETP.PROPERTY[/code] constant.[br][br]
##
## The second argument must be [code]ETP.ENUM[/code] followed by the name of the enum class
## represented as a string.
##
## [codeblock]
## @export_custom(ETP.NONE, ETP.ENUM + "MyEnum")
## var my_enum: MyEnum
##
## enum MyEnum { FIRST_VALUE, SECOND_VALUE }
##
## [/codeblock]
## 
## Note: using the [code]ETP.NONE[/code] hint will cause the original property to appear
## as an integer in the editor. This will only affect the original property. The exposed
## property in the parent node will show the enum selector correctly.
const ENUM := "etp_enum:"


## Custom property hint used to mark nodepaths that should be exposed by ETP.[br][br]
##
## In order to expose a nodepath, you must use the [code]@export_node_path[/code] annotation
## and a [code]NodePath[/code] property.[br][br]
##
## The first argument of the annotation must always be [code]ETP.NODEPATH[/code]
##
## [codeblock]
## @export_node_path(ETP.NODEPATH, "MyClass")
## var path_to_my_class : NodePath
## [/codeblock]
const NODEPATH := "ETP"


## Built-in property hint used as a parameter for the
## [code]@export_custom[/code] annotation. This is the same as the built-in
## [code]PROPERTY_HINT_NONE[/code] constant provided by GDScript.
## Use can use this to make your code shorter and more readable when you
## don't need any specific property hint.[br][br]
##
## For example, use this:
## [codeblock]
## @export_custom(ETP.NONE, ETP.PROPERTY)
## var my_property: float
## [/codeblock]
##
## Instead of this:
##
## [codeblock]
## @export_custom(PROPERTY_HINT_NONE, ETP.PROPERTY)
## var my_property: float
## [/codeblock]
const NONE := PROPERTY_HINT_NONE
