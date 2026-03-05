//
//  PostDetailsViewState.swift
//  CatGram
//

enum PostDetailsViewState: Equatable {
    case loading
    case content(PostDetails)
    case error(message: String)
}
