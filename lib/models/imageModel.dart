class ImageModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? promotedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  Urls? urls;

  ImageModel(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.promotedAt,
        this.width,
        this.height,
        this.color,
        this.blurHash,
        this.urls});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    promotedAt = json['promoted_at'];
    width = json['width'];
    height = json['height'];
    color = json['color'];
    blurHash = json['blur_hash'];
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['promoted_at'] = promotedAt;
    data['width'] = width;
    data['height'] = height;
    data['color'] = color;
    data['blur_hash'] = blurHash;
    if (urls != null) {
      data['urls'] = urls!.toJson();
    }
    return data;
  }
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Urls(
      {this.raw,
        this.full,
        this.regular,
        this.small,
        this.thumb,
        this.smallS3});

  Urls.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
    smallS3 = json['small_s3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['raw'] = raw;
    data['full'] = full;
    data['regular'] = regular;
    data['small'] = small;
    data['thumb'] = thumb;
    data['small_s3'] = smallS3;
    return data;
  }
}
