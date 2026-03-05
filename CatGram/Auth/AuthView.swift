//
//  AuthView.swift
//  CatGram
//

protocol AuthView: AnyObject {
    func render(_ state: AuthViewState)
}
