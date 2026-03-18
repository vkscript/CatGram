//
//  AuthRouter.swift
//  CatGram
//

import UIKit

protocol AuthRouter {
    func openMainScreen()
}

final class AuthRouterImpl: AuthRouter {

    weak var viewController: UIViewController?

    func openMainScreen() {
        let networkClient: NetworkClient = Configuration.useLocalNetworkClient
            ? LocalFileNetworkClient()
            : URLSessionNetworkClient()

        let service = FeedServiceImpl(networkClient: networkClient)
        let feedRouter = FeedRouterImpl()

        let view = FeedViewImpl()
        feedRouter.viewController = view

        let feedPresenter = FeedPresenterImpl(
            view: view,
            service: service,
            router: feedRouter
        )
        view.presenter = feedPresenter

        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
