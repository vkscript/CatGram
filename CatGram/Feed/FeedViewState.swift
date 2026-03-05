//
//  FeedViewState.swift
//  CatGram
//

enum FeedViewState: Equatable {
    case initial
    case loading
    case content([Post])
    case empty
    case error(message: String)
}
