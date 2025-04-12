GDPC                @
                                                                         T   res://.godot/exported/133200997/export-0528b98252209bca725394eaaec3391b-app_item.scn 5      �	      ��<�/��ܲl���k    P   res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn V      �      BWx��,a��Y8p�)9    ,   res://.godot/global_script_class_cache.cfg  @�     Z      J���ZB"�j�7���    X   res://.godot/imported/VarelaRound-Regular.ttf-60ee2a83a51550ba9376b22ed48501c1.fontdata  ~      �     ^]���e�e]
ݢ-U    H   res://.godot/imported/a_button.svg-f3d114e0c75896f33180486d64e7e976.ctex "      6      Kx͛�3kY,��d��    H   res://.godot/imported/b_button.svg-52789bbe4cdfb0c16ef6723b295279dd.ctex$      ,      (���"��x�*��Q    D   res://.godot/imported/dpad.svg-88911b40574a087ec58d8b5734c8f485.ctex&      �       Ε˻�Ų��<��Y�    H   res://.godot/imported/loader.svg-a06de1ffc167daf1b25ce9d131dce0b7.ctex  �'      �      _�9��5�e�19aV�    H   res://.godot/imported/no_image.svg-d997f08c003d1cae00843e9dbf2801e0.ctex�*            ���F����`�S    H   res://.godot/imported/splash.png-929ed8a00b89ba36c51789452f874c77.ctex  �p      ^      �j�L�MS��k�޸Re    H   res://.godot/imported/wifi-off.svg-c98b51ed89cff9a2652adf7341d65eea.ctexp-      &      �G��G�afvQ
�_:       res://.godot/uid_cache.bin  ��     U      u�rxyL
�ad�՞t�    $   res://VarelaRound-Regular.ttf.import��     �       Q�����Y������       res://app_item.gd   p2      �      ����LW������r       res://app_item.tscn.remap   `�     e       �B�`l&ᛒŧ�g��        res://classes/app_item_data.gd          �      	�2d���!>)�����       res://classes/http_result.gd�      �      ׎t^�)���sހ�a��    $   res://classes/texture_rect_url.gd   �            �<a&RH}S˾�(Z        res://icons/a_button.svg.import @#      �       �%��&��a4��O��=        res://icons/b_button.svg.import @%      �       ��aoC�ILbFk       res://icons/dpad.svg.import �&      �       ���SCGl��o�        res://icons/loader.svg.import   �)      �       +��Z��c\�$);�ڿ�        res://icons/no_image.svg.import �,      �       �ȕ�%O
?w�1G1�n        res://icons/wifi-off.svg.import �/      �       o=
��T��ۘ2�����       res://main.gd   ?      
      <�n�d�{k����N       res://main.tscn.remap   І     a       �J�Sw� ������       res://project.binary�     k      NB_]M�%#{���J��       res://singletons/http.gdp0      �      T� �_fk��R��       res://splash.png��     �-      \�i�pk���޵�C       res://splash.png.import 0}      �       �ɩ(e����I��A            class_name AppItemData
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
              class_name HTTPResult
extends RefCounted

# From Swarkin/Godot-AwaitableHTTPRequest

var _error: Error				## Contains the [method HTTPRequest.request] error, [constant Error.OK] otherwise. See also [method success].[br](For advanced use-cases)
var _result: HTTPRequest.Result	## Contains the [annotation HTTPRequest] error, [constant HTTPRequest.RESULT_SUCCESS] otherwise. See also [method success].[br](For advanced use-cases)
var status: int					## The response status code.
var headers: Dictionary			## The response headers.
var bytes: PackedByteArray		## The response body as a [PackedByteArray].[br][b]Note:[/b] Any [Array] is always passed by reference.

## Checks whether the HTTP request succeeded, meaning [member _error] and [member _result] aren't in an error state.[br]
## [b]Note:[/b] This does not check the response [member status] code.
func success() -> bool:
	return _error == OK and _result == HTTPRequest.RESULT_SUCCESS

## Checks whether the [member status] is between 200 and 299 (inclusive), see [url]https://developer.mozilla.org/en-US/docs/Web/HTTP/Status[/url].
func status_ok() -> bool:
	return status >= 200 and status < 300

## Checks whether the [member status] is between 400 and 599 (inclusive), see [url]https://developer.mozilla.org/en-US/docs/Web/HTTP/Status[/url].
func status_err() -> bool:
	return status >= 400 and status < 600

## The response body as a [String].[br]
## For other formatting (ascii, utf16, ...) or special use-cases (file I/O, ...), it is possible to access the raw body's [member bytes].[br]
## You should cache this return value instead of calling the funciton multiple times.
func body_as_string() -> String:
	return bytes.get_string_from_utf8()

## Attempt to parse the response [member bytes] into a [Dictionary] or [Array], returns null on failure.[br][br]
## It is possible to cast the return type to a [Dictionary] with "[code]as Dictionary[/code]" to receive autocomplete and other benefits when the parsing was successful.[br]
## If you want error handling for the JSON deserialization, make an instance of [JSON] and call [method JSON.parse] on it, passing in the return value of [method HTTPResult.body_as_string]. This allows the usage of [method JSON.get_error_message] and [method JSON.get_error_line] to get potential error information.[br][br]
## [b]Note:[/b] Godot always converts JSON numbers to [float]s!
func body_as_json() -> Variant:
	return JSON.parse_string(body_as_string())

# Constructs a new [HTTPResult] from an [enum @GlobalScope.Error] code. (Used internally, hidden from API list)
static func _from_error(err: Error) -> HTTPResult:
	var h := HTTPResult.new()
	h._error = err
	return h

# Constructs a new [HTTPResult] from the return value of [signal HTTPRequest.request_completed]. (Used internally, hidden from API list)
static func _from_array(a: Array) -> HTTPResult:
	var h := HTTPResult.new()
	h._result = a[0] as HTTPRequest.Result
	h.status = a[1] as int
	h.headers = _headers_to_dict(a[2] as PackedStringArray)
	h.bytes = a[3] as PackedByteArray
	return h

# Converts a [PackedStringArray] of headers into a [Dictionary]. The header names will be in lowercase, as some web servers prefer this approach and them being case-insensitive as per specification. Therefore, it is good practice to not rely on capitalization. (Used internally, hidden from API list)
static func _headers_to_dict(headers_arr: PackedStringArray) -> Dictionary:
	var dict := {}
	for h in headers_arr:
		var split := h.split(":", true, 1)
		dict[split[0].to_lower()] = split[1].strip_edges()

	return dict
        @tool
class_name TextureRectUrl
extends TextureRect

var http_request := HTTPRequest.new()
var overlay_texture := TextureRect.new()
var file_name := ""
var file_ext := ""

## URL to fetch texture from
@export var texture_url = "":
	set(value):
		texture_url = value
		if autoload:
			load_image()
## Whether to cache downloaded images
@export var store_cache: bool = true
## Whether to autoload the image when url changes
@export var autoload := true:
	set(value):
		autoload = value
		if autoload:
			if !http_request.is_inside_tree():
				http_request.use_threads = true
				http_request.request_completed.connect(_on_request_completed)
				call_deferred("add_child", http_request)
			load_image()
## Texture to show while loading
@export var loading_texture: Texture2D
## Texture to show if loading failed
@export var fail_texture: Texture2D
## Margins on the edges of the overlay texture (loading, failure)
@export var overlay_margins: int = 10

const CACHE_DIR = "user://cache/"

signal load_success(image: Texture, fromCache: bool)
signal load_failed

func _ready():
	if store_cache:
		# Add cache directory
		DirAccess.make_dir_recursive_absolute(CACHE_DIR)
	
	if !http_request.is_inside_tree():
		http_request.use_threads = true
		http_request.request_completed.connect(_on_request_completed)
		add_child(http_request, false, Node.INTERNAL_MODE_FRONT)
	
	resized.connect(func(): overlay_texture.custom_minimum_size = size)
	if !overlay_texture.is_inside_tree():
		var margin = MarginContainer.new()
		margin.add_theme_constant_override("margin_left", overlay_margins)
		margin.add_theme_constant_override("margin_right", overlay_margins)
		margin.add_theme_constant_override("margin_up", overlay_margins)
		margin.add_theme_constant_override("margin_down", overlay_margins)
		margin.custom_minimum_size = size
		overlay_texture.texture = loading_texture
		overlay_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		overlay_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		overlay_texture.hide()
		add_child(margin, false, Node.INTERNAL_MODE_FRONT)
		margin.add_child(overlay_texture, false, Node.INTERNAL_MODE_FRONT)
	
	load_image()

func load_image():
	http_request.cancel_request()
	if texture_url == "":
		_load_failed()
		return
	
	overlay_texture.show()
	
	var dt = texture_url.split(":")
	if dt[0] == "data":
		_base64texture(texture_url)
		return

	file_ext = texture_url.get_extension()
	file_name = str(texture_url.hash(),".",file_ext)
	
	if !Engine.is_editor_hint():
	
		if FileAccess.file_exists(str(CACHE_DIR, file_name)):
			var _image = Image.new()
			_image.load(str(CACHE_DIR, file_name))
			var _texture = ImageTexture.create_from_image(_image)
			texture = _texture
			overlay_texture.hide()
			if !Engine.is_editor_hint():
				load_success.emit(_texture, true)
				return
	
	if file_ext != "":
		_download_image()

func _download_image():
	texture = null
	http_request.cancel_request()
	if texture_url != "":
		http_request.request(texture_url)
	else:
		_load_failed()

func _on_request_completed(result, response_code, _headers, body):
	if response_code == 200 and result == HTTPRequest.RESULT_SUCCESS:
		print("image downloaded")
		var image = Image.new()
		var image_error = null
		
		if file_ext == "png":
			image_error = image.load_png_from_buffer(body)
		elif file_ext == "jpg" or file_ext == "jpeg":
			image_error = image.load_jpg_from_buffer(body)
		elif file_ext == "webp":
			image_error = image.load_webp_from_buffer(body)
			
		if image_error != OK:
			# An error occurred while trying to display the image
			_load_failed()
			return
	
		var _texture: ImageTexture = ImageTexture.create_from_image(image)
		overlay_texture.hide()
		if !Engine.is_editor_hint():
			load_success.emit(image, false)
		
		if store_cache:
			match file_ext:
				"png":
					image.save_png(str(CACHE_DIR, file_name))
				"jpg":
					image.save_jpg(str(CACHE_DIR, file_name))
				"jpeg":
					image.save_jpg(str(CACHE_DIR, file_name))
				"webp":
					image.save_webp(str(CACHE_DIR, file_name))
				_:
					print("Failed to save image to cache")
	
		# Assign a downloaded texture
		texture = _texture
	else:
		_load_failed()

func _base64texture(image64: String):
	var image := Image.new()
	var tmp: String = image64.split(",")[1]

	if not image.load_png_from_buffer(Marshalls.base64_to_raw(tmp)) == OK:
		_load_failed()
		return
	var _texture := ImageTexture.create_from_image(image)
	texture = _texture
	overlay_texture.hide()
	if !Engine.is_editor_hint():
		load_success.emit(image, false)

func _load_failed():
	texture = fail_texture
	overlay_texture.hide()
	load_failed.emit()
  GST2              ����                          �   RIFF�   WEBPVP8L�   /�p۶� �_5��Ǟ�.����ڶ&/�����U��Y�
�"���w��7�%5칾�r��oT=q�|@��52[�����M*U���x�S�Bg� IU�}A�%l��IL��$��ob ���PҖ�@'�� �0�A�$�@���w!�X�nb c���������?>�R����Jet!�k���_z�?�&���^�Y��rp�b��B/��
|I           [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://2ey53ww266rr"
path="res://.godot/imported/a_button.svg-f3d114e0c75896f33180486d64e7e976.ctex"
metadata={
"vram_texture": false
}
             GST2              ����                          �   RIFF�   WEBPVP8L�   /�0ڶ��W�t��p���ֶ5y+���u]R�T�Υ�H�6Cd� R!5�wR� �T�dr�2-Tn��q�p@��,��pA�������6��ԱPř
  ���ɲ��	�tbT��d�M�����*�&TDQ��D��T�yd�J��� �m�ME��M&�J'��#�8�k��A��.x���k@o��7��.�x��u$&�NNM�,�g�L�     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://num35sdixvrw"
path="res://.godot/imported/b_button.svg-52789bbe4cdfb0c16ef6723b295279dd.ctex"
metadata={
"vram_texture": false
}
             GST2              ����                          �   RIFF�   WEBPVP8L�   /�w0��?��I��s	L�e���q`@�(A�Qm�Jp
��T�� �OR@PD�-���J���MۤvjgX��<���i ��H�=c+�N+�xnn��M��T�"�ϿQ�'ށٶ~�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cr5l3amflx6gn"
path="res://.godot/imported/dpad.svg-88911b40574a087ec58d8b5734c8f485.ctex"
metadata={
"vram_texture": false
}
                GST2   H   H      ����               H H        �  RIFF�  WEBPVP8L�  /G�pI���ou��bt�����m�q^������f��k`���3�CG�0���m$EJ'ǰ��
����  �
�����_�e�5���5 �<׀������L�� jZ+��{)�XE�Z�O],���m�9)O��*CT����K9����)ݴ��lN����R��jP�Y?�M���V["��.)�V$�IZ�I�ǡy,G�O����׹����;}93�qD���a;W��r�b/|��r��cЦlEΦ�Ix?v��|�������R�	�;t����\��r�p.O��j ����o�# �Hq:"CH�������@�YFvU�)Q1�(�4ZѮ�P#��%?��8�$r��#3��Vc�T�G¨rm:i~M�o�^����P�R�               [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c77sgb1v6k6bm"
path="res://.godot/imported/loader.svg-a06de1ffc167daf1b25ce9d131dce0b7.ctex"
metadata={
"vram_texture": false
}
              GST2   H   H      ����               H H        �  RIFF�  WEBPVP8L�  /G���F�#������:��į���s۶�gI�b�fgWNJU�l۶�l'�픶mn$)�9�x�	�%�޶gt�s�XU��<��Vn�bT_�{�{�8 t��>D��~8���.D ��<d`~� ��Xr��;�ݙ���D]�.k��YPÍ@sX
#=�ђ��Z�"��f�zg�2T�O�b�Y�T�97��a�52����ʱ�
�J�P�)��28����1D�+�P_8%K�碚���+�n!0��#-n��e��Æ;��a�g��9�Oa�5�����8!~��a���PES���M`9��ђc�0�Bg�a��a�,\��Df���0 �ݣ=�T����`
�;W���B�J�����I(xSt�C�;u� w�����l��c��BL���f��§Xr��|�:آ�XB'C7y�(A/��S�F�p�^Jpk56=fx���%��   [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ccwsjgnrcjh0k"
path="res://.godot/imported/no_image.svg-d997f08c003d1cae00843e9dbf2801e0.ctex"
metadata={
"vram_texture": false
}
            GST2   0   0      ����               0 0        �  RIFF�  WEBPVP8L�  //�p�F�#�5��;/���_dۦm�g����ȶ#۶���m���mG���;���(��0,|��@�y��[�h�s�\�s����m��
_=v�N�r���]��5_��&�0�=ml6�� �7��_��`��st��L	k>"UY�"m)�����������>�8ƿA�O(藛r3�3"�(�02G�JsٿV��L�#�(����X���8��/L% �� %���h� gN���6�.!�e%Ws�q�"�M���1��:|�CN?�J�	>K�����NѵR �K�
S��>����q�o"N%��r�f�@��2�@ _g\|�@�J"�G��>�Xŗ���,��y�@��{AA����<��Z���B�\����w pK�@f̅hs�D� Ju�4R(�)�Ew����'�L��?(�oe������Ω2��Z�W,&�\/ɭ��^z)�|          [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://qavvd8y0jin4"
path="res://.godot/imported/wifi-off.svg-c98b51ed89cff9a2652adf7341d65eea.ctex"
metadata={
"vram_texture": false
}
             extends Node

func async_request(url: String, custom_headers := PackedStringArray(), method := HTTPClient.Method.METHOD_GET, request_data := "") -> HTTPResult:
	var new_requester := HTTPRequest.new()
	add_child(new_requester)
	var err := new_requester.request(url, custom_headers, method, request_data)
	if err:
		new_requester.queue_free()
		return HTTPResult._from_error(err)

	var result := await new_requester.request_completed as Array
	
	new_requester.queue_free()

	return HTTPResult._from_array(result)
 @tool
class_name AppItem
extends Container

signal pressed

@onready var texture_rect: TextureRectUrl = %TextureRect
@onready var label: Label = %Label
@onready var highlight = %Highlight

@export var app_title: String:
	set(value):
		app_title = value
		if label:
			label.text = app_title
@export var app_image_url: String:
	set(value):
		app_image_url = value
		if texture_rect:
			texture_rect.texture_url = app_image_url

func _ready():
	app_title = app_title
	app_image_url = app_image_url
	highlight.hide()
	
	focus_entered.connect(_focus_entered)
	focus_exited.connect(_focus_exited)

func _focus_entered():
	highlight.show()

func _focus_exited():
	highlight.hide()
             RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom 	   bg_color    draw_center    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    shadow_color    shadow_size    shadow_offset    anti_aliasing    anti_aliasing_size    script 	   _bundled       Script    res://app_item.gd ��������   Script "   res://classes/texture_rect_url.gd ��������
   Texture2D    res://icons/loader.svg 
w��C�Vb      local://StyleBoxFlat_kka0v          local://StyleBoxFlat_7ymw5 j         local://PackedScene_slyho �         StyleBoxFlat          �� =�� =�� =  �?                                             StyleBoxFlat 
             	         
                                                                        PackedScene          	         names "         AppItem    offset_right    offset_bottom    focus_mode    theme_override_styles/panel    script    PanelContainer    MarginContainer    layout_mode %   theme_override_constants/margin_left $   theme_override_constants/margin_top &   theme_override_constants/margin_right '   theme_override_constants/margin_bottom    HBoxContainer    TextureRect    unique_name_in_owner    custom_minimum_size    expand_mode    stretch_mode    loading_texture    Label 
   Highlight    visible    Panel    	   variants            C     �B                                      
     �B  �B                                              node_count             nodes     Z   ��������       ����                                                    ����         	      
                                   ����                          ����                                    	      
                    ����                                 ����                                     conn_count              conns               node_paths              editable_instances              version             RSRC      extends CanvasLayer

const APP_ITEM = preload("res://app_item.tscn")
const APPS_LIST_URL := "https://raw.githubusercontent.com/andersmmg/app_downloader/refs/heads/main/apps_listing.json"
const ALLOWED_EXT := ['muxzip','muxupd']

var DOWNLOAD_LOCATION: String

@onready var http_downloader: HTTPRequest = $HTTPDownloader
@onready var apps_list: VBoxContainer = %AppsList
@onready var loading_overlay: Control = %LoadingOverlay
@onready var app_desc: RichTextLabel = %AppDesc
@onready var app_image: TextureRectUrl = %AppImage
@onready var download_overlay: Container = %DownloadOverlay
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var progress_label: Label = %ProgressLabel
@onready var error_label: Label = %ErrorLabel
@onready var success_label: Label = %SuccessLabel
@onready var loading_label: Label = %LoadingLabel
@onready var quit_prompt: Container = %QuitPrompt
@onready var offline_icon: TextureRect = %OfflineIcon
@onready var no_image_label = %NoImageLabel

var apps: Array[AppItemData]
var selected_app: AppItemData
var download_target: String
var is_downloading: bool = false

var message_countdown: float = 0

func _init() -> void:
	if OS.is_debug_build():
		DOWNLOAD_LOCATION = "user://downloads/"
	else:
		DOWNLOAD_LOCATION = "/mnt/mmc/ARCHIVE/"
	print("App is running")

func _ready() -> void:
	quit_prompt.hide()
	offline_icon.hide()
	error_label.hide()
	success_label.hide()
	no_image_label.hide()
	DirAccess.make_dir_absolute(DOWNLOAD_LOCATION)
	loading_overlay.show()
	download_overlay.hide()
	http_downloader.request_completed.connect(_on_http_downloader_request_completed)
	app_image.load_failed.connect(_image_load_failed)
	_get_store()

func _process(delta) -> void:
	if message_countdown > 0:
		message_countdown -= delta
	else:
		error_label.hide()
		success_label.hide()
	
	if loading_overlay.visible:
		if Input.is_action_just_pressed("back"):
			get_tree().quit()
	elif download_overlay.visible:
		_update_download_progress()
	else:
		if Input.is_action_just_pressed("back"):
			get_tree().quit()
		if Input.is_action_just_pressed("download"):
			if selected_app:
				check_latest_release(selected_app.repo)

func _update_download_progress() -> void:
	if not is_downloading:
		progress_bar.value = 0
		return
	var body_size := http_downloader.get_body_size()
	var downloaded_bytes := http_downloader.get_downloaded_bytes()
	var percent: float = downloaded_bytes*100.0 / body_size
	progress_bar.value = percent

func _get_store() -> void:
	var resp: HTTPResult = await HTTP.async_request(APPS_LIST_URL)
	if resp.success() and resp.status_ok():
		var json = resp.body_as_json()
		if json is Array:
			_show_data(_process_data(json))
	else:
		loading_label.text = "Failed to load data. Are you online?"
		quit_prompt.show()
		offline_icon.show()

func _process_data(raw_data: Array) -> Array[AppItemData]:
	var new_data: Array[AppItemData] = []
	for i in raw_data:
		if i.has('title'):
			new_data.append(AppItemData.create(i))
	return new_data

func _show_data(data: Array[AppItemData]) -> void:
	apps = data
	for i in apps_list.get_children():
		i.queue_free()
	for i in data:
		var new_item = APP_ITEM.instantiate()
		new_item.app_image_url = i.image_url
		new_item.app_title = i.title
		apps_list.add_child(new_item)
		new_item.focus_entered.connect(func():
			_show_details(i)
			)
	loading_overlay.hide()
	_focus_first()

func _show_details(app_item: AppItemData):
	no_image_label.hide()
	selected_app = app_item
	app_image.texture_url = app_item.image_url
	app_desc.text = app_item.description

func _image_load_failed() -> void:
	no_image_label.show()

func _focus_first() -> void:
	for i in apps_list.get_children():
		if i is AppItem and not i.is_queued_for_deletion():
			i.grab_focus()
			return

func check_latest_release(repo_name: String) -> void:
	set_progress_label("Checking releases...")
	download_overlay.show()
	var github_api_url = "https://api.github.com/repos/" + repo_name + "/releases"
	var resp: HTTPResult = await HTTP.async_request(github_api_url)
	if resp.success() and resp.status_ok():
		set_progress_label("Parsing release...")
		var releases = resp.body_as_json()

		var latest_release = releases[0]  # Get the latest release
		var assets = latest_release["assets"]

		for asset in assets:
			var asset_name = asset["name"]
			print(asset_name)
			if asset_name.get_extension() in ALLOWED_EXT:
				var download_url = asset["browser_download_url"]
				download_asset(download_url, asset_name)
				return
		show_error_message("No valid asset in release.")
	else:
		show_error_message(str("Failed to get releases for ", repo_name))
		return

func download_asset(url: String, file_name: String) -> void:
	if FileAccess.file_exists(str(DOWNLOAD_LOCATION, file_name)):
		show_success_message("%s already downloaded!" % file_name)
		download_overlay.hide()
		return
	is_downloading = true
	set_progress_label("Downloading %s" % file_name)
	download_target = file_name
	http_downloader.download_file = str(DOWNLOAD_LOCATION, file_name)
	var err = http_downloader.request(url)
	if err != OK:
		show_error_message(str("Failed to make request for asset: ", err))
		return

func _on_http_downloader_request_completed(_result, response_code, _headers, _body):
	is_downloading = false
	if response_code == 200:
		show_success_message("Downloaded %s" % download_target.get_file())
		download_overlay.hide()
	else:
		show_error_message(str("Failed to download asset: ", response_code))

func set_progress_label(text: String) -> void:
	print("%s" % text)
	progress_label.text = text

func show_success_message(message: String) -> void:
	print("Success: %s" % message)
	success_label.text = message
	success_label.show()
	error_label.hide()
	message_countdown = 5

func show_error_message(message: String) -> void:
	print("Error: %s" % message)
	error_label.text = message
	error_label.show()
	success_label.hide()
	message_countdown = 5
      RSRC                    PackedScene            ��������                                            (      resource_local_to_scene    resource_name    default_base_scale    default_font    default_font_size    script    line_spacing    font 
   font_size    font_color    outline_size    outline_color    shadow_size    shadow_color    shadow_offset    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom 	   bg_color    draw_center    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    anti_aliasing    anti_aliasing_size 	   _bundled       Script    res://main.gd ��������   PackedScene    res://app_item.tscn ��z���*   Script "   res://classes/texture_rect_url.gd ��������
   Texture2D    res://icons/a_button.svg �����so
   Texture2D    res://icons/b_button.svg ��5^%?
   Texture2D    res://icons/dpad.svg ]l���?�S
   Texture2D    res://icons/wifi-off.svg -��p�      local://Theme_1csnl �         local://LabelSettings_q66ng �         local://LabelSettings_xjdy2          local://StyleBoxFlat_k85uw L         local://LabelSettings_v73hk �         local://StyleBoxFlat_nrvmp �         local://StyleBoxFlat_0ryde �         local://StyleBoxFlat_ukv0q          local://LabelSettings_hondu J         local://LabelSettings_rfj5a t         local://LabelSettings_bx47k �         local://PackedScene_ww7lb �         Theme                      LabelSettings    	        �?���>���>  �?         LabelSettings    	          ��u?��?  �?         StyleBoxFlat                      ��Q?         LabelSettings                      StyleBoxFlat          ���=���=���=  �?         StyleBoxFlat            �?  �?  �?  �?         StyleBoxFlat                        �?         LabelSettings                      LabelSettings                      LabelSettings                      PackedScene    '      	         names "   N      Main    script    CanvasLayer    MarginContainer    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    theme %   theme_override_constants/margin_left $   theme_override_constants/margin_top &   theme_override_constants/margin_right '   theme_override_constants/margin_bottom    VBoxContainer    layout_mode 
   StatusBar    custom_minimum_size    HBoxContainer    ErrorLabel    unique_name_in_owner    visible    text    label_settings    Label    SuccessLabel    SplitContainer    size_flags_vertical    dragger_visibility    ScrollContainer    size_flags_horizontal    horizontal_scroll_mode 	   AppsList    AppItem 
   app_title    InfoContainer 	   vertical    BoxContainer 	   AppImage    expand_mode    stretch_mode    TextureRect    NoImageLabel    anchor_left    anchor_top    offset_left    offset_top    offset_right    offset_bottom    horizontal_alignment    vertical_alignment    AppDesc    bbcode_enabled    RichTextLabel    texture    Control    TextureRect2    Label2 	   Control2    TextureRect3    Label3    HTTPDownloader    HTTPRequest    DownloadOverlay    theme_override_styles/panel    PanelContainer 
   alignment    ProgressLabel    ProgressBar !   theme_override_styles/background    theme_override_styles/fill    show_percentage    LoadingOverlay $   theme_override_constants/separation    OfflineIcon 	   modulate    LoadingLabel    QuitPrompt    	   variants    3                        �?                      
         �A                   Error downloading app             !   Downloaded Scrappy v1.0.1.muxzip                                         	   App Name 
         zC                     ?     ��     @�     �A     @A   
   No image.       Example text.             	   Download 
      A                   Exit                Scroll                Downloading...          
         �@                              
      ��?��?��?  �?               Getting store data...                Press       	      	   to quit.       
         node_count    $         nodes       ��������       ����                            ����
                                 	      
                                         ����                          ����                                ����                        	      
                    ����                                            ����                                      ����                                       ����                                      ���!               "                 %   #   ����               $          
       )   &   ����                     '      (                          *   ����                     +      ,                  -      .      /      0                        1      2          
       5   3   ����                           4                             ����                    )   )   ����         6      '                       ����                          7   7   ����                          )   8   ����         6      '                    9   ����                           7   :   ����                          )   ;   ����         6   !   '                    <   ����            "               >   =   ����                A   ?   ����                                             @   #                    ����         B                    C   ����                  $      %   1      2                 D   D   ����            &         E   '   F   (   G                  A   H   ����                                             @   )                    ����         I   *   B                 )   J   ����               K   +         6   ,   (                    L   ����                  -      .   1      2                    M   ����               K   +         B                        ����            /      0               )   )   ����         6                     9   ����            1      2             conn_count              conns               node_paths              editable_instances              version             RSRC     GST2   �  �     ����               ��       &  RIFF  WEBPVP8L  /�w �h�9���(�ú���������VK-�غ�/���]�(�ɜU�~����}ߩ畎���$I�#���+�QWf���%�_��������/�_��������/�_�����������;��ԳYN��/�s��R};>e{u[�a|�öJ_���U��ϝ�J�r�,O[�̏��a�Ǚb��/���j�e����by!�/��`���!��V�o�l��π�q�at�`�|(q����C�γ����Y�e��>[Ǫh����"�d��)P����O�D}[dh<���}�0ڢ�jo<K\���Ħ��VcG��w�ęs��s���Ů�m�i��R�i�Ŵ���ũ��V�*G[��m}���UE���mKT�֨*�-RUT[����LUm����P�w[��-U��֪�k�U~��*�r�m�*��`o[���-Y��֬��E+�m��[[���֭���k��{1���ao{)���Է-[ym���n�j�6ݷ-ܦ۶��Զ�]Y�i��������%�_����������E͛NI������(+���O�u�B�͕Mh��,#��|��i���Wm��	��m��f��u�e������F%� }n�0��y��9�^X���|Ə����p�j[�px��F������>n-�e���� �M��z��Z�ΩԤ�\`z���xJ��q;�>=���}G������ݙ1-�8���a�H�M�����7�^7�T$]w�69]r{��;��k~W��Zw�1��#'ƣ�F�|Y���o�=t��g;�_�kĠ�z�|�+CFz��*��b�>:���	���p���
(i���JI9�� ��NWt,akX�X�#�����Y��f�L�'ނ���4�t~��I"ҡ�MU���B �_U�(�8�Pͩ�Vbd��.�Zđ�7�I~f'�,�D_�|X�#@Nz"��=y��ty�3EϘ� g}��]g�E� �+X�s�}�i5l5���� ��]n�
�,��I�9h�s���R����9{'J�<GUs"J���a|�'8R/4hQ��~؝�9�@v��7t3�6���@�~�po�Y �_����m�u����n�*�x28�aK)�O^4�FL����d� �½{q�VeFVH̾�anѤ����[��_B!L�����I�%0�1�w��� �]]E��mˁ�8�^���/� �}�^�+G8?]�$�q� zK�@Ç1�CN� ��!S/J��z��]����V"��\p���Y�߽�I�rz�" ��q���_j*����#���5IDR��ܥ(��7�֔�0���N��\W�ͻf�`W�f�9�h0��'��;#�1ϱ�1��j��˃Eƕ6���x���n���*�����N�L�`��'e��o���}�4M�B�y���}v���Ϻ� ��aؕ*�LڻX���~^T|�=!��
��>{c��hG�$�9�$�6v>����J�+d*�G�T��\���%ڗ��q=�T`�C�(d�3�_)^�r��U|�D�K@u�����*M	,Q�%Z��G(�ڥ�F]�<���\�\���ܹ�@1u%�,�ͅ���&�}�!��A-��`�(�s�W��*	c'm��&��o'fz'� ZÛp,��D�.w-��u�UV�\�n��a=�qpl�s@[ř�O�Fnz��R
`�s��ν8Û��v��e�*	����L/�s���F�!�lr^�^nҽt4�^G���v���|�d� ތ���8F�̃�TC��{~�����)�b��X�9�9@�R��&��7�6�<[��{�ƣ߀t_�)������u��9�x5��%2��H�b���P����tN��F�!�хxI��Iexȍ�=���@5_<�_n0�F��XT
m����塎u���"w ��3�C����mx~��/�NI8ǋ)�u.�h*DB~-���Ƴ�U�A�����$�_犤�{D��U�?�߆L5N��\ �������,5?����f�ӹ�$����$�ܳ���	��f��C��R�~�	�wS�;K�=I"�|瘹t���@G�_ι��(�U�M� 7�����▄ӓ�����Uz䄼�|�V �.��*�v��/��Hc��@���I>����j��6�D���7I����Z��=\��T|��;G��>���m>�G{w�7�up��g���������M��r(,5(���.K�<V.�~�nLw���]ʺ�/�s�������D�W�^��̣P�\Q|��U +5n���ڰ�������K!���x�:w�'�^�|LK5�T�酰%���4�m�׺Hqp�CB�'�fW�DacH���H}�(��(໓2G\/�}ѐ\��'�SF��
���E��bf=T^���D�X_�tX�ҡ�(�ck�'��.B!� ���p�7�->a,h5���j	�f��#E\3	���>����l�EaM��F�x�# �ţ=Y�lݏ3KhOwG�y��� VUW��W�j�_� ѹo<��[���R��e�<w�M/��
y��o�1/
Q��� �����?+<�`z�1�vw#�i�,�,�'�gv�ed�O��]�����fY#Q��dX����j~�"�W�e�4M�H��<���r�s�U��6� �o�J�c���E��ꬦ?)��}�)gF]dk*.9n��pp���4C�pe��*��ƚ�p �a �)g�Y+��(s�F3Mۮ������1�=�Q)<�ܚ~(S�}{�8l�1��;��;���Կ踞�)�ۣ�����]��l��G2�c����}�oi7pnnY��	�4��1���8r۴�ۈ"e��;ESm��ˌ�~:�Q�l��}����j���_vF����`X�ѷک�����9�n���`�0uwZ����������L���$������|��sh���K@+&i,[{�x&����k���$�/������/�_��������/�_��������/�_������g�    [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bd1gne6xmsr6u"
path="res://.godot/imported/splash.png-929ed8a00b89ba36c51789452f874c77.ctex"
metadata={
"vram_texture": false
}
              RSCC      g F
    �  {  ;	  i  4  �    	  i  �  n	  ]  c  �  �  \  �  Z  m	  �	  ^  �  b  �
  �
  Z
  -
    d  �  "  (�/�` �Q ��!M Z�;dG@?�VO��@2c�z�*l�F��]E����{���|p*�`n90kҘ�2�� ���bAT�NƑ�e
���G�3&��d�^۟@c�ܳ�D�4!X�<"�T���K5u=����04���zl��K��j,I(�Ei��D�w~�S5�r�Kzd­��ɥe+�z�хګ��0�!��$*���G���B,+.<����.[�L�u�
�m��6]�Ų�:"�>R�«[��"TGv���Ag8~��N�ҙ
�@�]�d�D����W�Jt:W�"{l�^�,���]��تB'aԓ���˩T����k��J�`kQ�W��ճsmU%[l.�ġ�6U/��p=U�_�ӹ��pmv���5\�TZ��\���
�ސ̤�l�^˿vsm��q�v�K�)Du�T��ɵuRq��H$�kֹ�js�Ut&�ȕ��D��:�ⰸ*��s�\�J�Hd[dW�?R.ٖu.�C�
�2��~>۵�����{ERi���U.����J֩�H�m�꯳��&�lr��jsU�Ɵg�U�kRU�^�+�9\�C�J\"�+�ٵt��?����e�H�H�\�m������ݺw�{׺Y���&�w$ɽ�Q�u����ܻ���]�~�c��nf�������u�����ƣ|G`&ߕ�����{�B�w��|G]�O���!��f����>�t6z�=d9d>��p2�92�,��lP*�t�0Н��=�5���VL�P��m0�R��aʥ�!-�
A�ल�V�f�ja~b���FI���ĊT�'M�\$1��3ų��t)ژ��MJ'�#f
'�!�ѠP)IN���Z�,Ȍ
'�tZ���a
g1&�ڵn���+����Q��-�F�1�g��W. �����,�YCՠe<ɠ?��jP��x�yf�<�
��j(C��s�A�zt�z����)y�c.ReU���Գv��;�r��O�+�sp��3��(�bl��bLj�n�P�n2��GB2dAe82��jl��J����q���j���8S���u?��;�_�^P��sm2��4T�E�A�sɜb�2̾I�1Tz�6j�Z8Xp����BK������v �	m�m�v��CKid�Y�R�G�>�_RRҫ�*��:�Hi�f^3)�(����,j�4+#�"�"C��@h��K�&�z�\��M�B�v�8����G��b�0	[��~���n.-�k�u$�B.u��]F�ҽ��!�ץ����q�He&0��\��U���[��x���88��x����ku�� v�i���hvm|����NVGj�7Dy�<Iq��\+o&W?���+�r�A#��ɋ��z�m����Uu��^�{Z�nZ����K&`������W�u���Ε�gG�^o��u;�˱�ݮ|��{;g?����l�p�͗G��<��v��͉;.���ۏ?�9�{W'�F��r�|�q\�9�!�Y�`�ҳ04Ȳ4hnT4�ʀܷ���=d8�L�hTv_��A�i�&����]���V\�)���������-�v�D�|<�x��鍰�P	�B�4��	��!CP)H�	΂` � � � � e �= Z �T��C���A�����ɪ)3��A���.&�)�&L=L8Lo��X*����r�hi��F	L	���w�G��'�/�������~T��_9����cK�9�H�")�� ��$qIڒt�H?$G�#��#G	���vG���O__>$|>���`����������ƌ�11bdB/����s��
P�0���Em���x�FDH� ����W��^<x#�4�E�kyG�*�/���aH���!v(��&C<C�B]Q!ĄB<�	� t�	�Bei�%H+H**H)腝;vUv���Nk�d'd�c�@+ � �@N #����#�O��(~��8���'�ϕ���&�����>c���Y����gI�TT�RQ�N�Y6R<���x�؁b���;L;*�2�u�X]�&�": t@���G�A��X���I�rJ9��Nn�C�4:gt��0���!�����
\8#p=����-�.̍�m�-���� 7�ߍw�"gM�9����V�M����lXlUlJۖM˖�&�d�ٶ�Q�R��E՘jE��˨�,Č4#3��$)LP!����cJ�CL�"�Z����$�Q�Ο&�k=zS�κ��弳@L�ܟ*�Zϋq��VN��au(��n���h��v7�  ��&�{�/.ո�t���W�w�=��w�)n��T�U�"�O ��;LZ�g������_i��Ϡ�ey|��iU߽}���R���Ԟ� ��,Z��A3;���P_�F	d��A8���d]"��
��B-i`�����t$t.��ؼ=#�$�<G����
�_��Nx���W�+!77?TTt�:���W�ǯ�Mjx-�l�AŅK�j�+s?�ȓ ���/��(/ ��R<��A_�~d���Ndڍ17�P���3����]��S���U�`є�ܽ�XC�l̓�� ;�
�J$r�VR�!�.���y�%#�����3���z�r(�/�` 5X ��H)@0se8�>*�D�U�d�Z�/���;l��)����2|5����F���ܰ ����E1B�L)
�*�GOE�C�A�>�ç�S��\�C����
�+D�h]!��_��ύ�#V��8�S�G�7���!�>|Y|N|�����WE�J�ʤ=<{~{i{&�5҃D�
*~���r6����IY Jc��<ywP
�x��=1t"��	M<4t'xWu�I�?K���-)AI��Hv^���n7��YG����:Ź5sT�.̕%�K ��I$P�8*��%"R��eɅ�4$	� D.� !���h�k�k��Gww���>���֣�Ga<�8�8�rN1g'#�#�;pO�&�;b��q�Λ�[�76:�:,��q���V'�T9��QiCk�j{j��4�l�5�?�7�dMM��T��Y�M� �C68lf������~��`cā��n� ����%6Nؐ��h-q̓5@kz���Yk��f�p�jMM�Q{4�4���1�<2�dR#���'F��ҞidiǴ��Д��@CCc��D3CON`,� �"��4^:�s6w�<�:#dvhf�,ά��bY���2�����A"�Cv�,��Y�?c�cyctc=�V�]�	�#&E�N�I�1,Maؕ�����E.�\�bK+-�Z8Y�9��`s+�|��
����u��#/5^�^Z����x!��jz�y������LW����(]t1��KW\\\U\����E�Ɉi�	�y��\2��070)0�KHKDK�%�e��ےƒlٵL�b��R�HA�"*E���������w�m�(��ZJ+���*+m-nnEmA�����5$GV�H�#r��6��G���G����(vtqd��%�RGǦ�	i��1-!��>J���顴Pi�)�t0͒�}�YJ����T+E���&g�Mȶ/hZl򠩱�Q���D�@�� �IԒ�&�0��'$ڒ�$J4��A�Lы��"�"�(��x�~�d�S23���h�����hQʴ!j䫢v��QVE��Aà,�`P&Jz�*�Q�I�$r�*g}��YѬfV���:ǵj�k��êaŰRX��*U�*���m*��B�RU�X*	U���!T��I����ă��4D��J	HA�R��)uJh�p)@�$��Wt��c��.���'G�0�b�P0�T�t�{��pI��URM~HF%5$��M�MbQYQ%���6PU�N��Yݬj�3k��p�[��GV��k�ZQ�VkrU�kԊa`���Q����S��ީFT!j��z�z�K��z�V�T�*�
�VP��H<H���9�:)�4+�JHE� R)Tj!=������9���n������|����x��s���l���P\�v���N��vj{mKJ�HL1Ĵ��FK_�|q㥅?]��8!D�qYry�hߖ�-8� �|08eplĠ�
Z�d���,{��'h"��6X감���p�	h�J^ l���,;h;�>W4��Y�^|�T\�r��k,��؁�1����e��X\�R<������|iL���(���A��`(��'3����m���_��m~�tﳘ�"�"z"r��d
��q��������\Wp@.<�y+p	<�4�r5&��r4�r2���{����w4�7����:�]��ۓ8Ǒ��\�A<�?L�@,�q���0�ù�8\v�:���fs��y�κ��~f����,�O؀�0չ,u,[�^��>�N�N�x��:j);r�L������<��|��������'��_�_q��}��G��Wxzߒ�%����0�vL��:�N1;�x��l�5<�M3�e���������۶l�\(��{L},����Vƪ-�g�t�&�poC����y�ϚY�-�Xֹ~�f���%�~�;�s:g�c.x+�{�ǽ�lW;���u�M��9��MG~��U�q��
Y#+�?����<�ò�X�������{���as�KX������kVͲٷձA6�"Y�E�?Vn��=\6�Y)�V� �l
X�Z�!����� <)�`8��n��d�.�!u�͖�8�g��K�9.]����%8R::M�Ӈi���RG�Y8f�菢S���/E�<unN��O����K�:=iiJ�4ܓu���iHPf\�c ���t�u�ͮ1���Z^\-/.�ڒ�a;��Ű6���M{�L��Ɵ�J��HtG_�W�D�m����3����f�,�%�1�eW�*����q+h-�m�w�d����۹M�t��|{e����9"k�Dg��爆�x�{��z��������[`���ɟ^�?+��݊8��<���!�b!��9�����,�6���ի��S8ĕ�p-��������##-�N�d
��&���M�W�)ق' _�7:�7���C����90'�	�ǆ�3��f>��܍��ky��6�r6�~?����T��SN�Wb��y���|���]�Y��U<�̫y�/��(<�������p�` Ne�a3,�>��`���"7�]o�����pJg|	�t�茾�."�JG�D��$l�*.�u��vъ���n�L�6�SC��ZB{h��iJ���TJ	�1�3""�-(��+N:�s!	��A�#0�X8��(,n��� H�����c��g<[pyu��Z�[ѧ���]�GX�@���_��2�����?l��'���R]WOih��C�GB��E�-���֤C�
����5��[0Z�yz�V|�d��p�Xx?j�km?��(�/�` �C ��Sp٦�9��|"�������t�w��uIP�?;//����ߟlW�z0�?�_�V'�J3�5xd*gFk��G#�x��O8"g�2���{��y�<\���}��]�s�ϙ�֙؜3q�{X�E�9��g���.�fco��x��w�C��}�6�9�$�s۾���x��}��+a��^�o�k+��漶:�-�-}m[瀁~�\���
��,�	X����a�y�`o�7q�7qћ8�71�M|	V�,�w ���:���z��3�xvy��[v|l��������1�����߾���x!x�<��y��vc��Xؑ�<�c��]��i`���B��8sx/V�5�|>�L`�Q:�S:�Q8���s46�o��`��p9.cb�t�m�¢>�*�d�[l7��(�QJGa[JXp��L7�M�7pݹ��"���=���Ƴ�=�Oc��� ]���i��4nO'�������EX�&�'�!n]H׺�~p�FZ�a�a�������<LL�(�F��$O��z| J'�p��$J��(�M����>��W��q"NĻx	�ൃ�+��D/�����Nt�ao�ڕ�v^D�6��kw�{�]��*,�,,�9l�2���q�ո��E/�@R��������'���+�O�o�����Kq%���~d�~d���6��������k�3�a�?mg�u-���L~���<�w�˞�8�טu:�{�Օp�G�)πw���6z{��QpKgᣋ���}�>pX���ߍX�F����?|�&�sÛ����_�n~�7G�7g�<��e�Џ`��G�7w�������հ�����?����P��Cg�o�n��M\���|hu�����_�a�.�
]�E���}��������H��3:$p�Mi�]a42�:�|֗��})o�Ÿ��~.�,�[��O�5�S�S��g��Rյ��X�Rox�0&�eũ`T�%��wKh��+�R�ܦm�m�ߛ~��U���W��4�bm�@`MI��Fr�L���Nת���ڶQU�z����ʓN�pH��DY\�4Xn���
?���gbJS&S�5��z� ~bM3Q�$Yۤ�D�C~��v�%f� tRJdi/�=.�i"K��S$I��RH �4U�3 ��6-B���VSo��4�yR�t���HX{�l�t����!X"U\{c�c��ز<N�t={�)M�bM�"M���]�[�Dg�/,EԢ��O�8�Ҹ8y8D�K���B�u�d�"���4� "�ȩ�P��3,K*�ZO3��D+נ�y_�����6���NF��&ߞ���hW�J�'�d=�G�.ۋү�F�%���,��kU�ᇣk޵�W34�.��K���>��v�����9���AM�v5���S�t��[F_�
�,���0�5gm�^��h�![c�fO�Cq9y�>��Q���W>������r�,�?��6]���g�+���H9+�YwNΪӝUŝ5����Yu4Ȣ?�����z�WZ�;��J��C�1HR��_e��u ��
�r� PΊsr�Tw��Yo��6{V�h~֚I)��R�9���	���|ml�(iX�������1~2=���W��u:�-n}���.e"L�ė&U�2�?oCm�P��9�T\ӯf;T1����Y1�ۢ��9
e~�T�^
H��#���#��9�Sw�A��L�_��4-m�c��l�wK(L��t\�i2�^�"�/�ᨑ �2����H�4������%N)dD$	H&*H

�`I5���&9��)�����-��
9F=�~�Y�̒)Ց1漝�XX��D����~_X��bG@(ƈLX�atcA�ȉ��"��	�-��T�C��ۉ��[s���%,���=i])f��v�gn@�1X��6.�.�@-���
h#As���-�*�M�	�)3Y_������?K�c�I�B���{�+ė��W9;U������^������K�P��p�z��	��P$9#��� ��g�/A��A\��2iAE��p0��K�������r���O�{8��칁�-��;���S���4MN�����8�Zly7]s��Cf�싐)ݛS���L6�G������(a�c�����'r���h	�-�VH�ۑ�ǖ��c�{g]�%��w
78\�r�xo(@�����q_9�+(�/�` �; c�H��QcQ�f����8���Km�1:B�a���l����irm{��p����ÖۿO��NX�%�p�N�!�vK)S:GN: Zн��P:�{�`S%|�VP��\��6[���t�k�8��p>��.W /��N}�l�9s�̧ͪ���������K��W'Ui�?_�&lڬJ������Ģ�$�l�N�+�f�F����f������:եƛP�E[������ˢ�8�-�bw��fK{ZG~�6�kS�n���	���R��Ŷ�ڗ�B�ko�Ţ-�وA��q9s�v��m�n���i��?t���Н�x-0͙[���]4�b����M"�_l�H��ܺ������x�;Y42mb�[W��;���)T
�~��u���rfXMǴF���51h�Z��l�gK_zn�;��D�����<v�������������æ�׵O��ǵ��ɵSԔ��(*�6��0Ȯ���Dt�P��p��闼��C�y\},�V)����JT�(��H��J-G!<�:�n�\���{��#>�زEPA�V����E[͖�26�j�&��y�V_=(���c���\�p�X���F3��\eĀ1�.�.Z�����vq�庵Yշ�6�6�جʴ�z_�)����	%6�:�D�
�Y�±�5nV}!"���ް��o�Z�[��U���67�Bi�l�������fU��RmV���T�~�N�OR�-J�k�f�"l ��r�pa�EH;��5O;���e�mN�_��wʽr���'>1&�HXK�ɜ�K�9dz�HHH�B��~�~X9e@//�!:�2�F�ӡe�f�CP)(T��G7��j/�����g�ϊ>�:�`n���9O4�{��1��ԣ�>�<�(A�*i�D
���&'��o`t��
K��Et����tw��k½���RbFA �\��"�պ�º���"G�0��c
%*U�pAG�Ei�%aB�@Aю�T!H��V+i�W)��IL�\������j�=za.e��P�]�3�=Z�����7��>t�ܓ�v�ӧ���^��up�=�e=r���|��ߞ�@Gi��k������>��HG��M�[��M���tk�e]�ʳ|��3��{��0�?S7��\L�".�ɳ����o���f0~.�����O��`|F �d|]�e�Y@��埌� �����.<���p�n���8����p�\s路7��������Gb���~�\"ʛ\�-r�����'�{�~���%��{�8s���ٜ�������c0�.�����(C��Qv�w�A��L�@Y@�2��{�,�y'˲N>��0�W��"� �8�q8}�q���)��H�e��P�H�I�$���)�� 4C)1IJJ
�k3�b-dku��Iy�I���	��Q�O�1(���4-��2�3� �N��3=y�'4x���'���8�������É�s�M �p,�Җ!�w������������ũƟg��ls���S?Q᧓(�_}�;pe��3C&�u`́P`;��{Wpb�ٱ�is|���<;��A>�ݽR�>�g�X��x�o��"]��Sa��PFO�7�~��=��r��ٞ�e���"%j�1[��E8�C��y����}+sh!���PW��8L��D�d��Y��J����F��sǃ+�n����p�`2@���vV!7Xm������~NCш��BO\������[�s~g�*K��&s�9�X��gw->p�9Vʗ�gn�l���=��vV�IФF|�`�������rc�p�Cf8�+���d�%r��+'��zjj<�'���>�ؙh���=�kB�j�?f��w�?%���q���tbh�P��4o"���.4z���.�,w���e��L7EРj����(�/�` �I ���?p���4CsI������c28C���d�K����Aj"�b[<b/�BO.�[����n����v:j�J�j��wZ쫛��N�ӓ�>#U4RMܡ�ʓ�В�YR7}�i���C��P?XEL?c1
��^(i!�Ϩ�7#��_��~5�C2
" 
b�����z���x�ρ���H�ģ�H�Q8��?�Q��_��S?��)���g
V�o�M͖�d�S,&?��)�&�����v:�}��xz�u�~H���WT8
F�����S��>=D��w=����<�G��_���֏�xQ�MW����~�k�t�tM��J��q�Ґ�벸�Z�j~c#v8X�@����Kˡ�xя��*s���.`$��}ˀv��5���%��o܁��z��Uaʾ��P����ʥcz��"�^]0b� w���^�+vE,c��eؿ �NC=���܇�e�b���=�s���-�F�`�D����n�v3��EU�~��툎h�4v�74�����ڡ�9�Ԁ���cX��r=�p�P�1fy�5��C�6�ч�P���:�7t�6d�5�1��P��L�m>��!LC4��3L��l>�fh  4c�� �zu�� �2�a ��x�1b-F+��_�]x�\h�[h�_�b/RA-�bVy�X��,�8i*O�
�h�W�B*��)��(D���	��	�0��Vqm)Sq�RT�$L�(F	�x�j�q[e#L�.´�H�N�@7���0���?�P��qT�c)����|�p����ժ֥�
����q�*��X�	M�t��ܳ����i���{W�;�"��yNo�kzB^���~<o���[Ձ>��6)��%�*U�*�?��7�a#�W�,�_�t�^�R(�M�d���V�]��niV��Y��K�*��	h �R,�R�4L�t�T�ۀ��K��Jq������W�}@hX��Jq�阊��X��^���]�m��n���Y��Ԕ
"4����A;��r��A3(��jA+(��t:�r*A�A!h[��p�@蛺i���Z՚��V�@h=뚪)��4�s��P&^b35�����L��h�� Ӳ�i -4�F��5�Jֱ�U�V�~��v)�n�W��U-�j�nK5X����5��|�X�ҫV)�N)��t��ԪP�I���J��lf66` �*�B������H�J�NҦ
i�)S�G-x���Zg����݃�+��)8��;h��$�AI��,�&�8ߠl�lp�9� �!1�#��3h�����t�	~#�Q�]<f1��`F�����\6܂Z0b�D��V0�� ��)��R0
B�'�<DC��07A&�I%� N�H��=�̻��ǹ�.��H��A8bD �}���@�;u���΁8������a��3Pq�1������^�@=t�-���
�C�Q�	4�wXM�<�Xnq�!��7ls���vYZc���]�X�.k��岌e�v:�.��-�,��憖F�����a[KKC�Ӧ6�D�6q椹�Iҥۅ-�ə��ֆ�[�klmm�������-i�tZa�,�NK��5����ۅ��ް�YZ����@X�}y^^���my_��u=-��YyW�ʣ�<)/ʳzPޓ��5yL oɫzTo�I=%/ɋzH��b�h/�/v��m�c��	�=��^�o���<�G����JG%u���8
Gߨm�lt�F�mbH��8�>jߙ�K�E��N.�'���Ѩ��Ϩ�s�s�F�W8�,�d&�0 ڍ۸i2:F[�Q?X��Q0�E��**�0ݢK#���,�E��Z�w��SQ�he�'1�u���X��ć�>Q'Ă>T���2+p��l�_~:��C��5�d?+��US=d"Kz�����(]�J4�"�#jD��*�BtP�����C{h���
�:4���jC��Ok(��2�Oc(���=}�z�B[(����*tj���䨑���\��BO�	��JBGh���aL��1�Q������x�<���� M=��N���A�6xN��7�ބ���@�,����~�<P�.}�kj����B7��
�k������ӽ�4�����""k���������~����~cE�n{���ǋ����g������`MG[�!-t�O���-�aOZ"����k����)��a9�cԗt5'�l\O�t	U�)��K8�@у���]坸��>��K�>p���?�xN��W��|=Mz�V\G��95Vl|w�Ғ���3��5�t�鱦c�g�)(�/�` �2 �OP*�ʦ������"�i������U�����h�zu�I��� � � �:��q?�aSED�>=�v�w�q'���R>C�f���P������aÇ���MVeæɵQN%�)e�2v):�|��{�%ʍ��#]���9���"8M�P�.��ͣ|#���Ym�&'��06bUZ�khX��'�I�����b�i���)cSE�ƛ ����Z��FaE��.6Qܔ�u'�.Sv��5U��=�rum�vY������K�\�'��J,���A�"D���,��bZv-���ܓP���-g9��\�uY�M(�ǀ��_��Z�������Q��A
#)�	�5�L�v��.�})!i!�}8)��sR�l�u���S�N9�(�@��2A�iy￈2�/�(EPR~�e�5�<9��E]�� E���@���S��J����Ʉ˪�b��L<&�	�D�nrU��Cb������4���p8���%�l^��U]eR��^�,Ab18�2wQaە,��Z��%`h��Nb1\�>X�FVx���e�-����?��������J��e�������������Ri�'+���Г�y�B(+�����
�d��e��^VxYk�*+���F��PH��BB!qH($*�����`�����pжm�ܖ�-TI2�9"�rsՉ�|���&׵�c(c"�\}�#�9�J���nVۨ)@Tx��������4Ƶl�v#
����ŭ��KYh���[��c䣢r�G�{��D1T�g���~��}�M�J���an��u)�]U�A�v��f�E�&@�~G�[b�f��9�[FVY)z_l���u#�l��u+׵.� %� �~?�����o	�T�*���M�m�J��GD3b1�]���
���~�;�����&������v= 	HB�^�����(.%!�$I��� uD=�0���L�tB�����-*җ#K���/���.n��@����,�3��%x~�-V=��O��I��_.�@��2;�J��䥔�F����֥4��i5�����,��o���K	�RD�ZG��"�૫弐#�꽛�9�w7�0vF��eMD,��3�1O��{�<-;rL��[���͊s���!ZE�b���اJ�����P΃���ٚt:�����{��(���4J������k`7F�gS�|f�RRB��K�c�n�6�R�Y)�c�`hPG�=&?A1pDAyŊ������h����(�=	5$��
�w�8��9��� �*�~+L� V(�4Mg|4�/�'��j>͐ja��#��.�L���ƛ*Ka� 0C�3����0ڨ�֔��p����#�C�FK#M)%{���r�8�L^�c~�~�x̢�hJ��H�5���X�bm�=�I� �Vw;cʦ���\0\/�|4�)�jT�!��\K-�R�j:�ۡh	��6���i��[|+舀�%���-.9��׻�_�
_b�HO����zNܙ�	 �ֱ�$ׯx�0^�Z}���~�;4Y+��gE����ٷ5�)�y/|�u��/���|X�a\x0�"�Q��K3�]J1�af
��L��>z0�j���Ȫ�k��(�/�` U! �n�G��Mk|?]��L�s����i�E�(�{���'�b	#D���hM���cL�{7{۶V-%�M��K�7!��L� � � "��)"h_�l��@'�ӂ�A�S9D�S���c������c�?I��v"��ȁ��� �$�7�(���k����p!V��ۮ�	�:rG�� J�h�P���]�#�t���R��MA!��PPL|~JM$�l& �J�&�Ȼ�;���	�τ/iDr�J
W=�?bq& �ěk�L��r���b��������1(���\4BzQ;�+��iu���Z�c��)��k����%�g-<k.�<^�Y�.�q�\ϫf՜�0t>o2n�s۷�9�<�מߞ-ࠇ��_"j*����Y�q�/�/�ȑ!�l�'Q�o���>�=3m/�=�1(�!0����c��$ʽ��h��t^�6�K{�s��u�i�oƉ8qv���1�ƦC����Z���`T������u=m�Yg�gۆ�<�����
�>9z ��Q��{m�uH�ҪP�ح�I*���>�^֊+Y��!SM�4�688:;��V����@������^0=QIQ�`��ʰ5����#��D�A��ʔ+�����_���46�S˹������'�F�{W���*݁�1Qf�DD�� I*q3f�:�B1�a�C-I$H(� %I�5`���	�CD8��M��{n C8���p��(5@���`0��O�3�	2|��4���� P�d8���!��N��CoF�!�uX$^�Rҥ��p/�˝��D�XH�	e�5�w�dF��|���̜�z&N�8��O���q�F΢F16�BMG��~�`������͈ZN}}\���f?̶̡�b��(Z'��PMn�X0����,*>�0����x�~�T���ow�#�!�Q�����
���������=�E*��[���q�Y,8~�1;�&�ֻ�O�V)mCӎ���7�Ul3_�0/�0~L�(4KvԿ�.�HoR~�n�yT��iE���f�6Ӵ��=�mt�Wns�2ɐ��&��e�3F��S(�/�` � ��^G��(��g_K͡�z����qQ0X�z.{�C�o���Oo��p���K�c`<x�������2����E K P ��=���ӱ����h�ێ���j� ��-n�V��}#r���9�<�	DCDFN&�T|���eŊ���E�y��Ast�"�ψ�'R�h��B�H?#�i��fh	@��c,����{��`B�����ٗٙ�6Vs�c�Y/�k�&_ц���!?$��|&E��d��b��CFRjP� %`@げJ~�@��ɉ����Rں�Ai4G?N�M�+��J��\�+_`bdj����L����C�ق��nC�#�����Y��Gjeq���R��"2rJ��R�(���l�+���'�Z�#W%�@b�Q,B ��@$K2�nPF�!͟��Ddqpux3�H����H
w¬�h�c�	3���TB��)Q��AC����#0��΁�<�qH���m=H��x�:'��y
���a�h�w^R����uX��54�*s�g��~`4M��`v[`����Xv����<��X��p�f�gl��c�@Ϝ��{�>"N�ĕ��3H��[FW8E�s�e��X�K����U�98K�G�s���������4 ��u��ECbr�F4}�s*�˶*e��0��66G C���2/�I�1�SxHt<�G��`5z,������x�:�
(�/�` 0 jFD@�l�rG*m,�������HM���T9�,6rB��C A��)�����G���n`J�|����e
� � � �����/@B�i�O�������C��*�9����"}-ȗ���*}���!F�?�$H�i"�OH)�2�S��3mH8sȷ��D"����?*_�d�%YB=(x�PZ�P~��D������u�(}D�#+˰��	��J� ꯔ9m3�L�iޠ����С�� n�Ā �o�����TE]a�|�������~H܄�~nލP��ۉ�tv�RY�e�v��O(�f��.U	����]���J�.:;��Qf�G��jTAg������XE�U�v�Q1���2���j���W�}��.�+:#�/�V��Ϗ:ծ�ghWj��Dg�v�w�aU"�g�j �뾨Ϣ]@�ڵ�i�}rs�m�!�O5�Q@}��������lqlul���l�
������)����ʄ���U��-13/1bS��MѤ�k.���Ī�V��,���Zk��j��yJU��Zթ�Ʃ���߿��߿��\�"KK]�/�^��76lLӬ��&�UW]u��F�ΉÂQ�Q�3!ggB�,\�p��(..����눃N������%�O;�F�i�L�l�0������))%XELLjR��f^bRiY"n���*t���Rtv��is��1��\�zƽ{�{�9v�k�����]k�t��;�����t��N..F����z�^���b)�"��X����ƾ����v�b���v��n�]w;��6X��>_}��o88p���� �%A�$�!�d����G��������2�1�[�Vfv�b�<����j�Ú�������}EM�4M"X����N�#X;�6v8^-�Mp�WW�Ǩa`���)H2��!	w��#�H R"Ry��R�1h5���:����'�h	.���#����n_&w>/^�"��b���Z�Qo�,�6���D��#�g��nb�Yz��G�1�V�����TJ�3k�ݺK��k��q���A�M�$9��Y�~��w�k)1��m؏p�UY��Y?Ot�	�*G��y��'d�!C���:�5��4�;��Q�G��%�C� 
��G�lG���f����b��x;3�݅�ުE��q5Y�w���`���'+���bJl��w���=)V�!K���_|� G�o��[�7
��Q�W=�;r3�ч{���~o�H&f�sJC���	�2G6��ߦ�̢�HG�
���E�;���'�p/�_��C ���FM2����O9if�۰���v�b:��8��jњ���E���Q�'+7�۞�.��G�4{�e��T;�r�7R�ż�z��Ig_�h0��
4��A59СvF���X�����<�2��F�����#�I5LLq�5?�k8� m������{�mWI#$�I�#N*1!��Cp����F�/�
�w(�U��釆�%��F7���A���ƕ��e,6T΅�;�(�/�` � f��B�V�r ��Ac(]S]i*��%���@�b0#a��;�w�CÂO�TYӰ]tBV�HЖ2� � y }�w�t�|�T�"g�۬!j�jh�a��Jހ��R��IlR&%�*i�Gz�Cl�������H��,��\A�At��@��	����f�^���#�E2�{[\�E�����E���2�g���)�ި��(���Nu�SMQ=Q-Q��MCD]muUU���*�V�7&�F#�Fg��1:�<�G��;���~���;؃=����{�<�'�&��#X��t��w'Q���8�8sǝ8�H����IM-�% �����S���iשNW�4�]EI�5Nq�}ӛvԮ�
�V[�f��ӫ�*`UUe�k���jjSMU}�ˏ�-+Q��o��$&Ѵ�6��E\��[�Hc�3��r�(��2�c��>�ў��O�<���^�WS�n�<�G��zS�GyA����w�n��Ϋ%���E�����'�jo���'{��=�gCzC����Ӟ�#�����+�Z/�2��uf-�¯7��u��eaL�2� �Ȍ*��\�
�mU�+��hĀ����0����dc����� S��D�`��B
$	%�[�9�x�;��̟nY~G��1 L�yʵ�c���uO�/�n�A�f�'u���&noO�~zf _��J:2�Ss���3l섕����x#�F=�|��HU�V���dJ�Ӄ�$�}~)�lN��+�"�����_"�'Q����^�]vx��,;��=��v��v��w(6�����j���v�ͽϢO곸/�om�nG��3��L��H,�^A����Er/��u�|]�>�Wĉy��T�G�q��]��\#Y�'rt��#n*}��1c�Þ�?�f��_Q�w�1�T�����m"uT�2 ���{3�&�\�ݢx��T_0d�;�k:�������߶F;�
n�@b��iƉg��y|S�ֆR	����k{���h(�/�` �" �$g@ �8c@Q"Evw����MC�ʥ|�?��z4�H��C�C �� � � � 8`�ʵ�5ǜ��y
N U \ �6�����kkΜ[��dݖ|���u�i�Q�qܻ5mZ�����^�'x��v�����6���6u�tvC�n���ݶ���-��M:k���٢�V}�ͣ5�1G���5�í���mʥ����Աq�kwZ�g����IĞ[&�<��- )��[�U��HXdn­|���9��S�.m�M��t�����$�s'���AI�Vzف�-h�3Ch�q�A��zt�bވ�*X���gϖ��/��3�-�sA��(�<b���+�2�0�fM4�m�٥Ek_:��;�3�g���o��qhl�ʍ��P��G�O�����k��ݚ+�6��v�&$%"IAA��1�)�K;��@�S� �
&�@D�Q�$�oN�Fá�����:V���oSZ�`���N��X���f1��%�B;Y�D5	��I�s���6c�׷�n�a�� ��-�glO���J�x������bOEQ�����w��N,+g����c-g�5���d:;;�7J����[� R�x�#�waqS�n�so��(��_�yJ#�#�d���^*T=,)�����g��Q�����(;�l��f�'�7��z�݃���H�@�
���.e�l�fE�q�|��[��υ.wC]l[w��v�;q��`�)���ܮ��/����`��(���]�3�����y! G�Ga$2q�D�H�k��h�*
�v�'Z,P3�����I���>���2ͱe�νa��O��I��YН"{�_4:�%�wk�יѶ�Yɤ$+N>�F��D��~h��du�4�=<�� z 洟����R>3���M(-�a�t}$��/�V��.�	 9	X��n�V5T�8�m�Q�v�,�FA���^�����M�)���k�b'�����,.�3�`u�U��+���6��(o�����p�<�V¼� HL�|�'�o��;8y��.?�����|�,��Ze���v���2i�{3�oOK��g6��� (N�	�f�������W�ϊ�0�$�/j&�(�/�` �F 
� G �$�?��%�7lo�/,^/h�X�E�����P\�8��l�3��e�I<���4h�
�!����n�����c0�EmC*�v/�E��]��GŢ����=E�Ȋ������q%���>-V�2�:�Nc(N�tZ{N�t���)�]:�K�t6�r��WZAgWi�֦�Զ�����JgOi�-�t�U��h��@��z@gPj����Q���Jk�'���N�7i�>��H�u����T�g��g|�M�1y��8j-�b��hW1����X���m�w��ϲ���9l�|nsg3����Ld�ʎ��R�Zv��ܭ�:� W�4՝��I��@I���5
6B5�aE��Ќ�@XF����0�`t��/�� ���;��v�6*D�M��AF%�dp���/�D� Q-�U	za=�G�P�phba��
�]���E�(-�-}R��Y�R*}�>�;iT#է6���@<�Olg&&4�b�����e+���a	�Z�H��k�_��5nE*ʿ�L#�Qzi��K8r���˱~62(�=�m_��<h��e+�UD�H�,�UW]��RL�t�H2�����(uD�R�� �H	^m�^H�������,������hOL?���[�i-�Eig�,�5Ţ����$����P�� p����!�s*�J�i�vڥ8�����n)�Lo�+�m�Vʴ��A��	J��h2��&��h�2��կ*�ը21m��ݩNe��M��u���r;9���<fb$�A�$�}��a��4��<��k��f5�N3�g���P�Y̴�f���e��[�[���k)KyiF��ji��
�����C�O�l'�y.B��"�q"L�W#BDdBH����iA(����B@��0C�zP�ƃx�q��������m@Pv��R��-`�� ��d����V��* �o�V���T��(`�n�B�נ�jN}���e�N=� �a0n� �����zA�� �znA�C�p� `��Ă����܅]({�P�Wxz�2�]�p�x����s�7ܥ����.��ewI�]�p�2�ewI�.�ܥ���s�0��w��]�p�p�\�.U��7w��]�p�n��]Fp��%��|�.�ܥw��]�ˬ�$r�Xwyu�C�R�]R�%�����w)u�Qw��.����.{ܥ�.���.�]2�e�.iw��.w���]*���.ew�w�5x,����F�28�c<�b<�a<�`<�_<��K/�.�G�%OJGwy�]q�E�%w��.��K!�%շ�-���o)�-����o	�-��e�oi��N߲�[�o��-kߒ�-y|��r�[*}�ٷ�}K��}�Ysı �oL�Ir��5������_l��b��+
C��B�x �Ǐ�C��ѓ'�7&�Y���#>6�0�p�uUE��Z�d���1I����ѩ�Q#�&GM�l��!��D�D�E4(hbЮD�RK�v�Ljt
ո��Q�IRM�������}��S�!#l@אN^�@h��o1���	\�)�m�%�r��\�)�i��	�҄rYB�$�\�)�gʥ�rY�\�)�cʥ�r�\�)�_����K��R.��� �%�r	@�\R.���$��\z�ˮry�\)�\�r�\j��"�2�\)�X��\)�BʥU�R.��%U�R.���r)U.�ʥ�r	U.��e�ri+�N岩\�r�T.k�V.y���r��3���oC���;�o~����?�����{���淚�i~��ۄ�%�&�7��g~��]�7��b~������#����o.��~o���7�����7�����7�7�}巕����7�/�m��
~W�M��	~K����V�w��}�o~�;�o(�	�=��'����w���f���K~+���7��_��~w�>���o��[���Vi�N`���K=�%��vY���.���Cw)v�|�R���s����Q�##R"��Q�������Q��h�4y���k-</E	���������g��w�v�lu�X:5� :b܄�T�GD%��|�,vu>v�;�1�`x�C�V��4{�<�l!y[�;Vz�
��Re͝�j�H�qQA��l�qt�g�<z,B �z;ݧn��?���� ��懞�)�����������%M�CAo������xem���4��� ��x��?\A/]��!fS.7-�U,�f�#�ЬX�<x���g��%�.0w�|�̉���{(�/�` %K ꓤP@�U���?߳�3��!J�S0�`2KY߃���kHb�Ŷ+dJ��z�|�\l4�'7U��WU�U_ݵ�����2����y,��Yπ�d���zh�k7�j�����ci��\t��}�4'ڵНǲN���΍��?��>v|��>���֜Ǯ.����h/�z��N����&�4���h&F���_��~�1M��N<����nb1��bz	��%�p���b��b��bg�����������b�}���{���-6[l-[�)��Y��6���h&��X^��h�>��[~m&��bO`�����-�u-xm/�vV{
v}^�^{&��6L�x�)�����]c��b��k�ٵ�ص���^v�.�6���6�]{ˮ]ŮMŮ�eמb�βjK�jG�jC�j?�jG��N��XV�+�v�6�����v�6�����v�6�����v�6���]�ʮ�î�î�î�î�î�î��[�%v
Kl��',��,�MXbGYbCYbC-�KXb?-�IXb;mW�b��f�}���s�H?�Wɏ'��w\rot��y�YK5��/z1U�5�ʔ����K�(���6��rWLQ����L6��R��n<a��:�3e�Y
��`B<�/5����\�b5ۗ��_2����|��hy<Q�,��܂���n��c�y��_�������N>�=Ϝs9
G��P��/��{#,y�x��i��<�:���9�S;l�
��Y��W�����*\�ǟ��P�|	\��'6��N����	3a�V��X��I����sp.��>�:����x��uX�U�a�9?�a.|��p��&p��'v�Xv�M8�?`�f�Jx��8F�pa	؇}��8��:���a���.��-�6�>��h���i������E�O-�*��M賮�]}�5�|�g]e��F71�F;�ǎnOZ�]%9U�yՓ���gH�hKsG&nG[~G&�4��`��G1�T��5Hq2YaO�����Z3C��<g�Ʃ)N&��d=��7A���fN�j�G�
�n*��:;^�P�g��y��Y
�����Mlc_�r�jc������������8�Ǐ/*���� 1��/��y^i�2Wg}�ɓ�E��R9���C����:a�����9Y���P�#��y�K��q���i�X)3YKmx8�wC����ϗ^e������	k�h��Ck8=���	£nM�̀�Aa��3~�;a���+�o?U,�� �ѣ#��lH�Pd�$��o@��|��q<��ߓ�RiMޛ�i w�G���k4�5��@�	��dGb0���,lA���� �� iqm :�s̈��~lp�ȏ�����������Oc��m�*76T���LM�VS�]*�V���&�CL�ٔ}��X)���f�4�P���z:;S6KQZ
��0H��C�+���;�1ӈ�^�2^+{��ע6^2���E_A�n7�V���4Y.��Mn��Ñ�J��K����k�~{G�?��L�{�w�;Ө+��� Ҥ�!$NDDNH��yRT�DȔ�H���R�Koǯ���+tv�10�9�G1�ĵA���0U�n�V�^56��f�	鉑mF�Լ`�m'��8�!֒Vk7EY*!;�8���ɐBxT,4�m�~�(pF��p�k�)/��)-H���)�UMlF����	���'���G\��y_}��-<�ɴP�C'�F~9A�6 "��ӂ-P@nh�6( � ��Wz�� �a�L�<���T�fC[��@�qg���N��mzsE��rt;����t��')�,�?Z.�%��<}C�����Dve�N��ְn@���M,V�M��Lm��� �)����hm���j13saI������i�:!!��L�3e+�|뻪E��ll7�n��������,�g�O2}�7�y�e�ڨ�8��"""#����&i�����0��$3��I*�_|�0��LӤkG�y�LR��pͥ�V��r�\WG�mj�_#^���` k2����������ـs��
�t.�K ����5`*�|���p��uL� ��"p��D�_��,S��K����=t�#;�)�2͠Ia�I�hi�~D�Xr_��l����#"�"����ƙ�?c���@�M��[��Q �1�v���5�A�Ϋ`\-0�������L�P�DP�X�=b9��"D/���	����I�HT�� H6� ��T��Ԭ�T]&����䑓+}K5ʭYuT�[)�G\����+���z�o+K��H�����������
��E��SPkp3ɥ>��e��$D��{|j/��[��;Y����|
��4��:ǈ���O�O�;��|�`U��
(�/�` �B k�F��8��W5"��j� ��2)t�#�s<s�����װ�f�J9X st˷Bca�M��oҤY/--۸������)V`SLt��l���~�����n%/�<�A�)q\s�^�k �PC�
��J�z�f�m=mȄQ�7=k~�0Um�\Q�v[W5��(��_ZQc�/�[$Y��z�p��l7����+��/:]K��v$��=)k�%<�G�/� ���nC��#^ �E;@�O>C}��옸tw��p[@o�_pmnM��!�iQ���k��\Q���(�o��'dw5i\��jѤ��#^�/�;_��ǣ,��Pg����mv��L�uo@+*�} �(r�:W׫���CI�ߓ>g7�i�s�D:�p+yBv���;���d��L9��~'F�kʡ������*�C�{}g+9Kv_y�;qR���kQM>�[�-�/e,��(��1�7O�w2x���b�FF)���y�u�j|T�kD�TՒ ���3�F��L�I�'�o�����.���#����톃U"����@����O|?����;�/�7����z㐧�z't�Xm[ek|���;3��֒�S����ZX��k`vг��̗�>����T*�1d/q��Ia.�tIA_j m�� Ƃ/Vy~��[�'�x]�*,�b�\�w����� ��T����n$�69!d����n7��{�����kk������ǹ8�������?���9��w��� ��v����ُ��m�{�8ߒ�d���E��Hd�[1�G>�O�b��!b������v8���������'{��(=7(�|���3�Z�zde?��7���3u�^�������;̽��o�d���G���Ԙ��pח2���*�D&�W�C=(π����<A�9N@@�)��C�8�*��9x��2ײ�r���\ɕ��v���R~��� ��|)�x��d=/�Ǳ� G�D��"�4�[�Ŷ�0QY-P�t�E9��=�"_�,��J������������z��p��Ki���o)�Ǘr�c!7���y�tw�q^�@����)o&�{��{�8���x���9�K����mz}^,���T���a{^�����W�������j.��?�CT�L_0����{������v$��{�(����y%������:�t2����4M'9"�����Z�m�'X6�T�l�P0�����f�_{�e/3�WV�zt5�̋�oR�of�/O2�j�\�
�&Om�u�2���Uk1��uu�7o;Kg"6����W׶Ρh�k�Q+�O�`=5_�%4/.�KQ�JU� ����U��9'E��+U�J�JӇU����EE;�}��-���K6������]�u��������䲻��wb��L��Y1��wkV���l���g���`�h
��_ֿ?��������!�^�T�"]N���R���b0O2��}؁N��4ǐI�$q�!"���0� 3#$I��Jc���!�h���U`W�NLǼ�[m�k�5GdB[������v=�J:d"�x��g���~h����g}`���GO���e'A�)��dj��s���������"]����K�m'��@݆X��ُ��xs|0'�G���n`e�~Pn�s�Q�B��d���*0��*H�c^/?��=��w71�㑺 ""lYA��Ȋ��I�i	2�c��Ճ��Ba+6=�A���/��� �����֩��MJbOU�)�G��V�����z5��l���U]�ݡV�C-��[�ct�:;Y��A6�Ã��U_�>��0��D5v�"#�����3ʐ;��T��$�>���p �r��@Y�N�x��[l�����&rj����o�o���8����f��Z}��Y]�a��3̾5 �>���s��y�O���A�)�!�$֧���4�����d�p7� �����B���j�O�X���7�dF�n�e�U��q�*�U{��ڏ��4��']�*4͇���?/���b׹��w3,�|�h����Ɉ���33ӟG���VV\�ը�G�e", �>�9E�ylF�bj3�[�Ƅ��0�%Ţ�X����&xl۫>�\{ F�р11���U�
� ׉c�n4�v��W&1��(�/�` �B zp�I�uЈ{��-
#�g'��c9;��+�%A$R4� �b�i��1���v/������c�!�g�DDm��?	�R�tpw+��S�(�r��V3�p��|B��re�ܻ�����Z�]P7�� ��U��n����Z[!�P��{��y闽�o3ܙ�:]�֛�Q�ap�g^R�+�F5�D	i�2*�B�$>ˡ⩊���\^�J���'ջ�*/㩖���
���`�-3���<�8�*��'>�U�f�(j��*J� d�!X��H(z@�B�:tۮl�1.�
�ß�_n����H��b�׮:L�>]�d��K{���_���[�ˠ��Ԝ�nz���^��4��?�)�'Δw�w��d�x/������_�Xx���f�w
x:qTVU�L�WL�������8I{@���0���U�e�Y:2�{UN�½�Wk_8@r�����e�m@�0����p�.)�"_	�X�W�tk�K�oJ{oڜ�j���J���V���	=;���6�5?u�5�����vq��m�cY\������&NN�<%�QE<�˨��̉&�2��AE��}sW*֫6eJ�CB9��CB9��9jc��)_�Nn&�r�~�Zv5��r.ƥ+ۺDbP�����9��j�������k��їBΟ�Q�<���f%$ RFJ�r�;�D�\4��Z�:���}�o�kv�&���]-������.f�D����
rk���� @��j��c������8$��~���àp�Ӻ�WL�㊻�O��ώ6/�
~j�����j�Z������cx�:����JH5)#_|�U&Lh��,M��wCbe�aR��7S��G���3�_���Zm��j�-���r/��R�N���cR'��ꫢ�vK4���ey-�+�W.�'��|�oU�kp��{�ɖ!��r��##�n����9J�b�דKm�-ۺ��r�������q�װN?Ϗ��5��\k�8��3��!�%�Jd�������j�X���t'~>���}���7����o�Ct�I�,�W�"8��Ȱza�/Z��VC2*�J�NHF:)Ǩ���վ�8�~�����n��d�K��^��_�˞�����翛����3�)6�&��@.P�/^ �f4X-B`Ax�{U����15��f8���^@�](����W��݀à���iߧ��,���'���Cb�c���n����n���1�<�y��N]������zs�"��~�����l6&�<�2�x�ό��n2q`�쵺(Z6���W_�+��zZR� �	 B3#�ז�]A��
!Q/��Z�v}�ѩ��1�
UG}�t���#��^��R�C�]��z��~�'?��?7+!I	����3�Q�M��:ǔ���6P�f*���5G����O(�CJo$���>�Εy+���o�hL�{����x��h�f�6+N(
���+����;i2���;,ɞ��I�ˠ�5�Oթ����������)���c�-�+���Z?$�����Ek+;�h/(�nN���z�۱����|[�[�
}�=�8��C���&���T���	D$I�ᡅ!�v�$�%#&I�H�"_���-��T3�5��BU�lt�L�������p�a[}W�9v�L5xf�XC:d��c�8(,��h#����{�#`a�L��,~�Y��m0��fȦ�71�E�A��~�ml�7vY���;@X�#�F^F�����:F3@4Z
��m��vCTgӾO:��(� q�r� Sl�ӧB�3�=���̲k���� Ht]~�Y)fI���B���p��Y���a H�P ��<�T�C(b�t�bNi"�*���5��!B�!~*��I_�I!3y���IPVR����$�;?�H��i{;7i�3��vt��x	�~#��2C:_f�ĉ�Bd:�0�+.)<C5�Ӥ�
>���D�|�VD�v��!�Op��F
���v���+Y�[�1���u����q*bo;K��H�2��̉	<6��إ�E��=^H���X�ӄ�����Y<��(�!YM&4gC���G|���7���ϱ<�y�o?> T˄]F(�lĿ	r5�H(H�?Z*ѥ��,jK�y9*֐�'���*(�/�` m? �j4I�^q}��8�JNT4���o��:�@�-�3�b�:3%{���E�-�KM�����$��Z�����-�Lf^W��fPDW���	�W���(�lDLW�'/�����^,�0Q5���H��$8Ad㘥����|\SR�$���0)fY(5�k�w,�]w��Ty�n���+]k�<��ߩw{��c�)fx�sTh	�o���&[j���P����6	^,>̶!�i:#Cf����O�\7vE�mc(��<wzCe���zr@�So��ȹ&��~�˭;p��a6�Vm]k6����}W-��j��-�}��r}ֺ�0x$�p9U��H!�$]���]�ʾ~z߿�z{?�������o��v�"����0� 0!Ð�A*�bR����}�B,�hT?,�B(�0ќ�L頰3A�����e]&��u�ɳ�
;�j��s[��e�K�i.y�B��ی�1����i�i[Wy��XSYXs)�ˣ{�^�t��y��&��9��v���k�u����ޑ-��=6��xv�v��rx��AӤAy����t��rƲ����v�<Q��~��s�>����k1��Fb~��t���7З�r�_�6�;ץLSK7��vCV �/��R}�4��}O�_��^ҏ�{9k� R�ce＇������ԭ����GoEvM�e��9=�x�uI���x�l�����+W{#1����͆.���� �Sr�|2{�T	3*���Y��Yk�#9��?��m?:!���|����S�6����P��2H��P�����^�����6����O'����Խ|�V�o���.<؝�����Z�����6��{�߇�i�O����zݿ�Uv��Pk�eJB�9FW�����̭�fh��ǖD� �0\�J�7�u�݄�f.���h�}�Mv�����t�z��0����Q�+�/�"���ӊ4"-fc(]davc�w�ʲd���k���Y�Y+˺W��dꈺ�����S{�"�����5�(����o�o��˦0X�hX���lK����ά,^�ז-h�}O2Y�R��,M�=ɜ��UY[�8vY���y�{��b�)�~�E������&5��"[�ξ�t��l�m�궗Os���޷�vL�NH.�]��NE�����S�%�����Z6�Ԫ<��<ߊ|N��1��o {���Ba��k�k��y~}�|4bT�*�S�t�z�!+Fj�!�a,4'��м�2l���+][������&MJ��k%=�����~9!��I���׮�K�s����#�||߃m�����^3�o�on0Z.�~��m�����-���l6Z��e	dm(��w���܌�4Ak�:��3O ��h^���E>B?R�T���0K�h$��^q��S��dbP�c�qE5�x#���1̲�P���Hs�  K,R� r �ŝ��������e�#�츜�H��t�w���~����Hï����H�$�хD!����(��53&RP�$���Q%�������L�lڥBJ�({y
�Ey�)/K>r��*2�HSN ���W]�n�1e*��Y��,bEȎ4U�v�%C`ćN�$�F|�j>��E����Sx�;�c"�p+���_4L�[KU�b*�Y���>L�A��~�X�v���ߧ��)]�P���p�X�j�,�nf�X�;�<�2W$���	5z6*���r�(�Ka�1`��Rێ�E����n[g 6֞��ɘ�Kz���o��g���("=�*�?Y�rG�����-�C��y�)�C�1<����Ⱦ��2ZA�'-���R��gr�$�Z��U����'���n�ҵ6/�%c����mȶTe���/p�G�X�%C�D�]%C��X�D�,�*���0E����(}[dB�&���Mf�ص���e�2IgIy]�A4����#����H���K�X���X1�4�p4��(��h�"�Z�ҕ���+�����6�s��7rV�S��4'?�y&�L���Y�x�:jz��V�
(�/�` eF JyPL���X���|?�}������}���NɃ^Nk�AOs5.غ"�K��&_���^�A���*��wtqi���-e
���.'�:�_-�a86K�r�j��0�S�5����fk��z4���H`��N���l5���.ߦ~������2t��������(���i�3ir�٠�Ӿ۽W!4�hO_h�|��g$���)��&߭��9�C7���Ň��G(��$�����9^dG)�}Q��`9�kw�b7�]!D�� ��2�\- ��<"�E���жf��R�ĶLE[��@��^��.K����3��ҙ�bp43 8dp���\��u�^Mۀ�lQ-zJi��A{����P�@�,+��e398�����/
��B�gY�s���W���rU1�c��tr>��e8�H����� ��}Y`9��F����}J��h�y,�Fz]?���{e���<?�EG��?��+�%s+P�w㑱\�%�`(1�mT%�P�Y�,�2>M��s�7���"7dPfEp�7ҋ�fjaR�[����`��cܞXb:��x�YuV/lb��gS�L*��b�5��JgXac�8ܽ�/J��f)Զm�����-���7�{r��0��<_���Y���o��;�Q�z�?��-@�0������F����Ǵ�zt���"P��B�xa@�g�o<�	�lF���	e�egV��n}O����Z\2�o�+U#w��������F������Js�pJ�wy�\���^)���o}^�Q�t�������[�<x���� �r&"D1.WLpޭLù���N�I:�Y�dvr����0j,�bX|��0�Wⶎ�b
D#c��%�iM[0.
�/�P) nb�.�GF����B��]6�X��m�׫�b�5q@ЌH��f`�^i�E$He�V4����]g��rra,F���� ~���*M^r�5�ߞ�Sޮ�E���=��E��Nx�AR�%�^��%�\<��xH�K�0�u�<��ݣꈴ�V���fk������뱬<�܊&?M7k�U�����}�R4��SS�n���=��{G���2��[p�qFFg6ӑ�9Ҏ9$�9%,�b)�%�-�Z�U+�{�����֒�}+��� �q��j����j6��M���o�ὌH,�Ұ����iŪoͥ)��35y^4�z��H�a0��6�_(��)N��6Y���l�eU����'&��j^jh��7����x���O�Yh��s�F_1h�/�>����}�&7I*���B_��o�c|�zn��C(�[���s�F^�[E����~܉nY/�
�y�g�[㇯��߸)v?�L'��g]E����pb�'S��v�3q���I52�H�n5�q�R)�0vY�R�Y��t[�f_G������l-�S5R��'?ͯլ�������|�$�{����x����Al*E���W�/#N���H�4Xk�AT�f`* M����V�'A�٨�p���+F�P]G��*��n0Z�7,F���}��uM�<JQ��G�;�d�l��+xCQnP��rL!X���e�
 YW�j@���{V�.���'��ͪ����7:׬�=s�I�����o4�L���*����<)��!C���>�� �o�X&9����!@z�Ç�%.-�K��.��JT���1��˳"8���m����8��!I$I��	�d(; #9�B�#6$2JK���{1s�L��-NQ�v�~�q�&�����ױ9�,���l|? 2[�mvP��ޛ��M����a����/[:�z.���*e��)�yR\�I���}Cs5��є��'"������%4b��i@m�M$S,�p�|$��'x!
��_n"ܲ�&��DY��b����m�� ..}昍@~w�+U	����~j�"�08U�io�2w�Q7�] ������a����7=��x������2�m��o�X𬲒S�C]�MP��$�C`6M��6/�����>���h[0��.ڐ�]��u�k�1~`)>x.��
i��U�E��[Y��~�L��D#ŵ	X=�H��7���\�� �4��)�M
k�רͯ�L�6`	MԙZE��D����곾�1!���o_1�63Ce�*Eá,d���� ���Mc����B��W�;E49�����0�lw}���tTI%`�
ʥ�"n��#�D��(�Z!�R�Z+��k;��(�j������Џ���-�%������z��
��(�/�` �B �l H�U�0�����W�<9�÷��W@���@�pWV����@k`��L�׊[���4�Z����}�����[��^Z]%�(̹��<��ø���{�N����I�2h`#��/٢O�l>	zn�JR���ҶM_<ږ��Pp�kQԅ�Y�a֢'r�2kA���hln-��:�(�ʾb�@�����m|�lbϽ��?�x.O���?�A���E�/&�,F����sw���E^���^�oۂ
��`J^��"E�$��B[9���A���,�� Ǻ�oU�U��� �t@���¯�	���p��<��#pAf�WaF�J{2k#�uM՜i5�(�����?���V���+����?��v����Z2�N���*]c� ��n���u;�[j_����o"�6✽D�dI�l�NY��w��{纀��)S���<��K���ٰ� ��N��u��^A���e���㺀�.{x��$�l�!!�	�ǥ��~�~s4$3�@�{}���﫿����r	s��C��k+8Gcz��Db��W�#�>�~�G�7ݦS!��������~|˼G>6~|��GW|��M�J˶M1�Q�O�{�nۨƯ��o��$��5��TR�y��Mɬ�b����ZN�6�rU��[�8�+���q;魺.���{I����?�6z���;$�3�@lX�z��������F4#wg�@���1pљ��^���;M�ҝ�4�BU�4M��P4�kQj��SU]y|���t`��d�b�k�����zB�������m�Da�W����I��v�_�4ҿ�f�$^.o���f7�����&z%��&�XL�[�V
U�S*��=��� 7�-���i�"��b	
�ǣ�n��Ě�������8��}�$A\P�4�����*�YJ��a�JM[ӑ�S�iK�F5o7Z�5͜��2�r���ĝ���t��f9w�C$��}�蔬����iu�Nvhw�@���û�|���y(fU���CͰMѶ֖R�jm] �*x|��ƺ�V���X�X�\������;�a�&�W���ˏ����/�iZ���
�2�X�<�E�>��ό���"x�i��d�Z-�2���
�T���"����
�<�5U?����(ĸq��e���{o���w�hH�Am�n��o�B���d=-J�s����]u�w��2�<�l���}ZRԻ��*9ȤI�r�ɚ��f��J���z��i��}������զ�<mL��N���6���'6p��~�n�V�-
˲��iv�]�\�a��L�!I/{+�o��Oۛ�k���=l�����}�h��r����$�h
]��Y�c���!�=ѓ$V� Aʧ$醆 z�͍��)[�֣�I
#�ج�x
r)3���U&`�ٱnѱ�u]�$�?6zY���CB:�	?^6y�@��r�a���[�FR�*���$܁	�ZMl�ദP&ՁIE�Ll��0SuU�*��<����$I�Q�!�$���I�a������U��Ӂ�CN��"�%P�ʦ�[<+P��y�r&�j��ހYûJt�Md�R_@Q������PZg�+����ﲱ�2��%��QA$��W��+�uӲC�ult�.�N�2ʙ��]�o��
�7<Cy�WcUS�:-�+]SExeNm4�n�,�i͖�-��N�,vd]�x~V����/�S	j�t6�t��< 0TGM�$����8�il��vi<��t3!f�­�˱u麗M��C$4�8J|n�7��\�woH���u0����g �ݼ 9�OIh��tN�[#~{\}��I����z�����~c�=h�E2�Л3�C����θ����g�l�ڋ3�u�r�\ ]g|^Ua�p�@GW��h��.=������yM�@�/Ox�߂��1���ê��_��;{�L���uj&��(5��77�^�7��1��,okc[}��y�P�5"��VY?���_����d{�oM�ˢ^2�ݏ�C�s�J������	���RsY�~�>��������1]D\xI7e����b����	2�/�ꉟ5���؃t���S�yK��x.�S�u�ꭋ���pz��Ȫ�bOy��Ǘ�(�/�` m= �b�L�Vu�h�k G�<���wσ���b~fp�9�W�l��Ҩ����b�C2��k�nj?��>-���j�7	�R�DCP?ߎ����& �NA��:��ƒ�aI	iz�fQ?ϧp*�i�T�(y/;yo7�;�>�?0���f��jdT�b[o�I�i�˦�2f{���jO��̘�}y:YP5��d5�ײ���/��-��^��K�Ok��4I�	����Ġ�nPkR�5�������ط��I�n"%i�d>��79)E���O�F�d�:n�/� 3܅�x��-�f�Ĉi�D2\�It,���FFv�	:�@vnK)�X�	��ax��#4C�st�s
w;ay�`,�0��B::�9������qO��v��Su]w<��'��K��S_�՗'��}�f��^��c3�v2O�-큺x���k'�o���G�a��\�
�*_\xb!����P֕�X��K��?��cgz�,��FF���nj^��ؙH�&���D��C�6�G(s�E�$��eANr��;�<����Y�+�a�����ݝ�CR�B����ZY� z��^\��a�V���u�=�� N.��Y�L�/U�j��|=�DӴ�ej��ޟ�W�ѽ��^3�G�Qs=~<�@Z���)���E�����u��3aI?���7wn�EnrR�:r&(��8�U�Z\.N=�RfJ�bap�b�'N�T썦e_T��yr�fZ�ے2�^�p�)m����Mjp6 ��5 9�i-�j9(�S��Hu��//C����N��� b��%��m[ĺ�e��S���\��w3�RY����^��ؙ���t3I?A>r�"��4�Q��������j1�7���{<��	�B;��ZGUK��E{4 wx�+M4<�O�i``�;Bj�b��KΌ�3F���U(jc|������V̦p��)�JWW��fht<���G��'����/�����4�9��$��G�$9�7�Yj9j�Ԩs֒~d��ˏ{s��R4wY�1�$ai�'*HӪ������a�.�[��(h�譝�U��((L;&b"*y�JS��u�(0�%�+%�d���<�]�x�A*�� �ZZ.-�v�Z�X(vD�����Жk}cZX��JeQ]g��G�s�ݸx[�JS�V����� p;���Z[1����cG����x�R��'��}�_��[�[�=���f�򛻆�R�y�S��K�Oj�08)A
�&%;�*����DӹP�0������hK��PG��%{@������d����L�|���#����7�eC�AW)��w0Dlp�J[Dݥ�:!m���@�� @N�h��j,�Җ,��K�Xp�m"w�|�z$��mR��VԶZ�EIہ��H����H$"�4���1�$� #E�C���((*HR�gRk
CtV���͉��8��Vrh����X�͚]�y}���#0������#�q+�zw�U���S���q�fϋ��ws`�������/�3�,z��A|��)�q�/����Y�-#K%eٝ%:��-
�G�*��ֳO�T �S7o,��M�w����	EK���:�⤯RT�0��A�i@a$�9Ή,�m�(2n����v'���ˁһ�s!T�Ҽ��Y��
�S��(��?H���(������&^�CSn���Ռ��>nR<OYg[�7ڵ�pYQ*HT']#�)%����h�m� �*g(I�%����0	3��C�ug6�K��g�;=|\jx�e��a����\�	[�7����*H�`�8|rKʜ�7C�a+�iz��SCG���TSbe���Q����;	�i.�3�2p��HT`N��w���g=:���iȕس�Pd�2Ԭ��A��(�~ =�rl�k���a�hΝ�PԲg`����9.�]�D��5��.0O;��8��Jt���t=P[s(�/�` �B �qxG�^q�H"���>=��� � [85�C�P�peC�f�%:&<~�"���˷ݶ���o?5��L)osuZ�����q�٭���6p���RM�[P�9`����9{ܝ���-����N+z�8~�c�ȴ�ΚY�J�] O'˞O�&���֕]��؄�<�����w.j��Lo8 ��fG���G�w/N�{|���� 9�U�}6�λ���3��nT���"�z��_�V~��xmxI������/����#	�a��rE�/�vo��!8W5����������* ����j1���&T�hM�n�kr�@���2��M.�W�ӍIk�z��W)3w-(Wt�������#ҋ���/��TSF[P8)w�19^���&��J��k}_�.�RM�-(	/� ��������w�2X�8v���v��;�N3�J�][��-�g_$�Q>Q�+Qkދ�Y�z�����i��_�z,��3r���Õ&˚+X]H����tG�����	� 8B�w�\Un�h
�Ԅ45`�֮��&K�>@��;�"������~�� <�i.
�y�)�3���wJ<����$w�j��[�!����aZg��Fh|���0k���b�j�	SUM=so�'~�u��p���4��� 醈�� �~M@��7�ôJؗ���|X�o�j��5�������!��i9�M�������Z����=�u�%#���������]�k��(�uEQ�^��8��@��K�Z����vZ���`���K:�\��s�n���n�E��yl�n !Q�4�����g������#i��w��<�uK��>�����[s6�qOU=[���l����m"E� �TUH�����,���FYy�R�h����Ky/ʗ�Y͇w�*��g�����BY�q�X�!��p��y�:�����;��!��nG&���u&սٕ闋�۷������I���	�;o=�;�g����z��]�|އ��	3���b,���EgA�t
V=#�/Hgl͚Dc8[OI��*(�0��kL?`P�iM�A����1t�ڠ\ ��^�Ի�~�9��|�'���K5�%��3&}b����nema���YX�6��ʙ08m��3r��I!r���m�l�nh�y��'����sy��S?e�U��	QV6P�P�O��̤������ʹh�H��>�]8vow!{�k0F�n�����\MӠ*���|LM�$X�����Ǐc3����a�Y��O��wl��e��Pޅs���G�"w(]���N�s.<���9���U�2F�h��.0á-MoS�(�����)����-�W#4��ާ6[�G�O�6�N�l�_�8���V��[�F�s�{yw#o���7h�`����`2�!c$M\��tvbϫܸ�|�4���G��叐eڶQuan7�����WA�oi���ş�q���?��ͽC���6lU$J�T�d*3ZzC�,Am5�iEʌV���;f+ˎ�X���:d���~��ٶM�,���P�̌����$I�q�)�8��-�!#�	�$I���By
X9�LqG�o5n��T-%	�#�yqՔO�&��`��f�nf��-�^��.��8��d���\�Hu�'#t܊�υ������pX� ��>O�>��_���N�,�Y@��W��fZ���ֿ�&�?`e�X���2\��u�#�W���X0���.�Aܺ@2v�+�7�F�1[h�{"�+`���T���§T�0=Re��'�0�"�Y���1g��n�I�:*������1��X3*f	ج��0�,��x�|�N�S.WA�=�6|F@��9��Cak?y>�W+8,a,�tjv�KƍE�ײ 2���ЀxmR��	$;<��P��Ԫ����]�ڰ�W8B9Lhl�@@5��Ӑ��DS)~JD�d[�kjt��utW!�v�/dٟ�DP籫�8qh����@]cj#6�Q�S�d�@q�/����;	��&͉�8�J�[	="u�O"�Rҗ��T|'8sۤKܟVq��ě�eby�6����G2�$��J�U(�/�` K ʊPU�Q���P3�e P�� ͯ0OD ���&b4��V)�K��]�jX���3�;�u�,�9��> b"F��?�������(%;����#��5M�y���*�y�ay]z���o���\{wg.Q��N�Np\׸�sO$�y1հ��)�"�������R��x�ЈQ֦-���\��WW֋$JW�j����;�y#sY�/���z|>�J5�r�\����Xi79�4�����i����;�@�"ְ�/���Z��Ӽ��g��q�egF2�n�=~`�_�x�9�5��cv�8�%�a��,-k >���V���O]�DW�����(����P�!�¬VHU�&���Qו]Y-��j�`�I�/��=����,�e�<9��L#+�+Fr��B% ��&F{�L ����/����8�q��!��ݝ���|��9H�m8��4����5K�-p:ni7H�:��㰹i����^pnM2��1ԂR��'ˁ���UH���v�ܴ㺝#��-y�f�Ay�+R��eO��� �N�H�h��BX&�
��L!-�˳躮u�=A'Þ���^�q����7�s��}�e?��Y]�>�U4��Kt'qR��)�y�?.�_w�4�cx>�[�o�.�dU�dA��Ӽa�b%"�cEO�*��'�${vB�����U�k���r�*)�P���h�!;��J��X;��VN&�I��eE�5�B�ZuNNL��8m�]͒mɏ����&�!uj
�VZVN�T��芒h1$rG�@��U"8�o]I���T��e��~���4=^�IDu������`��C����b�?�T☗��߄����}���=��2���8cr�l�gȎ#���v�gЛ���l-�y�Y������-���C$�Q��UI��jO�>b훝CTܦ8�%ŉ��y2�K�@|�S�Y���֦-˕�`�HJ�RX(d��V(��fB�C'�+,#���;�<�P!�G�|��I{s�h�сs<<8�f(��ʹ�)�d���}<\���a��,z��`�5=�Q�]9�^T�áV�1,������s��|�@J�ϛ��2��w���ۿW��Sm�^��l�7%�\����PТ*'�"e^��ug6ZNp̐�f�8i�1sSO)��P	-�J@#�U,=�4>HF�p�Z, 5"�������/�� V�S�^�j�N���p�����~�FV�.�����p3��k�y}�U��3��k�Z
�j[
k�00hЀSF
ߠ]�B��E����QO��>����K����	������±p�s\���A�g�������e�o�=���A��G�O�'RO
�nTu�b��)��aI�$,	��Gc>��
����S�lԏ���b��]NS�ȩF�*B����X��c�KO�X���^��G�J���Ƞ�qlM^/��������
�\��Fp�p���7e]I��oa��|B<"�vχ�\��T|�U^�-�WB��p��nnz���a�޳����֦n:���b��=����Y۽����̇b����^����p��n#֪"}�T�� �17b��w$��I�O��qN6��i��'W�a�'�y�h���Q��]�x���{ZA/�C�4[7�oL�K�LS�wܬ��͉c^H�I,,�!�S\�͑����-���vkO���&A�����pc){	q=[�m��Fj�P����vr1��m���Aa.4搋�������f��6ŧu�g�_�W�����^���>���7�Nq��p�Op3�ۭ��[���H��x��p��щ���$G��i�s�'C����Gz���'Hx��-�a�Or�D�_^Y�[WKS6�ʨ�(�2DHD$�I��0B��2���-B��	FD� )(I
��A��T&ۿ0�,'��,�����i�$�t��b����r9uk���O����D�f���R���@�)/�4��.gV��xA�E���l?ҋ����G7��s#$�s��GJ0���b�4Y$�cf	muW� Zw��B,e)�a`]�Y� ��J��0&I�+��$H2���;S���L_���X�;����=l�S�Fb=�!`�ϔ<�|C:-^���=��v�5!]3�?����K�l���Ɗ�e	�m� ��H�v%�C� i�O#qE��i�x&�|^�j��&"#X
��O0�Q
H�l�[p0����L��ώ݁�3{��8��A�6�8�{لLN��2�̾������$�p����Exx��	^���=���ͼˈÔ&`|��Iwf/�g�5��57��h�����b	NW����r�y!���pA�@�+�z/�����'o����"2�({�9F��(�/�` M ڃ|UpXQ�N�(�4�� �tx�@��~�w�.&��*���Ș�I��0,Q{����)1�ŢϽ��-�׎�s@�V{�4z.���~[ٽSJ���?#�n\}�rt:�n��k����ۆ��@��@"G](����BC�4C1d���� 9�/��%%�"��L��j=ܨ���s CH�܏��BK�+��v�ڙ��Q;<�*շt���{_Z�e��^^����T���!*Ua2r���]����m���A%vq@L��qxF���q[)�+�VX:���V����rQޗw��_�m�����o���i�g���#�,b����E��w6-�<��4�]�іt�t��e��&˚�h��L�S����|����H�����T����ywa�Y�Z�E<(n��K�Eg��P�F�2��n)��%q���0�h��.ٺ(ںh���*U�����[qjH4��s�]صn� ͽW`ۦ��:(�i����|��3����	�L����O�5>(v�p4���1h�69r� �?`�4�#�˾��#�s�y��#UWW�+V�Zm�'�Vĺ~��i��~.�kk�4^䈉�=0�[�E�ϕ�M�H�3�-|�w�^��`䅡e�8M4�#���NZ�0yM	<Nͥm�6Y_���-(aS�'��mQ"9=˜c��m�C'3]����� 
�fq���C'�f�739�'�'�1购m^��7,�T,?�ϰf)�7YS����"���'��i���LE�y�"˻���N�m�ȝŖ5����n ���&���\�Y-X<Fp7��e!%N��zs�<[!�#B$SI�b��:�J��z1�{�ng3Y"��&�vw���x3#����I��E��N�7��q��耠�P@A,gf�,��|���&C%������b��������EPPW��U4Q��J��J~�&˷�Z���v���}7J{�N&�"�)�B)�� ��P9;���Y�p�$	��9� �|��SN.c��**����L�t�r�}�8KS@�ѿ�' �!����LDj��<��ڬe�� <DYDO�Q$��"��%��f��T;E���Ƌΰ���tE1e��d�i��>_ȅ��Q�L��{��R�U@�"�/��/�-yh9�0��Rt�E]������m~�3�Wddx��@� f6*�H+u7��
.��~$q�U�R��L.6���;U��dJY���#�L����>��\��ݷR�ʍ�� m{8���[��P�mm���eh���5��T�$_)$<G�L�c8�Ӣ�ۛ�������̀���˔)s����U��|����^ڛ]e�M���e�n��6�)�De�3@�=)�N�]��S�*�(Gu)rO�T���)�^���n���y+bH����_O`\2M��%O.~(R� ���9�ɲe�fcm;�wPF'h\���Oڻf���'Ծ�%��� �[WŲ��?�8v� p����:::�X���uwQ$)����G
H�xNE���h9�k;��b�v�I~��8z�ܵ�ݮy>(��_r��?�p'e]�T���ғq�������[4W�㹴.*��n�"TU����m�_�Yİ%�pA��*0����8�vdl�ז�}-�(��i�Fq��sx��v���*徣)�LM�s��	;{���&�Ntms��fk��V N���
�w��$��!x3S���������{1K�	'����8�V������DR�>�"I%�������"��h�*E��%J('T.y �#�*Lly���0�$23""""I�t��D)����F$)H
��>�.|��hc��%��7�7������kߘ�r��pk!�ͯ�٦6)���.Я��#*��C;K;��N(��C�!y�9�g�?n�]J����n �_Y�L�s�5���J`�
Ry)j1qT^�T6t�>YF+3(-��Ǘn^C��<�r=� m�d�=�URT��E)]��j�YPn�Թ�2��E����#�y®�I����y�a �F@���x9f�څ� �E�K�Z�"� �x~.V>4��u3s��h�����
��B30k��>0H�u���ȫ�N!���R?j8�G��I���	��%�a���v��t���1�40+vr�[W��k�k/ TERw���a��Z�-�R[F��	<�Yu	֊�,��H6sq�t�BȱMI�#X3��ڑNި.��'����	�������
�$~�+��L���N�h<��t�V�)d�j\t�%��5"�m����C0���v�%o7�W�����ā��3b�;;�}Z�W��\��+��E"=���s�6f�h��*i��#=���>��RN�m�4`��qk�y�3|H�0�P}�T�P�{�#IH,g��c����c{�I�*(�/�` �: *h`L��L5&�z4��äb��	�L��q���J�D��]�>J~K�*ۍ�1�X[zZ��(�v�mm����m)��)PT_='�gٹ7+mol��j���X�QG��]D�@���� "��H�1�d�<]���{���M���q���ۑo�iy]��$~��+6@#P���T�|T�"̡��*5���?P&���8xQ|�jj��f h�2����Zj�yb�����I����N*�+Ƃ�iz2�����1񛏽��|�@8�ݏ��R��;X�S�#�r��'��J�R���A���N!^����w0�\.��f���[׽�}�@`�6`�:ڳ��>K+u���x����3�����ؑ��Dޠ��F����������L�(S@��BIB���΍2�јA��P,jP_e��vc�����:������ɝ:���������g��� U^o�@� v/����k��d��D&*V��5�VT��J�l$Ö���h7���~�fc�Թ� ��{14RI�z�lOJ��>k��]���X��Ok��{{O>��w���MG����&������������B�PԵa�e�(�xT:r�B�^��-�`H��B���ds�z�X<Z��Jo��A���Մ�s�37�	e�����<��糿F�l>s�-WǮ�yyoN�%���@ڪ�J��O�������J	��P��J�V��,�|�~��C��7���"s����DX��uES3
�щ��H#��*�غ�Ǟ#Ӊ��d=�3h��c�Ϯ_�ҍࠥOGTwE���S��C�_K������oC�ZR��Z��k��%�*�5�ፔ��`x<�-yҖ�RVVR^$n�IL椇�roLLn\W
�D&F��2�m[�*+��ܬ��6(ļ
��v4��3�?���m7M�M��O�c�E.�ō��a��yv_a�PՖ�R�7l2�^����B�'�V�_���kk��#3�ԷȄ�9��eo�S�],�,i|, �Ƅ5�1����ld��)��);�����I��#!ٳ�$���(>�␇�̂�v1o�d�Vj*�!��p�A��$�n8|��Xgk�? &	
3�8'�T�
J%���|!+00+,//,.Xi�K�ϖG˄��M-/��̎//���+%3/�dI��"�B˜Q�BKU��u,Uޝ�G��ww��1��y�%͗�}��ɒ��͋R��z���{�c�6�{���Z�Vv���-���g�s�N�0�~��o�|ίm�~b���M;Ʊ>�����aZ���ic��ޓ�P��[�_��u�����?d���k�ݑ){�����Ri�?��8�7_�`w��'?���{E�(�58h�:v�$8#�
�f�DB����D��pd��R0RI{�tH"��gF�3y���c^����4�2$"#��$I�"��`�1JD!�����H��Q�$�QH���f':��̨�/r����w��,�g>�����蠝v�=H�s����Ĉv�سe���a���?��w2B��C��8�NCܕ:`��i�k�I@ ]l�ql�82Ύ6]1��������P
pi��}2���'������Ë?ǮXw9З!|���ۗ^n��&ړ#Q�Jɧ'�Do�+'��aٷ�?�'cx#�\1���Fv��`��e{��۵i���O]��S(6;ј��ׁ��c��J���5B��{�ۥЏC������L�e[�Wj�K{���H�nz�WJ��	���?`r#rP&���/@G5Ś�g�I	�k*�E� 
�6}+�RO�FC���9rSY057�W�u>�U�i�e	���M6�k�!�9�4(�/�` �F ꀌV�Q�p_���c�0��8��������<�)(�:6�&�!H��Ϙ�`����s�*���T���������l m�`����{o�����T�-ӵ��t�}gjw��A+}�im�D���h��7:�AJT"#-Dd%�$��Oi�B�0�+��vgP'dQ�T�R����iy@,�T��J�~��T#r��3�#��qnW��v�I�H�){�j$�4�AN(�P*�WL6b{˜�94��3�������=�ڕ�����^�^��%�S�(��.M��_��Wbqr(���D�h3�K�����8��H���B"��֪�#..#d�)1XC��_�Y��+!=�'G���Z����y���m�w�>��>ѿ)�a��uc�1̵�N�0ÜC���� 0�@��PCJL�%���x%�`��v%:󕫑���~±t�x�x�o�w����֠M_���^Wڜ����;h��}�Ӌyy	����I�|6�[�3M\.�2��)k���%

��.J�`"I%�D��|Z�	���j 1ٛTq�ܾ1ͭm�Lsl.����K��ĉ⵷>�F��������0�9�3�~B茢X�"a�+H*�#ϴc����W4��hJ��v���4?^�F+["4'1<'Ҋ�(�	C��i 
��̔	�]��s�v�=��`"P��D�j�&�_2�Z���y4�BZ!���j��A�c����\�os�mj����^�.{���m����3-8)��a(�:=����juP�D�-D���*I����l{A�Ts"-r�By$��V��@[^|A�{��m�j�k��s���5�^����7��1��!�B�!QF��� �vq@4��"�����Je�I��ә �Y�8�R�Fi_Z�cn[�9��Eoj{���br�daG�@�Е�e��)C0K�nױ�q�G4z���}�������˄��U=&��TA������F��Ώ��e8���*�%QS����)��~Ae��@'�A�@p �s�pD�I�2z\R�#�#�-�`�`��٩��9��眙��F��9S�&�#7T�|��McH�:	`����}ZA8z�߁�� ~��ԥղ�o]�(X\���:���g)'z��I��5H�I�����m�i@�Z�t���)��P�g�5}듒�ѷ�P��@]��a����]��B������}Mwc�-Ы���??�`�@�[���V��3��X9� �LL��S�@�����8�'o���`[[�o� 8U�N�R�L��z��2�V���%�ͧ"�,1�Sv�Ac�M��S�����b*0�J,l�Fі�m���3W�����3�S����	/�s�䙘� )s�-��L�2B�3���Ӱ������ף�$~ˡQ~!9L����$/f�xO�,��V#�܉�hzaL�&<��7h�IA/�^��$�{ �v�X�P���f�Fަ�gm�6Hc�}LI�i��}�ӓ8�������}��=BQSt�Z�GyڠW�E1��E��0�4��O~�T���7(��&pi6�8oO�sJs��w����1�ѣ�d�Ț�4�%�T�'Q�ъ$Y��"��q�2����`'�Sb�4"L]t�/����3��qV׭����Ĝ��.����zGN��޺�Vx�@Z����֫�j=M��f@+m|;KN�����c��`Vn�$�-f_����0Ő222""�)L�����z��9F�bH�Ȅ�Pk�7c�>������A��� �X��9@�J���j7�TX|V��,X8+�ϸ�pؘ�qq�F����8Q.�즰�P=����s+s��J+t�Ti���H1���ӛA~RH����W@�[X�Qo���`ӇUqde�D�4}3��cE��I���Gּ�q4H�/PE>�������uץI��~�)BJ�Ϥ��׍u�5�]S�ѳ(��n`���
��$��9G�.��ax.ΏH�qD�!����c�z�.\g;l��s&��KÜ(1�&�d:��`�,/5:�"��aj�Cio �!�.����H�Y��;	���1Hԣ;�@e�S�21*�+`c�)h��{l��`Xjw���6�Ib!�ƾO0	�Ww(f��7��LDYZ$��������A�Mg�ۘ'�u��_i�JC�6i�-�%�Kч�k�':�-�zitƿ�H��/���g@�8�s;�Ȳ�?@R{A��#�xUt�ŪW�@�0��P������4������Bɏ�Q�s��W(�/�` �: �_I�Xm�����=�$':��,�.���+�a�P�I�W�H�:Nm��n�_��Ne�H��̮�����-b�L)))5�,�I�o�H�1������I)�4@�,��U��1MG�yq����^|�^����g���z�?���<UU+�fs�C@���H�`Ah�h��婃���?8z��������ԙ?x�L����.4QW���\r ��gZ����D�e�1f�J�AY�����)ܕ'����@л~[3=2��R������c���y�^S:h��czؙ�����!�����ؽ8g�c�/|��m=��E���c��>G͙G��n0��9����`1��?�l6Z�:o�g+x���i��9�����۳8]qv3�vgdĊ�:�����+���p��ж�Cjk��v���n��U��	'�ۯ�!ѷ��<D΂ސ���)B��0Of�Q݋c0Z�f��j�y�Cg�	��P��$%I�@�K��T)��AP,�NԌ���쥲�ա�궟s����K�r�T�z=U�KMZk���&_+���k����H��F��=v��'��[��ʔ�}���<R�?�P��g�ҡ$Ϯf��`/S�K�p�Y{��-]���uf���|!��set���7�=��/l7������-�L���a���N{�pG�7P����W큤�\���WM����*����<�+.��(���#"�X��#��A�h�%�~���$���X:�E��\N5M��J�CLU5A�\l��.�Hl ��XV(-]P�$��cf��[/j��	{�h��*�"�c:�d�By�bq����j�B�0W3�����~�ᅣi��<�S��۔YaO5S����1b2Y�������M��?���g��l&/�`f�m$�݇��m�I #�<D���#�5�P�p�|�x�v��3*�f���dL%;�3�R��,�Z���ᘦi��>���sF�4�����>0��o��b\XEeph�|�eP4���'O2�w����<��P�v4�A� >u�Ϯ�Gn�����M�h7�ܶ�8�7���( fdȃX�����@��񝥪�@��ۍ9��,A<B��!O=�TH�:�_�_6�oC��;���o��M���j��L5K�4�)Չ3�Ў�nS�vo�����MH�p�
B�Zm*�s�m�}6�^r'S����K����_r"����W��(�֪� �pf:��M68Y�?�K�@��Wk�X+M �vV�;7�ho{-��f]+�r?��(pU�ML����05�
v0�,����4i�2#"2"�� IᄈI��55�!ǈH $B2R���J
����+gk��FTԗ5�M\b�El���� ރ�����ŁȩL' d^��Vǹ��n���y��a]�J�F%�>	Rg���)m��B��������8�Veh9M��ۧ�I��'y��h�X���
-��E,/Nn���(�'!��Ce�v�qYHF-��"?���Gb�勣x�s�S��
�I���x,�(���������������,��(�S���J�=?�W��o�Loߔ#�oL��-h�"w��↫e䆘%�SGa7�� ���d�4�H���$NPJ\!F.��iԍPF��d��	�Ǜ��5j�̍�}יP&��>pF�0q駍�ˮO�Y),2�s�wp��"�����q4�����A�_���8&�霃d�La�þ�S<a8��B���"�2�tAd��f��A�L�������v)E
�l���t�Q��~d|���2��`���=TI��2x��t�O�a�@�\�l^��S��A�2�q9+2t�
?V����}���fCV�J;�U���&ym�8"�XR�(�/�` �V ��#V�V�0�����!����� @�)q8�R8��z!��%8w��?m���A,A�)���o�8{mA���^ZZ�~wwo�[J�R.&z�bWZ\h�7��n�����}l{{��? ����"oocr�z���8�e��)�������>�	�"^�Q�_���.��'×$�V�$��|�p�'0�̫�Tzk� M�t�k!"*Rc��R��3$��C,��������|^_x��b�2��$���!2d�Q��%�'UE_��޶Z�da0���'UMSUf��-���T�=�K%��JPZ�����޾۞�>�{}ws�
|�@<�=�Eg�������gz���ڻ����v��i���\"G6�<�J�j�庖���4�k�-\�S?<>����3Dcuk�C��:鹛z�o�?M�W~� ���L4Hi�H^�j�IEH�&M��C�b؂f����S)_���zH1M�.���H��>S��x'�j��{��V��`gL�ވ���/�$�	��w�&(j��|K�Zo��T��j������SA|���/ބ`��ߝ����7U�a�}���[���O�O��D|���B�g��X�
�FKD|�za���o���=��C�<�y |7�^t��[���e���?�o>i9>[�o�J�/��*X�%r4s�<��i�ToJJn�RI�ñ��b=�(Z~�f�±,��B��)o�uMo�ԴC�-Fkk5�M���Ѵf;�N'U6cm��
�6o㥹�LPbd23?7?7�����~�1���s� Ѿz����k��j��z���}Օ� ��6Ntk\���Hÿr� a��/�&	�g��
sH���JS��[@�q��8������	V�3<�Z:�b(
.)CjVa[N!�T�jwpQ�A�K�{]�3��9$��C�0@����%�'};O���z�-fU�)v5�ciy������r����u����/v �������2z��1f��;�y�1��-�����nA���/�������ܑ�TI)M���`��I%����,�'н6?fA���-���h�/�0i�	���A��IS2�T�1Q4���*U�D��5�H�vd�P�iTAES�r�`�Mo�ri]��T�h�7��`6�i�g|$���y��y�u�����[�N��o]����8����d\��xc5��S%����y5����TJ�4��O-����,Nk�Ŭ��VJ��Z�3��ꇮժY��zb�� �C+�i�& ��w�P�n��
[���`l���Y����)��+����V�Qq������'�|������������e���~�6��pn��#�,o H�F�Ć���+u�R�O�$��RhJ"��TV� ��"<�ɲ$�ܸ��ѱX��-�y�^H�IzI���	EI>Z3ښp�jZ�B�*�����պmK�K��:��\m��]|�#�DO�UI�Ů��м��*tjnZ���Ԩ`oB?�������{���$�LΎ#�'�Nt�������mU��[���f�X��P�y�u��]����m�f�� �),"F2�aj�$�[��Lji9-���/��U%�̤yspz&hsc�@��̨�<y&U֩`o���̤Ը��.H���eE�$�LK�Ec��c��Y���ᩖ"L�MIھV���-�h�KR�������y�FRi���RZP���.-��m��;��L�v8��������ŋ�]��7���r�G�t��*GjI�7�H�����$�J.��o��5� ]y�'G�a��e��¨}��R4B,MT�a߄���5y�h���8!��hz(��j���Y�������%F��������7xo��M�[w��N������N1��J��Z�rER�n�'0k�P&��U*�F�88�h
�y��M¨L���LW���D3R	ET%ẁ52��� %Ik��L
���~��>"�=��+��,�8o=����x��`R'Fl�z���W�T��~	#V�D���Ly��.�CS�ӣ�T��UF�(a�P&�c�Ѳ��*Eի\�d�d��Kf�z�����W,�Mȶ����9ˋ;��'F��;�}����C���سc��\�������q��p�\'�v':6"aк����y&;6}�B��Z�#�8� �Ť�+X���Ğ\<2 *����0;��u-G�%�m;iߺ��dy�P'-W�
��?�&e��T9��aOc��ը�(��!���"2##N0b��P%C͌$))��! �	�840*f\zO�|RY�N�Ep�	��ix^~�
��|Й�T?�(���{��3����;��� Mǧ�]�A�����΂���b�ZbF�������hV��9Ctr����/����-�9x/-/B�`r�j�dL��Z��ς�|���$�C&��V�[Q;}~�gu'Ԉra�'��΃�'��(� %���X�1C�D�Wp��1���q�&������yD�2�Y+� ��A�덋�L�(���j!�O����kLM��A�2�o�[�.�[���+��e�ӱU�?AN�����g�+U��E��r��魬��nO��p2O���u�)�Ц��Dh%�E�#\���$rB��]JL�h��th�'�v�)��u���P�l�?�g|r�A^[�,�D����b#���D����G��F�7-Y@,:4�X(Vͺ	�eF�O8a��
[�
��T�0����Uݯ�1�~�(�/�` �S ��!SpX��F`��Krt[�͌ɟ�-���6�duu��Ɇ��,�`��hUYA��x�>��q�� 7���U����bd��d�K�L)�.��^���ԅ���ZW��zɰ8�yߺP˝�ڔ���̈��gjd789v����
��C��ǽg䵿V����T@MӦu飃�s�Å��w\��0Z�$�s�Bm!�L���<�'c�*�j�B9�b��d4�F ��;A��th�9�����tRk$�q���c��D�CSݝ'��Ԥ��	ƹ���b��Xڦ5#�w�߼2e�]��[4t��������:��2@��m��v��e��&�Q���N�Fq�N�o���GL�jb�W�#����@�7�#r�2�|��Rb��K4ғc�|z^���KS���aq,&���yg����l�?�0��c�_���w$���Gk�[�kOS��5�nÃ�V|���߽������#Q�$�q\�U{�K�Wh1W&j��؎m�*}����FS&��	e�L�,S.6��b)�Y�1*y]O��2eZ�!�=�#Q�4���D�Mcsd+J��^�Q��e��&�p��LӲ'&�1X����1���dVʂa����twh硩zQQ�,./12��F�����F�� �"N�t�z�G��נ��G�޸�T4��q�ϸm����j�i���2�)l�%��Ofi�J䏜4�}���I�Pe*�'���(ȶ�����N���1\d�U .D��&������C�f� �LG� ��'��ε$U:)�e:6�L˦�S=_^�_YUr\O'�SUO$=6��{�R)���me>G6mks��f�=Bס�BӮ����buu�o��y�륢���w���Ų�z��DS�B�W�Ͻ�T,��"cF�+��QcsA�7x|�t1�HG�o�7rdf"""" .�8�;�4�����CG
E�CB3�(F�nD��Fn�����O�ʝyH�dCO˝����u8��xޓF����,�ms#Z�k��Ԣ#y��m���CB�=T���,W݉~a�"��7�������f7�'��ms��0�	҄[f(��|���������
�Sl�8�"�0��Wf�n����)j�\��7V+���PMV� C	5��z`X�e1�׵\�r��CSM��~QA�q�KuMI��2 ��c46����	��Ϛ�����fn��8_4
�����n�K^XrϏ�=�c��!�����k�B�Xw���e���%>���[.�&^^�-f�m7˯ؖ	$F$�)�.`�D	�w˄IKu�;�t]X�����\�������Q�}��ܮ�Ů\�eF�?۶3��m~p�9�h��0s�m��ڏ<�=מ�@w���{���_��(�_-JҐkw����C���_V���#?0L-*��ÐhȂ�T
�o���F}��%3� B<'�������c���}a�U�7V\�w�a���ύ>w������ۼ�]�i�Ɲhz���w�k�ac{f��3�c�	=B)w ��ɓ�` ѝ�H�i�VX��2/��R����qf�q�D#Ѿ��3y��r�����4˚�v�y��<5hXa��|3��4Ƿ-G(Xwb��+L�YVJt�X�&�y�M����61�"*�SUO&�i�MLU5��&
�T�*OTeS4���5͏8���Zs�Y�UޣC]�[����=M��y*B7/f%���z5��}L�����)p������b�*~IR���VV��b��,/j��_z��p�wO�U^��W�Q��~`NMS�b6�)k�1��L4�tM?���>�ٮ�DO45���&��@��ϭ�� D3MMZ� ߡi����.��y6����Ԉa��Q�,�m��<��*g��6^�֡�H��w$$$/f�F�����e��
��R�Q���g��K4a��ݕz���`f/�I�X 5a�v"f2��|������ܱ���p� ��4͢�S1�T�$n�ӹ��d3A�n�sc��^��V7��^�����k]�����K��� +�B�y_H��ʶ�����Ѐ�899vz~v��>��~ 	R�EFB��c����m��w�?:����[��i���B�j�f���q!^�@��:ݢ$��o����ب�(�2����Ȉ��PQD��z��)���d�IAIA��sA$��3qHJ�=S��Cl�O:�{���]�E�:��q�^�7=�G��#���<pea��eF��\v�%׆����%�l��?Dʰ���b�N%|�W*�e|;���ގMiL�WT1��3��S�fE\@�8�s���7�	&�ؤi��4�t-3vjE�mC+�v% L�f�)��<�#�t8T���E.�[!XA�8�O�=56#4Ďn��*�h�8Ҹ�%�\����֗�` ���Oo�Z�fTelg�W)�>�	��ZƱ�f�,�D�g�D..��46g�*,��J�m�,L�_����N�]z��{��-�x���J�7�U��3ܽ��|c��l7d�M�)
l#��Ez6��@G�ז0�
+ λ樖��H
����2MX�F�\K������Q��Z�KI���j�����8 j�	cl-�\<-�و֎N��j~7֎���������;�˨�_9��=(�/�` �R *�� V����	 ��M�e�!�X^� 6�� M�O^�5�R����� ]�|ʃ�\g�[��Y���`���^�Q�f��F��e
���/��B1?���?�-�w���k��-� cTc��ou[^+����)��h�t=�V��t�p�g)T sY��3[\�����ޠԖ�c�3�k�ߩ��ǎ�7����纪1��/�3�_�@8�/�	O���$>d���!�;���#���w+�+�\����@�4M�	�u�E��}��^���O�SG��O�km�G�������n����=v|Gpdp�[P{����f
]��9�Tth�a���sD�����ڜN��<l��?n_%e�yѡ�!u��x=8��r���[*U��T�@wn��}���J"SH$]��Z�C�әs�����۸{����������i�w�t�kuHչ�ۛ �-P,K�r��Pwp��̮s��L�V��P�ǡ�$I%�w���ڝww�u����`i��ʎ����[�y�E��b�$JѢi�=(&�ܲr���^,J�6Ԣs�[��]u�}��Q��S��BP� ���²�lmF����d��c���(�}�������t]�m���GO�L�'0L>!��2Sf4BV�|!���Y��qA���V��#�ćƸ��l�s@�_�j*u_q��m�v��+�8��.A��$~��V^��|�%��@�h����1aA���X%��"h�<4U#��b�;�;�V�����0�+x�6��?P8��YR�U�uS���`djb�[���-����m�}��}���y~�w螧�������@_��N����iζ�~s?^� u=��qݪ!)�q�C4U�`�ɡ���b����	*�Y1gQ���P�dY��e6{�\(���Z��?!P$�	��R1q��MV9���tpם�{{�?����}cҙ�\u դ�4�=4�ͭ+���v�"��%������ X��e	��`Π��c��2Q��Y*�"��,���T��y}�y�n�)z^	�j��<o���U{��(�NK�:����js���-�9��z4[�H�G)lo�l����HTֶ(�\�e�<�2+$mh,Ke���d(�� 0�)���`/���q�} �H�N<��m���oW�-�9����!H���d����N�%�
yh!�Ң!@3�1�d,��V���������d\EZ3�UJZH���f��"�
Z�%�Ý��L���pc�8װ�c�����R�)*9��߱ם�����6w���Ej��Xζ��8l�\^��(G���Qβ��L�eR\0*�+E&�2*8��U��& �* ،�,e4VbL4�<i1����RrjJ�DCˡ1�RM�F�8�܀�]S�,��z��h-����h�X��׋��Y֔��s�K�y����4���6{��h�h�fj�/��ٝ_���������u��;Z�d�HqN㳻~Ds`g�q{PP�68�נ<�[Ĉ$GE܏��k\�b1���O�[y�L�H�㩗��Ύ`v�ʦ�[\j������W[�E�bg=��C$ҙ�A�y9�H牴&K�lF�e�cǞ$�Y��ޤ�f�q�w�ZTz��N��q���Gvos;���(�=v��ษ�6�kM@i��VT}%)�����xR����ZW�14�ε��t�����dr>0����� %1d�
��$~�ؒ�܂;{�V�v��±t�Vo����{�=����M���[S�]��[�ʸ�H*��N�h��V�P���Id~�F��G�׏ZIn��4"��Uq��N@PLڎ,3i���^f�ыB2���o����_I_=5Ge!���o�lqCM������t�FM��i$��J��(*�^,S�*��K'�]-�:�*D!I�5`���آT�JT��Ok��qS�p�	�$U�����r�$3_R��@e�o��ȍ�"M�y�H*	��y�I
e,��>fl�ذ!�f�G�"�f(�N�����Y���� 8�,�&	%��Y*&�bR����H?4��q�p���`T$PSdiij4�]X.4]s.�騡$�1� ##"#"Q�@����uP93E#2��(�a,���7������oG�^���{��uP`���{��T,����b���^28�،F��SjB�IX�8Q����>1���S�^�K�9��~�&A���f*�PѼ �"�ʰ"�lR(���TV�lsLl�TAB��D`���t��#"��h����:�^	z���X�B���'l&,(�2��P� 㦂s��Q�׭{5j{)(#�3$�DC}䓦�'�ׇℯH���>@e�	�>�y�|}qL�QH��
́����y��)Y��u4r� �El�dӀ�q����I( @_�	�i��"%{y �	`��A���UjW#�5(ae��W焣�rr�6I7IGQ��Y�f�9�E��G�i-��Ғ Mʋ`�����͕Ҁ�e%0�5�!Ix#-�Ɗܭ�m)�\s�d�ҿe��}����)�sz��"U��Q��w
����w��&*��l����� �t�-��鬉��F��&_m�)(�`O�Q3!�c��qA�k���G3��SX0�(�/�` Q ꗬ V���(C?ڭ��9��7�L�Mg"�t�Ƴ�3�v.n��O�2u\n:�W}'݁�im$\�-�  P�"���=��l/Y�[ʔ�����_����rK���g(�>F�O���y@�a�� @�2�DoO
ҳY�C��n;.Zr�O�?���YN�i<��X�	K%C��h	A(��k�<���b��l�"V����\.��Y��e��pBx�Mm,"",�V_��fz�/��q�B�$���y��g��"�uR�v�]I���c� �W��*y�z$��˶��)q�r~ԅ5�k?�K��ѝ�i�*���&>I���4O/���ҟ3~����1�p�Y|�.q�㐵N��I�0%t�c�ZNX0�PA��ݔ��I��̔�$6Νب�OX�������I`�ńzB��G������es"#A�H' 
�A �ݨX����l���f�V��P�.7*ί��v�A3��V���$���-79�+�b�KG2����X8�_�$����5����5y��G��:��M�N����:o����M˳���]I-x�%��קLNtI�Ѩ� �# H,��d���v4
�U�ߊ����*���5�`.S��$(��g���PB:4aM&��Ia�T�!JBY�,��}MSE�%C��%��� �rq���-I@U
��x��X�hv�p�r���P1�;{�su�C%S˕K��k���~/���B�{.I���kZ��1�`����P�M1�o��� d&nV<��x6�T�3@�3�+��4sa�-���T, �}�$��˪�����RCd5��X^����a1���Fp�z��Bx�T%�Kp�MpebC�஁:	&��_O
ʺ��Lp�д�̈́��m���np |!B2,���q�[���h��Y���t��
g5�N5�c�D�WD
A�Fj�]O�%(��b���e\ĿaM�����I∢.|���pӿc�����z���7�S��|��G#���('���"$�_
>�c|G��*��\(�<�K'O(�J�WYV~����<�&kl{��U�u�h�[���Tz�����;��9����k8�sg�,���[���574�s�]�S�P�NR�K���mZnYn��`f�g#��f�ȝ3!�Q��\m�V�TʵX��\K��C3&�2����L,&c��ٸ��\��\Z,( �+���~�h���^�t���~��w�~�Čİ`2\��KYq��/k�������<֔�.������	L�.�r{�O�����+�x���u�u74�nb�X#�ǴB�Xfɷ�	��� �B*�S�V�I/x$)�T�{�FL��Hœ�f9�h�#i��HBJD��J2�U��(2EJ���t)@�B;�
�e���B������}g��m|�l3�J��}�s�T�k���Bִv�&I���g� ?��u�H>9z��פ+��υ��y���5Z��"%��J��~' �,�ba�%�Wr���X�W�u�8��b�V�����x�74�0�����`�#�8�=�Q���ed����]��~40%;\f��/�9�f���KŶUg�$t�~��+Q�l:�?����Z{�g�q�=k�d��I�>�	7�����Pd=�nI���U�X#�����(@��B,�f����0;�vY8�Է���� ��<u#�	������_v\K�ׯ3�I�G�wȧ��~|�%>ǃ�{2�)A\�D�����]���+���,��3��}���l��i�p�y�G�����,�k)_�����x6�U�T��J�R)_*��&����G��џ_:'��{d�g�k���Qd;V��O�>QL_$Z��?m��"+� _D��Xۧ-�?5��l��'u����||pl�T��>l��40�R�jS�e���-�$���>���|`�)d�کZ���W� ؿߔ��{Υ��<�Hr��]wJ(�o�w�rr�{]��B�Ъ�b�Gu]�d��Dc*Z
������8�Fl#2\Gʴ]UuKB%-1��V�ű
��7�m4ڭ�Z1�����z@�� L�9�n���4Oy,�ͨ�<�"#""""Fu0b�����9(�JD$)(I=�s& �np����(ԾЄ��B�8r���x@��ݔ�wُ��iKFZ"ڿ���_�0�`�.0i��*AE��پEHb2�ǎ�"�>E�yb�Ҕ|?}V���%uy~����.�u �Z���#-�<͋)bL#��u\V@AA��-�To�(!7�ʈ�,��0u�B-��U�TEp�BU���6[��b cYQn�������F=j�Ԅ�j�$�S[��ZH|�!��՞��҃��qo
oI9�sdh'LRԺ�;�a�=I��bҁ�R>QL%�(7����Z��=1�v@ӄE&ЁpM�����|��T!�'cC2�9"����&�Y)F�5�~�
����,V5���X|�_��)�.3���	�#�W�'l�9��1i��O���������P�w���sNs�	dῇL�P��zX����� �I��y�_,�o�!P>�b�ʫ(�/�` 5@ s�H��8<m̻,�.���X�F���3=�N� ´��.�A �]��
Zk\s[�cG��o�{i���$&�deo�R
miZ�^�����XS�l�m4Ʉ�jp�$L���D�1�W�^o%��`��>����GtV>���[ȿ��wQ�~=����������� i-䷸��[{�j^(m�$�C�F�C[;KDt�E�-��F�ƛ!K ��J�����@e�6)�)�9���`�ѥv�.)��f7�ݮ��.�k����4�8l�P�à�]��5���}�ۿ����w]���;����!�C1]�
�t�]]�O8�"��;U�;ʔj\b��Lf���h��<U#�K�TrՔVx�J5����G#/.I��7�,��D6��RV�و��/�����MU������V�!F�TUq���F���؝���\nw���d2��َ�nws��,���1|����D��Q��$�(˚nv8������Ng�l*����`����^H�$)�\����<�����6�9>�Ｎ�]i�BSY$G$X��`��[+u��QS5�%�8D��S]mqd��L@��o��y�ͼ�=S'U��pD�y�r�Rt�B����ʍn;s#���/`���}�ڽ{���w��/������zm,O�6O�����$����Xvx �� �!	p�0`��PQa�Ŕ!�S3 '��-d�~�ࡑ�v�@�g�Øl����j
��5�)O��˒y�V��m�A}o�n����﯅@��{M�
~ϚY���N����_�l}�x��(z�P��7�(�����H���,o裗��3���~N��9&�%"�$:s>w����<����<�9��H8d٘�i�rT�����פ���N��w�k��7������!I&�d�p�\��C��i�Up�����G��L���Ӌ�(�M=�u���D�>A�1��=�癸\i�r�,�a�q��`��+�<�I�O{��A�~kr�v�!��8�����55�������j�a���ô�PUӴ�&Mc+�dc��'���:DQ���ri�Y���J�F�I������a;f��������t6�Uuٰ߶4"N�A5�&o_��nw�Zȿin5�>���lt���+���(PC�S��R���Pm������i��<Q�/��K$���Q��r�%�4X$O���j�n��5K v�ѕLTm��~;��덣o��;~ۯ���H�SvZ��Og*���w(�'S��������,�#�2ɼ{�)�ƞlL���j�PZ���˘�F�
h0�կ�&�z=���W�z�x8���1��\�m�gtDF������]�<�P.[:��H���eCG$�ϏO%��J�R�9������R��rT�q��5�9��8"�Nkj�z�B�7������u���m��hY�[-m�P�mY"ű��
0��g���ө�V�y"ELc㽎y��GZ-[�Ҽ�΍H]q90I�y~舘�T7�罁��3��T"�a����n��J�}L:=�o�B��9����0�BFF&�$IsP!2Df Z)C"22�$*)J�Bƍ���r�N�a���S��dC�CKx!�J��`ûK㠷�Y�`�^��R�^G���$	��zx�TQ?�>�ҊH��`+W���½�����
i�Y"0��GU�\�:��q�.)�2�v��)��ꡗ�{!����a!DE!�a�*�Ġ8���}x�9�R sH��/Ӏ���0��>ط�am���=���?��)�'#PF$�y��Ų�%��U0?7:���~j���^�qs�є��s>kfds��v�q���e�����~�h�hr\�r�e��+��5$$�~���/6��]{��&�>���!�nm�0R��#X9U��F0�4�w^����7Qd�Fb�9��`j�?�rꞢ�u��bY:5��;kI"����-no+��G" �V�g�u��XE��]�J�O� �A�i�١G����R�YKE���mNԋ�H�l���U��aX��O�5v�#�X��o�})�����=T*c�.��sy�]�$(�/�` �B zu�G�7��X�����z��×18� �pCSP�;�}��D�H�r�a0FIf����:�hii�h�h��[��jhl#
��NJdK��2��z��f3�q˥����<��7�P@��kO�Z����o�]�PK�⮧M��I�V2����u�k���w���=�M��I��_�i�c]v��n�{e�8aA��O[���1�ʈ�fC���ېr{�m�@apW�Wq=�g�I��w~�
굂k�9�/�b�)��6��z�]~ �[��Mk���I�S@v��Z�xZ�s���*���2��N�1���dDAB2ث娣�a�t��y�7����{�0�h���ěڛ��+Tz"(vdPLG�i��JM�'��<U�Z�g4U���fDC2٫u>h�$�~��j{`i���_����w3�{��"��6�o���h�>W��4E���Bۓ�q(��>�I]a����_��n&o�Mu�3��m〈8�M�y�}�=���ѭ�g�Aw�y��1��}�7����<�%o�<�����ao����H�>2����|6�qOy�}�qc�"�}0?>{$�ǝ�m=�_�t��ѷ[���M�+x�wз[)�%3bY�\��bw^{Hb3�mp7Y{��`O4Ou�R�H8o9��ò>�w��=% 5	��w˓�k�����Z�M7$�pC ���s*U� D 	�҃
Ջs�R;��H@�`���(ԩ\�8�䉶�m�v�6�_�U˔j�h,D�������Um�KR�U������&@ ��������=s(�>��ׁ��$��L���o�/�c>|l�8@A,�+�0�˕�P��BǏ�f�i�'���V�cn���ڻot���Nw�&|��ڛEџL˳,��,
��`M*��n���ր��r-o���|�V����h���3��96qἾVpD��'3ť���<aB>�Ћ��N^/�/���r(��=���M���g���j���$4�R�j/4ѿ��� ��S����˷�Y/�T�������E1�Y,U*@N
g��uIaN�����a[��j�:b�I�S
�6���o*+�'TI�4�.mo���1T����;�Q�:�N�Z���f�(��i�F��[�o�ߡ�p,����!>��� �h)���c�Ԅs&"�;��W-��m����_����%��{��jWG\ǹ��u]�:�뺾���e�$�E�J��7}���4�J�1e��G�T��S���΀�
�d��j��@��y�磒�}����]�]�<���vu�3��7*���e��K��;�C�����������u��A�&I�'	f��{���v���^j�����[���U�h�J�<���4-ݜ^���!��̫�^r�������@I��J���~t��ҽ��F�~���_���G`$u�.sŶ�g���@�f���;_�Oy4CQ<Q�	�_w�ʌ�̞2��eI4����t=�zt^9��ݧ�V���HI�����}ۛ��s����/��{@{�np6��L�X>�'��8�����4��1Ɛ���$I���u{ �5�*��Ȍ�����c���<{�T�=���: L;�T��}0Uq	��եES�B/=4q .K�N܉�ѥ�� F>U����(�%w��,��ѭ�D���R:2S�"�u��3`�ieň��sH�9l���Q2U��� N'�2%R��((i��Qj���a4����C�.��C������.I$6��0յ�vQf
>��X{����w �g�'r�����>*�c7s�k��>{!�nn
���M���(� ���˙�2��r×X���uQLiT��^��xE�Ř�e6j~��ux���m�	)�R ��cSL$mL"�����e�ء6����D��K�@�xP��n;�1�H��Y����%x��q''�`�@B�xJ4V��&3��"�Ky;�������e��耱� ~�D��'��pFE(C�˃?���_�����<��ܰ�aF�%{W� ^���c&���U�����D�)چ&H�P�#��,���?��ݦ`s�`�UZ���0~O��8mL�_E3�bDdce,^Q��J|S���;����J�+~���Vxƿuɽ�[�(�/�` �7 
^H�q��`6�Σ���("X�uF�Fx:�����5e���Y��3�X%�}E�[��~/-�ziɖ2I)eJ��`k�Z���d�O�{%��[bH�R���+�pl��j���5F��QҴ{�1�8�@���v��v���}z�7 �s�)����r����h�bK~��b+ ��Y��mi���/���i�r�����b*�<={��)�lm�9��������y���<�}���f�Y�Z���~1}v:!:��5��C���c�k"5~%ˊ��A���E"�?h���EE�q����d#���\n��!2��u��ť��$
�b�{�	�2O{��{o�����o���a��:a���`V<.�5ԩ��˾ч��B��!���ld$Ri#{�\��F�!mYt��n��O T�W�H��Ia��OK�mmkW�.&JB��կj�c�@�����;e����gZ�Q�q��4�0�۽����u��uY��ж�ޮ:k;ݽ���A�������ʱ?�1���Rǵ��7A5!.%��^է�Z���$Cpԃ�$�F!��
Uyڤ��d���>�IB#�Z�䧾���v�yΨ]�4Q����ݵK��?j�ւ�w�#��_��>!C��?jE�G!p�&������ޢR�'����g�ʸsc��(	�c�:|~�2n�Y�\(�.s�!g�hZ��($��ъ�uֻ8$�P,�_��-M��K��;nK�T��#��\Z78��i�`���U���Y�`34d�+V�<ϓ�����ֶ��_=����u<��n��}�;��e�>;���Ks����o���v�m����ye��p�'�I紪|o��ׅ"�G{�y���0�O��UR��W���b�H�̓�ǭ{������/�k;�~�w`8�Ncv�Y/��O$
���\p��8�S��R���������ޟrٽn���z�tѳ
>�:�D���Ja��9�"��1埕���U�u�v"�����r�:�3լ����nQ�~��>iw[�V������İ��7Q���8Ţ�)¤g�j�F�räS��^iu���|�q� �:\ s\�!��d�=7�b�s������^.�'�nh.Cڰ)3�Z`^#�L!�)�cPJ�Ѯ��ߓ��VRV�B���5]�u!� ���jJx;r�s+�#�d�ᆩ�"�^%���;�?~�����y)O��[����4�"C#""2�$�`���`S5�rHd!"iQIJ��`E����dՍЕpe��)���h%T�PVH�(\���̌d\��.p��N���H���.*1D��ΰq�=R_\�6����o���YS�=�HԎ}x��QN&�?6�Ld|�K��~o'4s�ygc�ٍ������9l��~�uV�M�=�&=�t����W�v|�Bʣ�s�@����:�.��^&n�K(vѪ|�Q��1�B�������( ����n�2ޤbn�$�U۹/��_�oc�e/�B~��+w�t�5�C��.$�T=mh�7<��}0uՃ�)�ZN�X����G�߇�$쥮DQqs���Rg&%����G��R�T���ɛ -qf2W�#�G��G�{FZ_��K+�i���(A�3�=��56�R9�?�vk��i<4*9m����Y�C��Mb72�4�i0�5ձ��m�\R���֑֮�S����*xN���-��?��9i����&���h�Hnx���r�Z!�*`;��"�*(�/�`g�  �;�Eo� �*	��j� � �<��	���
�s���'����9i?�<�������D�򭛈�����e
� � � %��6�L���A��Y�Ցn�,���u�����2]�7�&#��H�4��<x�v �D�?Ę�:پf�w�9�W�2�
e�����b��@yঃGA��)�yR�v�|a�~�Ͷ�D���,�o�FjfmGB[z�<m+u�N��q�-8ѭS]���嘔�Tt[LFD�V�*%�Tj��#�.W���)��k9S������<&}��W�{����S����\�{��G�R��XК�r�'Z�⬏_a����	���r��,�����۸�4��D�_c���#��X.
;�k��!�Y D�i�$"A]D$"I& �?$ڔ��)=&�+g��}W�ڧ���|��|S(v��U������D_}|*�J��<�1T�*�	�ӴK�n�%p5�p<�Z�%��7��Kr�\��-Ijl��	a��,.�mA�m%L)�|:�s��0���y�V��W��[�I�R�\��a�҃Ųͳ�\l���W0̌H���2;�Q$�͈�l��۶���A�D����c6ۼK��pX ֧��0 9@�2N���� ��ǀ�h����$�9���?��5�*p� ����G���I�UA������,������1iJ��6ӧ��m����v_��4k��}���_5`sD�g	9�؛�l�׻`,ܦ F���1
C߶iYG�ݜ�H����+��3"�P�$����QzL^�����y;}�lo*QJ�JEBN�d�� �H��@$�D)tp����<���"J	�	����h3\1�JP���q� �yv04�8������_x3� ��hk�x���7��ۂ�� \_�a�%$DIƟ�N�`]�g>Y�B�p��K��]B�c�%!.a�pa�Q@�!o��P��X���ѷ���)$�1j��~��v�I�U&=KAU:eM���c�{C��Dh)�H���M�K���"�2߼j#��:�����A���ݽl�Q���p{ZRSCC   [remap]

importer="font_data_dynamic"
type="FontFile"
uid="uid://dxqg0m43n43hk"
path="res://.godot/imported/VarelaRound-Regular.ttf-60ee2a83a51550ba9376b22ed48501c1.fontdata"
 [remap]

path="res://.godot/exported/133200997/export-0528b98252209bca725394eaaec3391b-app_item.scn"
           [remap]

path="res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
               list=Array[Dictionary]([{
"base": &"Container",
"class": &"AppItem",
"icon": "",
"language": &"GDScript",
"path": "res://app_item.gd"
}, {
"base": &"RefCounted",
"class": &"AppItemData",
"icon": "",
"language": &"GDScript",
"path": "res://classes/app_item_data.gd"
}, {
"base": &"HTTPRequest",
"class": &"AwaitableHTTPRequest",
"icon": "",
"language": &"GDScript",
"path": "res://addons/awaitable_http_request/awaitable_http_request.gd"
}, {
"base": &"RefCounted",
"class": &"HTTPResult",
"icon": "",
"language": &"GDScript",
"path": "res://classes/http_result.gd"
}, {
"base": &"RefCounted",
"class": &"HTTPResult2",
"icon": "",
"language": &"GDScript",
"path": "res://addons/awaitable_http_request/http_result.gd"
}, {
"base": &"TextureRect",
"class": &"TextureRectUrl",
"icon": "",
"language": &"GDScript",
"path": "res://classes/texture_rect_url.gd"
}])
      �PNG

   IHDR  �  �   5���   	pHYs  �  ��o�d   tEXtSoftware www.inkscape.org��<    IDATx���yte���og%����H���r/K �5�(sEgAgp�2��ыˌ�x�2���*8�!��"����LXC k �������zK7餒<��9�����I��|R�]e%   І��   @ݢ   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �� �'  ފ�����0��!""�/_����[= �
@�ѵkWY�`�:�꩘lٲE}�Q����
 x�&"��I @u���$##Cbbb���S'O��^�z��˗��
 T�� h&M�To˟�HLL�L�4��i �G(� ��;Z=�j5�9�@q����P��0G �5� ��� ٱc����[=����'			RRRb�T �Z� ���HRR�|��RXXh�t�����JRR�@��@   �p  @3@   �P   4C  �  @3@   �P   4C  �  @3@   �P   4C  �  @3@   �X= �FϞ=%%%E"""�����ɗ_~)��z* �1��(�' �x��e������o�TL����g�������z* �
 ��W�^���zW�*���K\\�dddX= ��� L�0�ޖ?�0a���  �P 4���VO�Za�  B  �  @3�@����)6l����.ݺu��� ��P 4x�7o����wu2����)� <�  �  @3@   �P   4C  �  @3@   �P   4É��\�-䡇�nݺIPP�O�������Ԧ1c�Hdd�O�URR"�����'�HAA�O�	 �(� |�w�޲f�iݺ��S�sqqq��m���2z�h9t�O�@o<���ϟ�e��-�[�����[= ��ϴjժA<U��$$$H�V����F����x�b� j�����Ɏ;�|��˗7ʱ*�رC����|\ ��OM�:U
�l�Y�f�����l����ˬY��l���B�:uj��@6QVO@�ү_?Y�f�G�D����ԩS^�q��y��od˖-�2�:t��;V����^�C�2nܸj�+,,�ѣG˞={ne� ��"�_'>>^]�pAU';;[u������UbbbԱcǪ�/���j���ϗ�hc�!�4�@s(��z�'@iġ��R�b�!�<��@�!���	B4��%��G���|�M�[	��B�q,� !D��R)��z�'@�,��R�! �O��ak	��BH,� !D�4�H�#�4�X>B��i,%��Gi`�|����K �� c�!���@�!����	B�ix%��Gi��|�b���@�!����	B�)��R�!� �O�BR_K ��Hb�!�i�[	��BQ,� !��L})��?BH#�� ����R�!�0�O�B��U%��Gi��|��Q�R�!�8�O�B<N]�@�!����	B�W��H�#�h�'@!^��J ��I,� !��R|])��b�!��H�#�h�'@!5JMK ��a,� !��8�Z)�c��� @�/k֬���(������ȑ#���L֭['�;wv�|QQ��}�ݲk�._N ,CШ���O֬Y#���n�;~�����~��n�+,,�ѣG˞={|6G �@�����p�@c�g� �����'�G�����[��@c�@ ���O��i_ �G 4Z{����D��Irr2�@��@ ���G9�@��yr$�# tB�wo� tC��}���ȑ#e�Ν��v��)Æ���
���V�Z��H^^��3��G  �O  h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
  �3w�u����Hpp��S�������]�Z=��R�ԧ4o���9bUx�UQQ��RjժU�ϧ>&88Xeff*���q��ׯ��s"��%@�zb����K:w�,�����c�Izz���j�l6������'J``��e�^�*�.]��Q���#�~��=z��f
{)))b��DD$))IBBB�����Y�/ݻw7���رceϞ=�
hx,o�����Uյk�TLL��sk��8q����۷�x@�l6�?���������c`�G��_,�!-��¤I���n3},$$DRSS-�Q�f�/���� ���lڴI�u��Y ��F���O8��o�[y�Wx
��V�\)'N�p�x``�4o�\:u�$={��&M���:t��ܹS&O�,_�u]M P�(��܀$!!��}��i֬���DEE��ɓe��VM�Qx�wdŊn�			�ѣG��?.�����К7o.K�.���Y�jU]L P�x
��?���#�HII���Q;���e���2v�XILL���,㾠� Y�h�t���� |�KEGG���s���C�$--M��Ҍ����W�j����~�z8p�lݺ��XTT�|�����Ǐ h�x
��:u��ug�����C=d|��'��-[�x����hIJJ��{�ʑ#GL��i�Fƍ';v�֭[Kaa�9rDV�^-���^�ӳgO����իW˅L����[�}��&�Ν��{�ʷ�~[�_�XPP &L�;vH�.]DDdĈ2q�DY�l��ۉ���aÆI׮]�E�RVV&.\�Ⱥu���ŋ�n���OƏ/�����7߈R��ul6�$&&JTT�|��Wr��5��۽{w�����+W:�[Ϟ=%..NV�Z%��"""$99Yz��-���r���駟d����#����;���K�N�$22R�]�&����g�ٸq�ܸq㖷ݩS'�߿����S�7o.͚5�˗/Kvv�l۶Mv��]�����ȨQ��_�~ҦM�r劜>}Z6l� ����Ѷ+���ː!Cd���Ҷm[	��/JVV�lڴI>��$%%EΞ=+۶m3�%��w����Kl6�,X�@8�����ߊL�L@@�:q�q*��/���0��}��������m�z����P���m��]w)Q]�tQ˖-SeeeNO�RVV��,Y�z����8���W%%%J)����UHH����������T+�/_V�f�R>߷�����Ə�����7���J)�q�F��KJJR�6mrs���_��>��cu�w���[o�e���+�x4�믿n��{�n���_�:Æ3T~~~����.�k��?�&M�(QM�4Q3g�T���N?ϊ�
�h�"���Un�40~~~�GQG�u������_��WբE���ݺuS/�����r�����D�c���j�̙�ҥK.�}��u�=�(�[;����JMMU�N�r�9�ڵK�5ʣy��G�z�>�����ӧ��W���{��9���sBj�'@4����o���;���Ǽ�!_5��$��y����V]�~��/�Jׯ_W���Վ���ϛ�<x��?�Gc(���ӧՐ!C|�o}Y ED-_�ܴ��={�\6$$���׮]S�?���m<x�X6;;�������+W���HJJ�v�y��ֱ����kݯ_?յkW�+��ݻW�j����-��۷W�7o�fw��g�z�?��^UZZ�նKKK��O?��ckȐ!Ֆ��.\��j�Xu?���ժU�<���B��os��>U�7�|�Շ~�r����>�>'���|DӬ[���ñW�^���5k������Ϝ9����<�����M�?v��ʹ��*77���3f�祗^2-��?:l���T�<yR8���X>�g���p�������6n���s,**RT���.K����g��]�`�i���8��uv"l�?0����Μ9c,��I�a���˦m����Wyyy��]�|Y=zT;v�iyZ�d��yxS cbbN�^)//O�۷Oegg;�GII�����������m�����g��z���}\�1��Q���Bu��I�s��^vW ���Ԇ�q��I�p�B��[o��>�L���;,S�c���׮]��8�TTT�ɪI}�� �w�ަ��֭s�ܜ9sL�M�<��1�`U˖-S�ƍ3���&M�����kZ���BM�0��8��ҵk��;Ｃ������;t蠦O��Ν;gZ>??_�k��'���088�����/�t���_�K�,QÇ7M	U�'OV�r������v���M˽��n����'�^�d������x��e�`�?���;5r�H�׺Y�f�O����b�� ���޴lii��3g��ӧ�iٖ-[�'�|��1w��U�GsTVV�:r�z���UJJ�j߾�i���pu����;w��}��y�r�111277WM�>]u���X���_��ǫ9s�8<�Z�]�z��WM˞>}Z=��G�մi�Lt*��gN��7n����W�������W���>��&�b����;w���I��.ףG��϶l����
��'�}�+  @���{�4BCC�.� �_�^u����8�[�V۶m3��������("�b|�����f�Z���U[؃���v={��j֬��������2;w�t�M???�����5Q��S��ֳ/
			��@��*//W3f�p[.��?�Ӵ·~�rYO����r���j��n�w˖-����M�_��'���� ���_����c��\~ٲe�e7o�\�S���~�Z�v����UlӦ����:uJu�������7=�{��I���sv�򫯾RQQQ>٧��r,� �,��g�>}Z�\���3��u�K�j���ÇMG��f����t�����.k_ ?��S������2ި���#`w�yg��qm�+V�+((p�����3�<��v��իM�>���U���������!C���UXXh���H�������N�},//W?�p��c�&ML�8}���e=)������͕��y�ƅ��(���ec�С5~|��|�HU+W�t�\߾}M,dee�=Zh��/Z��4��h_�ǎ{K�?���/�.g_ ?��c��MR,� �,ӧO��we��,�`��Ʊ/�/���W󌍍5��R�����������gʔ)��_�����(�iii��JKKM�EFF�^�u�Сj_@_5��~�i�m۶9,3r�H������̙3�e222ԛo�i�޻w�˯uU�����t9���s�y�9�\��X�����=��#F���裏��Z�w�}���}��?>*��O?���ʪ�k��R�������wW}=����=�~pp����/����rU`ff��%%���pFW�)???y��Ǎ�eee������:˖-�ӧO�'O�,-[���9V��Ζ͛7����'͛7��8�/6��m�ȑ>��������:t���ӊ~��'RQQ��?n��4.Xi�ƍr��Y��ĉ�n+%%��zz��������cǎ��ok����{Æ-'"�sK�����1<|�p��z�����M�0��c���j۶m�.Su�%%%����l�Jaaa2d����;<^�ƍ�����P�:�N���ׯ{7I�B�uj̘1r�w�����/g���d޼y��+���H�&M�7���̜9�V�*"�}�v㗣�f��={����}:Fqq��߿_("7O4\u������s�L�����t���۞��Ȑ#F��͂Խ{w�/���rIKK�'�|RDDF�%M�6��W��t��M�w�n�NOO�ȹs�u��""r�=�Ȝ9sLcW-����>;�pUU/o("5�����>z��W뗕�Iff�<XDD�t�"���RZZ�r�f͚Ibb����Ill����IDD�q�hgs����v���$��h߾�i�nݺ�믿���mڴ1�ߺu�j���P Q�����'�Hddd�륥���/�l�@�6m�̚5K���ke���U��4k�L���kt�_kѢ�t��ٸm_�Z�ha�}����8y�鶳}�x�b� �����ѣMW%�Z�~��'ٻw���<���c��T-����2l�0��]�}SQQa:2�S�N����p��؈��l�R^{�5y衇�iӦ�6�*LG����j�Mg�8�aÆ�����������[z\�O���q����l�Xzz�T����_�;vt��/ٗ����Z���Pm�s�RRRLG����;��U���[z*�~g�`�֭��X����<�Wi�ҥ���><l�0�cƌ��� �vC(�U�wYY����y���]uT�������:u�Oʟ��׵�����|En����*`� �Τ����i/{O<�|��>۞3�G�<�nmM�)//7=�i5��&O=��q���TV�^mZ�ʕ+���ڵ����{5N���M�/]�䰌RJ>��3y�gDDd������'ҪU+�)Ms\�n�IDD�ʸq�dѢE"b~�������U�� iٲ��?ޫmT��[�l)�W����h�c����f�ٺu����Kaa��/3gΔ~������XJKK�"h�=�+����ۛ6m��[���v-ZtK%��(��M�6�)S��t����ҳg�Z��ݧO��~���c�l6�ݻ�i���ǹUS�L��}��?��3������m����8U_c(r�!�,^��(��[����ٶm�L�0��#77��˾��D���+��/~!"7�.Z�Hd�ر�m7���cǎ^@��tڗ�3f����ٳeƌ��^�7�����-]�t���y��l>����Ǐ���?��1����:��_�R"""��iii��g�y����㗿�f���TIMM��<�
�Q�F����$''������_Z�je�޵k��ǸU}�����z˸���ٳg;,�{�n��q���|��8!!!�}}��Y�oڵk�dee�ILII�m۶�����/ޅ���n�1c�Hpp�<�t��@��=v�X�f�ӫW/St���~�3������������޽�(����ҿ�?��������?^����-��N,?i�9x�q����
գG�[�NӦMM'Խ|���K-ٟ����멧�2���8]��<����/���/�4���(����߿�:{��i;Z��o���ꮻ��x�3f�ƙ;w���_{�5c�C����Pu��5�cw�}��:����K��C�f�  mIDAT3F͞=۸��<�Uc�A�y�9�_����j���<��[�6�7�ܹs^]}��9�Rj�ԩ��Tyy�q��K���f���۷�ݸq��r>��i���t���'O6���<�K�.5-���5I�� ~��w>�6!u�'@y�O�[��UO쫔RO=����]
�w�q{Ց�4�T(���]^3վ ޸q���c����,��W]jR CBB�/��p�����r�?��O�峳�U�V�����6����
�k��'..�4���G��.��%K���{�=��?��}��j�Z_
���O?�Դ�ڵk=z�<�쳦����UӦMM��l6���رc�^���%]��� ���cZ����}&O���_�nZ�U;v�i�˗/{��Iu� ��'@y���UJ����g5�^׮]M�����t���YT��F��t���@��O�ʟRJ͙3��|�]X)�/^��t��t��-[����a�����so`dd�9r��5k����s�׏?��n��v��u��؉'Trr����s�=���|���}�G�1֩z�VwW�x�ᇝ�SQQQ�5bE�W��;��v�R�{�v�|xx��7o��{G)��M��t�C��������s���W;w�T�\@�+�(u�$-[�t�|�Ν�M%W�f�9��ҥK�w�����������Q/���ڽ{�JOOw�6ue(��!�� �V��ĘN�q��)���/k��~�A֬Y#III""ҵkWINN��+W�]O)%6�M��NY�n�?~\6n�(999b��$66V����Wڵk�<��sϯr�����2i�$پ}��۷OΜ9#���ҧOILL���P�zo��V���+���wz�]������p���ٳGƍ�p�g{׮]�|P6l� !!!"r��r�J9z���X�B���%((Hz��!��{���0<(ӧO��sZ�x�����UJ�����W_}%%%%dZg۶m�����t��1�6m����4>ֿ9p��l۶M֮]+gΜ�����������R)--M�Ν�t�}���d����>\�n�*��� �:u�{��t~���u�,Y"o���q^G��\�L�"k׮��ʵkפ]�v/�2���J)y衇���7�aaa2w�\y��We�ƍ��?HQQ����Htt����G�b�v�_�~����������Jo���z��r�����p�B�e� ��曦k�zb���*::��\� ����3g�x5����յs�˴iӼߙ+W������r{��YUQQ����ٳG�m���qz���t���7�8����O{4f}:X�k]VV���NKKs{�ڰ�0�o�>����o��k��������H�;�Νs8�]��������tm_o\�t��K8Hx,� i�y������ŪM�6>ٮ����M�-rXƾ ���K*88X���O;ڻ~���9s�Gw�/��V:tpx�ۙs��y��O2h� ���<�����x�աC�[?66V�X�£񊋋�����j����Z�ʴ�ٳgW�Θ1cL�����W����^ii�j׮��s}��u/^������.���˝?ޣ?�qY�p�JMM��5}"�ڶm�6l�P�6srr�ĉ������?|��G���vxÑ3+V�P����m۶�׍N�2��1bbb��nzs�;�����O?U]�vu�ͣG��ϛ7���Ǆ�r,� i�i޼���?��6mڤ��~�n{РA��o�U���*66��~g����X��K/�;v���\����oٲE���.��8��Xuo���:t�***R�������jŊ�7���
��}�����}�]���͛o���򗿨_��W�w��Oӷo_5s�L�e��������Ս7ԩS��ʕ+�3�<��Q?�DFF���{Om޼Y���+*  ���&M��֮]����U\\����ٳg�6�|Ы�6k�L͛7O�[�N%%%��������kתQ�Fy�}�ͦ����ܹs��ݻ�w�_�zUeee�%K��G}�����mwҤIj�ҥ�ԩS���L]�pAedd��K��)S���{۶mէ�~�V�\������8!!!�GQ˗/7ƹx�:|��z�������M�?���jÆ�7���SݻwW/������oUNN��r�RJ���"����V�X�^x�u�m�U����իW��z�'B�Y,� !�wЗqW 	!����  �
   �f(�   ��   h�  �
   �f(�h��^�j�}�ʕZ�~��5  �BD�u��!���ED$''G/^\+�,^�XN�8!""+V�����Z  _�������������ӧ�ƍ�6N�&M�]�v���-�6  �@  �O  h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f(�   ��   h�  �
   �f��vspx���    IEND�B`�    
   �����so   res://icons/a_button.svg��5^%?   res://icons/b_button.svg]l���?�S   res://icons/dpad.svg
w��C�Vb   res://icons/loader.svg@ 2���D   res://icons/no_image.svg-��p�   res://icons/wifi-off.svg��z���*   res://app_item.tscn�'u�7O_   res://main.tscn��Ra�j�$   res://splash.png`FBq��8z   res://VarelaRound-Regular.ttf           ECFG      application/config/name         app_test   application/run/main_scene         res://main.tscn    application/config/features   "         4.1     application/boot_splash/bg_color                    �?   application/boot_splash/image         res://splash.png   autoload/HTTP$         *res://singletons/http.gd   "   display/window/size/viewport_width      �  #   display/window/size/viewport_height      �     gui/theme/custom_font(         res://VarelaRound-Regular.ttf      input/download�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script      
   input/back�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   B   	   key_label             unicode    b      echo          script      #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility2   rendering/environment/defaults/default_clear_color                    �?     