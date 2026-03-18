//
//  FeedView.swift
//  CatGram
//

import UIKit

protocol FeedView: AnyObject {
    func render(_ state: FeedViewState)
}

final class FeedViewImpl: UIViewController, FeedView {

    var presenter: FeedPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad()
    }

    func render(_ state: FeedViewState) {
        switch state {
        case .loading:
            print("[FeedView] loading...")
        case .content(let viewModels):
            print("[FeedView] content: \(viewModels.count) count")
            for post in viewModels {
                print("[FeedView] post text: \(post.text)")
            }
        case .empty:
            print("[FeedView] empty")
        case .error(let message):
            print("[FeedView] error: \(message)")
        }
    }
}
