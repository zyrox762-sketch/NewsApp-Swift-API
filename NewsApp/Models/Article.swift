//
//  Article.swift
//  NewsApp
//
//  Created by !---------? on 20/09/2026.
//

import Foundation

struct ArticleResponse:Codable{
    var articles:[Article]
}
struct Source:Codable{
    var name:String
}
struct Article:Codable,Identifiable{
    var id : String {title}
    var source:Source
    var author:String?
    var title:String
    var description:String?
    var url:String
    var urlToImage:String?
    var publishedAt:String
    var content:String?
}
