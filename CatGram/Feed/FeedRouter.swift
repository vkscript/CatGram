//
//  FeedRouter.swift
//  CatGram
//

import UIKit

protocol FeedRouter {
    func openPostDetails(id: String)
}

final class FeedRouterImpl: FeedRouter {
    weak var viewController: UIViewController?

    func openPostDetails(id: String) {
        let examplesVC = BDUIExampleViewController()
        viewController?.navigationController?.pushViewController(examplesVC, animated: true)
    }
}
