//
//  PostViewModel.swift
//  CatGram
//

struct PostViewModel: Equatable {
    let id: String
    let author: String
    let text: String
    let likesCount: Int
    let commentsCount: Int
    let createdAtString: String
}
