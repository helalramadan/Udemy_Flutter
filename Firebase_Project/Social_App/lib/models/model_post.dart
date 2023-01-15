class SocialPostModle {
  String? name;
  String? text;
  String? datetime;
  String? uId;
  String? image;
  // String? cover;
  String? postimage;
  // bool? isEmailVerified;

  SocialPostModle({
    this.name,
    this.text,
    this.datetime,
    this.uId,
    this.image,
    // this.cover,
    this.postimage,
    // this.isEmailVerified,
  });
  SocialPostModle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];
    datetime = json['datetime'];
    uId = json['uId'];
    image = json['image'];
    // // cover = json['cover'];
    postimage = json['postimage'];
    // // isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'datetime': datetime,
      'uId': uId,
      'image': image,
      // // 'cover': cover,
      'postimage': postimage,
      // // 'isEmailVerified': isEmailVerified,
    };
  }
}
