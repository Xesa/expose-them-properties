## Public constants provided by the ExposeThemProperties (ETP) plugin.
## Use these properties for flagging your [code]@export[/code] annotations.[br][br]
## See the following properties for more information:[br]
## - [constant ETP.PROPERTY][br]
## - [constant ETP.NODEPATH]
class_name ETP extends Node

## Custom property hint used to mark properties that should be exposed by ETP.[br][br]
##
## Example:
## [codeblock]
## @export_custom(ETP.PROPERTY)
## var my_property: float
## [/codeblock]
##
## It can also be combined with other export hints:
##
## [codeblock]
## @export_range(0.0, 100.0, 1.0, ETP.PROPERTY)
## var my_property: float
## [/codeblock]
const PROPERTY := "etp_property"

## Custom property hint used to mark nodepaths that should be exposed by ETP.[br]
## Note: the [code]ETP.NODEPATH[/code] hint should always go in the first place.[br][br]
##
## Example:
## [codeblock]
## @export_node_path(ETP.NODEPATH, "MyClass")
## var path_to_my_class : NodePath
## [/codeblock]
const NODEPATH := "ETP"
