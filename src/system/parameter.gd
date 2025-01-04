class_name Parameter extends Resource

signal changed_value(value: int, min: int, max: int)

@export var _value: int
@export var _min_value: int
@export var _max_value: int

var value: int:
	get:
		return _value
	set(v):
		if v <= _min_value:
			_value = _min_value
		elif v >= _max_value:
			_value = _max_value
		else:
			_value = v
		changed_value.emit(_value, _min_value, _max_value)

var max_value: int:
	get:
		return _max_value
	set(v):
		_max_value = v
		_value = _value if _value < _max_value else _max_value
		changed_value.emit(_value, _min_value, _max_value)

var min_value: int:
	get:
		return _min_value
	set(v):
		_min_value = v
		_value = _value if _value > _min_value else _min_value
		changed_value.emit(_value, _min_value, _max_value)

func get_value() -> int:
	return value

func set_value(v: int):
	value = v

func set_max(v: int):
	max_value = v

func set_min(v: int):
	min_value = v

func get_max() -> int:
	return max_value

func get_min() -> int:
	return min_value

func get_calc(callable: Callable) -> int:
	return callable.call(value, min, max)

func set_calc(callable: Callable) -> int:
	value = callable.call(value, min, max)
	return self.value

func is_min() -> bool:
	return value == min_value

func is_max() -> bool:
	return value == max_value

func is_condition(callable: Callable) -> bool:
	return callable.call(value, min, max)
