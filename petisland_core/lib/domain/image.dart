part of petisland_core.domain;

class Image extends BaseModel {
  String url;
  String publicId;

  Image({
    String id,
    Account createBy,
    DateTime createAt,
    DateTime updateAt,
    this.url,
    this.publicId,
  }) : super(id, createAt, updateAt, createBy);

  Image.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    url = json['url'];
    publicId = json['public_id'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = super.toJson();
    _addValueToMap('url', url, map);
    _addValueToMap('public_id', publicId, map);
    return map;
  }
}