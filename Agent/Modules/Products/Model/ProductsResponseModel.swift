//
//  ProductsResponseModel.swift
//  Agent
//
//  Created by Ibrahim on 21/11/2024.
//

struct ProductsResponseModel:Codable {
    var products:[ProductModel]?
    var total:Int?
    var skip:Int?
    var limit:Int?
    enum CodingKeys: String, CodingKey {
        case products,total,limit,skip
    }
}

struct ProductModel:Codable {
    var id:Int?
    var title:String?
    var description:String?
    var category:String?
    var price:Float?
    var discountPercentage:Float?
    var rating:Float?
    var stock:Int?
    var tags:[String]?
    var brand:String?
    var sku:String?
    var weight:Float?
    var dimensions:DimensionModel?
    var warrantyInformation:String?
    var shippingInformation:String?
    var availabilityStatus:String?
    var reviews:[ReviewModel]?
    var returnPolicy:String?
    var minimumOrderQuantity:Float?
    var meta:MetaModel?
    var images:[String]?
    var thumbnail:String?
    
    enum CodingKeys: String, CodingKey {
        case id,title,description,category,price,discountPercentage,rating,stock,tags
        case brand,sku,weight,dimensions,warrantyInformation,shippingInformation,availabilityStatus
        case reviews,returnPolicy,minimumOrderQuantity,images,thumbnail,meta
    }
}

struct DimensionModel:Codable {
    var width:Float?
    var height:Float?
    var depth:Float?
    
    enum CodingKeys: String, CodingKey {
        case width,height,depth
    }
}

struct ReviewModel:Codable {
    var rating:Float?
    var comment:String?
    var date:String?
    var reviewerName:String?
    var reviewerEmail:String?
    
    enum CodingKeys: String, CodingKey {
        case rating,comment,date,reviewerName,reviewerEmail
    }
    
}

struct MetaModel:Codable {
    var created:String?
    var updated:String?
    var bar:String?
    var qr:String?
    
    enum CodingKeys: String, CodingKey {
        case created = "createdAt"
        case updated = "updatedAt"
        case bar = "barcode"
        case qr = "qrCode"
    }
    
}
