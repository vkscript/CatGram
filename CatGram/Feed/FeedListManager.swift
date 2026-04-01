//
//  FeedListManager.swift
//  CatGram
//

import UIKit

protocol FeedListManagerDelegate: AnyObject {
    func didSelectPost(id: String)
}

final class FeedListManager: NSObject {
    weak var delegate: FeedListManagerDelegate?
    private var items: [PostViewModel] = []
    
    func setItems(_ items: [PostViewModel]) {
        self.items = items
    }
}

extension FeedListManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PostCell",
            for: indexPath
        ) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

extension FeedListManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        delegate?.didSelectPost(id: item.id)
    }
}
