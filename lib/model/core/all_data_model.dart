import 'dart:convert';

List<ProductList> productFromJson(String str) => List<ProductList>.from(
    json.decode(str).map((x) => ProductList.fromJson(x)));

String productToJson(List<ProductList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductList {
  String? restaurantId;
  String? restaurantName;
  String? restaurantImage;
  String? tableId;
  String? tableName;
  String? branchName;
  String? nexturl;
  List<TableMenuList>? tableMenuList;

  ProductList(
      {this.restaurantId,
      this.restaurantName,
      this.restaurantImage,
      this.tableId,
      this.tableName,
      this.branchName,
      this.nexturl,
      this.tableMenuList});

  ProductList.fromJson(Map<String, dynamic> json) {
    this.restaurantId = json["restaurant_id"];
    this.restaurantName = json["restaurant_name"];
    this.restaurantImage = json["restaurant_image"];
    this.tableId = json["table_id"];
    this.tableName = json["table_name"];
    this.branchName = json["branch_name"];
    this.nexturl = json["nexturl"];
    this.tableMenuList = json["table_menu_list"] == null
        ? null
        : (json["table_menu_list"] as List)
            .map((e) => TableMenuList.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["restaurant_id"] = this.restaurantId;
    data["restaurant_name"] = this.restaurantName;
    data["restaurant_image"] = this.restaurantImage;
    data["table_id"] = this.tableId;
    data["table_name"] = this.tableName;
    data["branch_name"] = this.branchName;
    data["nexturl"] = this.nexturl;
    if (this.tableMenuList != null)
      data["table_menu_list"] =
          this.tableMenuList?.map((e) => e.toJson()).toList();
    return data;
  }
}

class TableMenuList {
  String? menuCategory;
  String? menuCategoryId;
  String? menuCategoryImage;
  String? nexturl;
  List<CategoryDishes>? categoryDishes;

  TableMenuList(
      {this.menuCategory,
      this.menuCategoryId,
      this.menuCategoryImage,
      this.nexturl,
      this.categoryDishes});

  TableMenuList.fromJson(Map<String, dynamic> json) {
    this.menuCategory = json["menu_category"];
    this.menuCategoryId = json["menu_category_id"];
    this.menuCategoryImage = json["menu_category_image"];
    this.nexturl = json["nexturl"];
    this.categoryDishes = json["category_dishes"] == null
        ? null
        : (json["category_dishes"] as List)
            .map((e) => CategoryDishes.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["menu_category"] = this.menuCategory;
    data["menu_category_id"] = this.menuCategoryId;
    data["menu_category_image"] = this.menuCategoryImage;
    data["nexturl"] = this.nexturl;
    if (this.categoryDishes != null)
      data["category_dishes"] =
          this.categoryDishes?.map((e) => e.toJson()).toList();
    return data;
  }
}

class CategoryDishes {
  String? dishId;
  String? dishName;
  num? dishPrice;
  String? dishImage;
  String? dishCurrency;
  num? dishCalories;
  String? dishDescription;
  bool? dishAvailability;
  num? dishType;
  String? nexturl;
  int? counter;

  List<AddonCat>? addonCat;

  CategoryDishes(
      {this.dishId,
      this.dishName,
      this.dishPrice,
      this.dishImage,
      this.dishCurrency,
      this.dishCalories,
      this.dishDescription,
      this.dishAvailability,
      this.dishType,
      this.nexturl,
      this.counter,
      this.addonCat});

  CategoryDishes.fromJson(Map<String, dynamic> json) {
    this.dishId = json["dish_id"];
    this.dishName = json["dish_name"];
    this.dishPrice = json["dish_price"];
    this.dishImage = json["dish_image"];
    this.dishCurrency = json["dish_currency"];
    this.dishCalories = json["dish_calories"];
    this.dishDescription = json["dish_description"];
    this.dishAvailability = json["dish_Availability"];
    this.dishType = json["dish_Type"];
    this.nexturl = json["nexturl"];
    this.counter = json["counter"] ?? 0;
    this.addonCat = json["addonCat"] == null
        ? null
        : (json["addonCat"] as List).map((e) => AddonCat.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["dish_id"] = this.dishId;
    data["dish_name"] = this.dishName;
    data["dish_price"] = this.dishPrice;
    data["dish_image"] = this.dishImage;
    data["dish_currency"] = this.dishCurrency;
    data["dish_calories"] = this.dishCalories;
    data["dish_description"] = this.dishDescription;
    data["dish_Availability"] = this.dishAvailability;
    data["dish_Type"] = this.dishType;
    data["nexturl"] = this.nexturl;
    data["counter"] = this.counter;
    if (this.addonCat != null)
      data["addonCat"] = this.addonCat?.map((e) => e.toJson()).toList();
    return data;
  }
}

class AddonCat {
  String? addonCategory;
  String? addonCategoryId;
  num? addonSelection;
  String? nexturl;
  List<Addons>? addons;

  AddonCat(
      {this.addonCategory,
      this.addonCategoryId,
      this.addonSelection,
      this.nexturl,
      this.addons});

  AddonCat.fromJson(Map<String, dynamic> json) {
    this.addonCategory = json["addon_category"];
    this.addonCategoryId = json["addon_category_id"];
    this.addonSelection = json["addon_selection"];
    this.nexturl = json["nexturl"];
    this.addons = json["addons"] == null
        ? null
        : (json["addons"] as List).map((e) => Addons.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["addon_category"] = this.addonCategory;
    data["addon_category_id"] = this.addonCategoryId;
    data["addon_selection"] = this.addonSelection;
    data["nexturl"] = this.nexturl;
    if (this.addons != null)
      data["addons"] = this.addons?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Addons {
  String? dishId;
  String? dishName;
  num? dishPrice;
  String? dishImage;
  String? dishCurrency;
  num? dishCalories;
  String? dishDescription;
  bool? dishAvailability;
  int? dishType;

  Addons(
      {this.dishId,
      this.dishName,
      this.dishPrice,
      this.dishImage,
      this.dishCurrency,
      this.dishCalories,
      this.dishDescription,
      this.dishAvailability,
      this.dishType});

  Addons.fromJson(Map<String, dynamic> json) {
    this.dishId = json["dish_id"];
    this.dishName = json["dish_name"];
    this.dishPrice = json["dish_price"];
    this.dishImage = json["dish_image"];
    this.dishCurrency = json["dish_currency"];
    this.dishCalories = json["dish_calories"];
    this.dishDescription = json["dish_description"];
    this.dishAvailability = json["dish_Availability"];
    this.dishType = json["dish_Type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["dish_id"] = this.dishId;
    data["dish_name"] = this.dishName;
    data["dish_price"] = this.dishPrice;
    data["dish_image"] = this.dishImage;
    data["dish_currency"] = this.dishCurrency;
    data["dish_calories"] = this.dishCalories;
    data["dish_description"] = this.dishDescription;
    data["dish_Availability"] = this.dishAvailability;
    data["dish_Type"] = this.dishType;
    return data;
  }
}
