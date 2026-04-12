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
        // Создаем заглушку для экрана деталей поста
        let detailsVC = UIViewController()
        detailsVC.view.backgroundColor = .systemBackground
        detailsVC.title = "Детали поста"
        
        let label = UILabel()
        label.text = "Детали поста \(id)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        detailsVC.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: detailsVC.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: detailsVC.view.centerYAnchor)
        ])
        
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
