//
//  FeedPresenter.swift
//  CatGram
//

protocol FeedPresenter {
    func didLoad()
    func didSelectPost(id: String)
    func didPullToRefresh()
}
