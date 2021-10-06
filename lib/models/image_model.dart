class ImageModel {
  final String name;
  final String imgUrl;

  ImageModel(
    this.name,
    this.imgUrl,
  );

  factory ImageModel.fromJson(dynamic json) {
    return ImageModel(
      json['name'] as String,
      json['url'] as String,
    );
  }

  @override
  String toString() {
    return '{ $name,$imgUrl}';
  }
}
