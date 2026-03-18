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

        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = "Login success"
        label.font = .systemFont(ofSize: 24, weight: .bold)

        vc.view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
        ])

        viewController?.navigationController?.pushViewController(vc, animated: true)

    }
}
