//
//  FeedViewState.swift
//  CatGram
//

enum FeedViewState: Equatable {
    case loading
    case content([PostViewModel])
    case empty
    case error(message: String)
}
