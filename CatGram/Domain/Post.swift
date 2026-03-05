//
//  Post.swift
//  CatGram
//

struct Post: Equatable {
    let id: String
    let author: String
    let text: String
    let likesCount: Int
    let commentsCount: Int
    let isLiked: Bool
}
