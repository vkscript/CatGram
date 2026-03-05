//
//  AuthPresentor.swift
//  CatGram
//

protocol AuthPresenter {
    func didLoad()
    func didTapLogin(email: String, password: String)
}
