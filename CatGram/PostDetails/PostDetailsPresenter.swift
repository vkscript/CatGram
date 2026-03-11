//
//  PostDetailsPresenter.swift
//  CatGram
//

protocol PostDetailsPresenter {
    func didLoad()
    func didTapLike()
    func didSendComment(text: String)
}
