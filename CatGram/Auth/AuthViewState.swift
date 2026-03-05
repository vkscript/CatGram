//
//  AuthViewState.swift
//  CatGram
//

enum AuthViewState: Equatable {
    case initial
    case loading
    case error(message: String)
}
