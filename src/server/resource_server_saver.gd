class_name ResourceServerSaver extends Node

signal error_save_resource(resource: Resource, path: String)

func save_resource(resource: Resource, path: String):
	if not resource:
		Log.log_error("[ResourceServerSaver] Resource to save is null")
		error_save_resource.emit(EmptyResource.new(), path)
		return

	var err = ResourceSaver.save(resource, path)
	if err == Error.OK:
		Log.log_error("[ResourceServerSaver] saved Resource#%d %s(%s) to %s" \
			% [resource.get_instance_id(), resource.resource_name, resource.resource_path, path])
	else:
		Log.log_error("[ResourceServerSaver] [Error.%d]couldn't save Resource#%d %s(%s) to %s" \
			% [err, resource.get_instance_id(), resource.resource_name, resource.resource_path, path])
		error_save_resource.emit(resource, path)

class EmptyResource extends Resource:
	pass
