//
//  FeedView.swift
//  CatGram
//

protocol FeedView: AnyObject {
    func render(_ state: FeedViewState)
}
