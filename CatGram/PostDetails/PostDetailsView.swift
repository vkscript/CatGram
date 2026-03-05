//
//  PostDetailsView.swift
//  CatGram
//

protocol PostDetailsView: AnyObject {
    func render(_ state: PostDetailsViewState)
}
