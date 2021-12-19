class GetCategories {
  int? id;
  String? name;
  String? nameArabic;
  String? imageUrl;
  int? isActive;
  int? isAvailableInApp;

  GetCategories(
      {this.id,
      this.name,
      this.nameArabic,
      this.imageUrl,
      this.isActive,
      this.isAvailableInApp});

  GetCategories.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.nameArabic = json["name_arabic"];
    this.imageUrl = json["image_url"];
    this.isActive = json["IS_active"];
    this.isAvailableInApp = json["IS_available_in_app"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["name_arabic"] = this.nameArabic;
    data["image_url"] = this.imageUrl;
    data["IS_active"] = this.isActive;
    data["IS_available_in_app"] = this.isAvailableInApp;
    return data;
  }
}
