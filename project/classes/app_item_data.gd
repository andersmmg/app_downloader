class_name AppItemData
extends RefCounted

var title: String
var image_url: String
var description: String
var repo: String

static func create(data: Dictionary) -> AppItemData:
	var new_data = AppItemData.new()
	if data.has('title'):
		new_data.title = data['title']
	if data.has('image_url'):
		new_data.image_url = data['image_url']
	if data.has('description'):
		new_data.description = data['description']
	if data.has('repo'):
		new_data.repo = data['repo']
	
	return new_data
