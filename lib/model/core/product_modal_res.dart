class GetProducts {
  String? name;
  int? id;
  String? nameArabic;
  int? categoryId;
  String? rating;
  int? isInWishListCount;
  int? ratingsCount;
  int? sortPrice;
  Category? category;
  Offers? offers;
  CartSummaries? cartSummaries;
  Price? price;
  Inventory? inventory;
  List<Images>? images;
  List<dynamic>? tags;
  Storage? storage;

  GetProducts(
      {this.name,
      this.id,
      this.nameArabic,
      this.categoryId,
      this.rating,
      this.isInWishListCount,
      this.ratingsCount,
      this.sortPrice,
      this.category,
      this.offers,
      this.cartSummaries,
      this.price,
      this.inventory,
      this.images,
      this.tags,
      this.storage});

  GetProducts.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.id = json["id"];
    this.nameArabic = json["name_arabic"];
    this.categoryId = json["category_id"];
    this.rating = json["rating"];
    this.isInWishListCount = json["is_in_wish_list_count"];
    this.ratingsCount = json["ratings_count"];
    this.sortPrice = json["sort_price"];
    this.category =
        json["category"] == null ? null : Category.fromJson(json["category"]);
    this.offers =
        json["offers"] == null ? null : Offers.fromJson(json["offers"]);
    this.cartSummaries = json["cart_summaries"] == null
        ? null
        : CartSummaries.fromJson(json["cart_summaries"]);
    this.price = json["price"] == null ? null : Price.fromJson(json["price"]);
    this.inventory = json["inventory"] == null
        ? null
        : Inventory.fromJson(json["inventory"]);
    this.images = json["images"] == null
        ? null
        : (json["images"] as List).map((e) => Images.fromJson(e)).toList();
    this.tags = json["tags"] ?? [];
    this.storage =
        json["storage"] == null ? null : Storage.fromJson(json["storage"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["id"] = this.id;
    data["name_arabic"] = this.nameArabic;
    data["category_id"] = this.categoryId;
    data["rating"] = this.rating;
    data["is_in_wish_list_count"] = this.isInWishListCount;
    data["ratings_count"] = this.ratingsCount;
    data["sort_price"] = this.sortPrice;
    if (this.category != null) data["category"] = this.category?.toJson();
    if (this.offers != null) data["offers"] = this.offers?.toJson();
    if (this.cartSummaries != null)
      data["cart_summaries"] = this.cartSummaries?.toJson();
    if (this.price != null) data["price"] = this.price?.toJson();
    if (this.inventory != null) data["inventory"] = this.inventory?.toJson();
    if (this.images != null)
      data["images"] = this.images?.map((e) => e.toJson()).toList();
    if (this.tags != null) data["tags"] = this.tags;
    if (this.storage != null) data["storage"] = this.storage?.toJson();
    return data;
  }
}

class Images {
  int? productId;
  String? imageUrl;
  int? isDefault;

  Images({this.productId, this.imageUrl, this.isDefault});

  Images.fromJson(Map<String, dynamic> json) {
    this.productId = json["product_id"];
    this.imageUrl = json["image_url"];
    this.isDefault = json["IS_default"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["product_id"] = this.productId;
    data["image_url"] = this.imageUrl;
    data["IS_default"] = this.isDefault;
    return data;
  }
}

class Storage {
  int? id;
  int? productId;
  int? quantityOnhand;
  int? quantityReserved;
  Product? product;

  Storage(
      {this.id,
      this.productId,
      this.quantityOnhand,
      this.quantityReserved,
      this.product});

  Storage.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.productId = json["product_id"];
    this.quantityOnhand = json["quantity_onhand"];
    this.quantityReserved = json["quantity_reserved"];
    this.product =
        json["product"] == null ? null : Product.fromJson(json["product"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["product_id"] = this.productId;
    data["quantity_onhand"] = this.quantityOnhand;
    data["quantity_reserved"] = this.quantityReserved;
    if (this.product != null) data["product"] = this.product?.toJson();
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? nameArabic;
  String? referenceNo;
  String? barCode;
  dynamic? description;
  dynamic? brandId;
  int? categoryId;
  int? posCategoryId;
  int? isActive;
  int? isAvailableInPos;
  int? isPurchased;
  int? isSaleable;
  int? isAvailableInApp;
  int? isForAll;
  int? isTrackable;
  int? isPurchaseFromStore;
  dynamic? logoUrl;
  dynamic? metaTitle;
  dynamic? metaDescription;
  dynamic? metaTags;
  String? rating;
  String? createdAt;
  String? updatedAt;
  dynamic? deletedAt;

  Product(
      {this.id,
      this.name,
      this.nameArabic,
      this.referenceNo,
      this.barCode,
      this.description,
      this.brandId,
      this.categoryId,
      this.posCategoryId,
      this.isActive,
      this.isAvailableInPos,
      this.isPurchased,
      this.isSaleable,
      this.isAvailableInApp,
      this.isForAll,
      this.isTrackable,
      this.isPurchaseFromStore,
      this.logoUrl,
      this.metaTitle,
      this.metaDescription,
      this.metaTags,
      this.rating,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Product.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.nameArabic = json["name_arabic"];
    this.referenceNo = json["reference_no"];
    this.barCode = json["bar_code"];
    this.description = json["description"];
    this.brandId = json["brand_id"];
    this.categoryId = json["category_id"];
    this.posCategoryId = json["pos_category_id"];
    this.isActive = json["IS_active"];
    this.isAvailableInPos = json["IS_available_in_pos"];
    this.isPurchased = json["IS_purchased"];
    this.isSaleable = json["IS_saleable"];
    this.isAvailableInApp = json["IS_available_in_app"];
    this.isForAll = json["IS_for_all"];
    this.isTrackable = json["IS_trackable"];
    this.isPurchaseFromStore = json["IS_purchase_from_store"];
    this.logoUrl = json["logo_url"];
    this.metaTitle = json["meta_title"];
    this.metaDescription = json["meta_description"];
    this.metaTags = json["meta_tags"];
    this.rating = json["rating"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
    this.deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["name_arabic"] = this.nameArabic;
    data["reference_no"] = this.referenceNo;
    data["bar_code"] = this.barCode;
    data["description"] = this.description;
    data["brand_id"] = this.brandId;
    data["category_id"] = this.categoryId;
    data["pos_category_id"] = this.posCategoryId;
    data["IS_active"] = this.isActive;
    data["IS_available_in_pos"] = this.isAvailableInPos;
    data["IS_purchased"] = this.isPurchased;
    data["IS_saleable"] = this.isSaleable;
    data["IS_available_in_app"] = this.isAvailableInApp;
    data["IS_for_all"] = this.isForAll;
    data["IS_trackable"] = this.isTrackable;
    data["IS_purchase_from_store"] = this.isPurchaseFromStore;
    data["logo_url"] = this.logoUrl;
    data["meta_title"] = this.metaTitle;
    data["meta_description"] = this.metaDescription;
    data["meta_tags"] = this.metaTags;
    data["rating"] = this.rating;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    data["deleted_at"] = this.deletedAt;
    return data;
  }
}

class Inventory {
  int? id;
  int? productId;
  int? criticalPoint;
  int? isSalableNstocks;

  Inventory(
      {this.id, this.productId, this.criticalPoint, this.isSalableNstocks});

  Inventory.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.productId = json["product_id"];
    this.criticalPoint = json["critical_point"];
    this.isSalableNstocks = json["Is_salable_nstocks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["product_id"] = this.productId;
    data["critical_point"] = this.criticalPoint;
    data["Is_salable_nstocks"] = this.isSalableNstocks;
    return data;
  }
}

class Price {
  int? id;
  int? productId;
  int? salePrice;
  int? taxId;
  Tax? tax;

  Price({this.id, this.productId, this.salePrice, this.taxId, this.tax});

  Price.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.productId = json["product_id"];
    this.salePrice = json["sale_price"];
    this.taxId = json["tax_id"];
    this.tax = json["tax"] == null ? null : Tax.fromJson(json["tax"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["product_id"] = this.productId;
    data["sale_price"] = this.salePrice;
    data["tax_id"] = this.taxId;
    if (this.tax != null) data["tax"] = this.tax?.toJson();
    return data;
  }
}

class Tax {
  int? id;
  String? name;
  String? nameArabic;
  int? rate;
  int? isPriceInclude;

  Tax({this.id, this.name, this.nameArabic, this.rate, this.isPriceInclude});

  Tax.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.nameArabic = json["name_arabic"];
    this.rate = json["rate"];
    this.isPriceInclude = json["IS_price_include"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["name_arabic"] = this.nameArabic;
    data["rate"] = this.rate;
    data["IS_price_include"] = this.isPriceInclude;
    return data;
  }
}

class CartSummaries {
  int? quantity;

  CartSummaries({this.quantity});

  CartSummaries.fromJson(Map<String, dynamic> json) {
    this.quantity = json["quantity"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["quantity"] = this.quantity;
    return data;
  }
}

class Offers {
  int? productId;
  int? discount;
  int? retailprice;
  int? pricebookId;
  int? maxUnit;
  String? discountType;
  PriceBook? priceBook;

  Offers(
      {this.productId,
      this.discount,
      this.retailprice,
      this.pricebookId,
      this.maxUnit,
      this.discountType,
      this.priceBook});

  Offers.fromJson(Map<String, dynamic> json) {
    this.productId = json["product_id"];
    this.discount = json["discount"];
    this.retailprice = json["retailprice"];
    this.pricebookId = json["pricebook_id"];
    this.maxUnit = json["max_unit"];
    this.discountType = json["discount_type"];
    this.priceBook = json["price_book"] == null
        ? null
        : PriceBook.fromJson(json["price_book"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["product_id"] = this.productId;
    data["discount"] = this.discount;
    data["retailprice"] = this.retailprice;
    data["pricebook_id"] = this.pricebookId;
    data["max_unit"] = this.maxUnit;
    data["discount_type"] = this.discountType;
    if (this.priceBook != null) data["price_book"] = this.priceBook?.toJson();
    return data;
  }
}

class PriceBook {
  int? id;
  String? name;
  String? nameArabic;
  String? description;
  String? descriptionArabic;
  int? isActive;
  String? validFrom;
  String? validTo;
  String? file;
  int? isAvailableOfflineCustomer;
  String? discountType;
  String? type;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  PriceBook(
      {this.id,
      this.name,
      this.nameArabic,
      this.description,
      this.descriptionArabic,
      this.isActive,
      this.validFrom,
      this.validTo,
      this.file,
      this.isAvailableOfflineCustomer,
      this.discountType,
      this.type,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  PriceBook.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.nameArabic = json["name_arabic"];
    this.description = json["description"];
    this.descriptionArabic = json["description_arabic"];
    this.isActive = json["IS_active"];
    this.validFrom = json["valid_from"];
    this.validTo = json["valid_to"];
    this.file = json["file"];
    this.isAvailableOfflineCustomer = json["IS_available_offline_customer"];
    this.discountType = json["discount_type"];
    this.type = json["type"];
    this.createdBy = json["created_by"];
    this.updatedBy = json["updated_by"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
    this.deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["name_arabic"] = this.nameArabic;
    data["description"] = this.description;
    data["description_arabic"] = this.descriptionArabic;
    data["IS_active"] = this.isActive;
    data["valid_from"] = this.validFrom;
    data["valid_to"] = this.validTo;
    data["file"] = this.file;
    data["IS_available_offline_customer"] = this.isAvailableOfflineCustomer;
    data["discount_type"] = this.discountType;
    data["type"] = this.type;
    data["created_by"] = this.createdBy;
    data["updated_by"] = this.updatedBy;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    data["deleted_at"] = this.deletedAt;
    return data;
  }
}

class Category {
  int? id;
  int? parentId;
  dynamic? offers;

  Category({this.id, this.parentId, this.offers});

  Category.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.parentId = json["parent_id"];
    this.offers = json["offers"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["parent_id"] = this.parentId;
    data["offers"] = this.offers;
    return data;
  }
}
