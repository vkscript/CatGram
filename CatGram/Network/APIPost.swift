//
//  APIPost.swift
//  CatGram
//

import Foundation

struct APIPost: Decodable {
    let id: String
    let authorName: String
    let imageUrl: String
    let text: String
    let likesCount: Int
    let commentsCount: Int
    let createdAt: Date
}
