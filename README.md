# Expose Them Properties!
This is a small plugin that exposes child properties onto parent nodes by setting up property hints.

### Use case
Let's say you have a `Character` class that may include several nodes such as `HealthComponent` or `AttackComponent`. You'd like to expose those components' properties onto the owner node so you can tweak those values for each instance. The _Expose Them Properties!_ plugin allows you to do that without compromising your code.

# How to use it
For clarity sake, let's say you have the following structure:
```gdscript
Character # This is the owner node, where we want to be able to edit children properties
└ HealthComponent # This is the child node that we'll be focusing on for the example
└ AttackComponent
└ ...
```

## 1. Flag the owner node as an importer
You can flag the importer nodes in two different ways:
- By creating a constant in that node's script called `is_importer_node`.
- By adding a metadata key called `is_importer_node` in that node from the editor.

In both cases, it is recommeded that the variable/key is a boolean set to `true`.
```gdscript
class_name Character extends Node

  const is_importer_node := true
```

## 2. Expose the properties in the child node

#### Basic properties
- Use the `@export_custom` decorator.
- Use the `PROPERTY_HINT_NONE` (or `ETP.NONE` for a shorter version) constant for the `hint` argument. If you need any other property hint you can use it freely.
- Use the `ETP.PROPERTY` constant for the `hint_string` argument.
```gdscript
class_name HealthComponent extends Node

  @export_custom(ETP.NONE, ETP.PROPERTY) var is_dead := false
```

#### Range properties
- Use the `@export_range` decorator.
- Use the `ETP.PROPERTY` constant for the `hint_string` argument.
```gdscript
class_name HealthComponent extends Node

  @export_range(0,10,1, ETP.PROPERTY) var life := 10
```

#### Enums
- Use the `@export_custom` decorator.
- Use the `ETP.NONE` constant for the `hint` argument.
- Use the `ETP.ENUM` constant followed by the name of the Enum class represented as a String for the `hint_string` argument.
```gdscript
class_name AttackComponent extends Node

  @export_custom(ETP.NONE, ETP.ENUM + "AttackType") var attack_type := AttackType.MELEE

  enum AttackType { MELEE, DISTANCE }
```

> [!NOTE]
> You must use a real Enum class with no custom values. Using the `@export_enum` decorator or an Enum class with custom values won't work.

#### Nodepaths
- Use the `@export_custom` decorator.
- Use the `ETP.NODEPATH` constant as the first argument, followed by the name of the classes that you want to allow to be selected.
```gdscript
class_name AttackComponent extends Node

  @export_custom(ETP.NODEPATH, "CPUParticles2D") var particle_emitter : CPUParticles2D
```

# FAQ
#### Will this work if the node that has the properties is not a direct child of the node that exposes them?
Yes, no matter how deep in the tree is the node, the nodes marked as importers will expose the properties of their children, grand-children and so on.
#### I've set up a NodePath but in the owner node I can only apply a script, not a node from the scene:
Make sure you're using the `ETP.NODEPATH` constant.
#### Can I name the `is_importer_node` variable/key differently?
Yes, in the plugin configuration (`plugin.cfg`) you can modify a variable named `importer_node_flag` to whatever that fits your needs. Reloading the plugin will be needed.
#### What are the supported types of properties?
So far you can work with _booleans_, _integers_, _floats_, _strings_, _Vector2_, _Vector3_, enums, resource paths and node paths. I've been trying to allow other complex types but it seems that there's not an easy way to replicate Godot's UI for that kind of behaviour.
#### Will you expand the plugin or add more supported types?
Maybe, if I find a real need for any of my projects I will surely do it and upload the changes to this repository.
