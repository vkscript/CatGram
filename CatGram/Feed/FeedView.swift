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
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let emptyStateLabel = UILabel()
    private let errorStateLabel = UILabel()
    private let retryButton = UIButton(type: .system)
    
    private lazy var listManager = FeedListManager()
    private var currentState: FeedViewState = .loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        presenter.didLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Лента"
        
        // Setup loading indicator
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        
        // Setup empty state
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.text = "Нет постов"
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.isHidden = true
        view.addSubview(emptyStateLabel)
        
        // Setup error state
        errorStateLabel.translatesAutoresizingMaskIntoConstraints = false
        errorStateLabel.textAlignment = .center
        errorStateLabel.numberOfLines = 0
        errorStateLabel.isHidden = true
        view.addSubview(errorStateLabel)
        
        // Setup retry button
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.setTitle("Повторить", for: .normal)
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        retryButton.isHidden = true
        view.addSubview(retryButton)
        
        // Setup tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            emptyStateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            
            errorStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            errorStateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            errorStateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorStateLabel.bottomAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = listManager
        tableView.dataSource = listManager
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        
        // Setup pull-to-refresh
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        listManager.delegate = self
    }
    
    @objc private func refreshData() {
        presenter.didPullToRefresh()
    }
    
    @objc private func retryTapped() {
        presenter.didLoad()
    }
    
    func render(_ state: FeedViewState) {
        currentState = state
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            
            switch state {
            case .loading:
                self.showLoadingState()
            case .content(let posts):
                self.showContentState(posts: posts)
            case .empty:
                self.showEmptyState()
            case .error(let message):
                self.showErrorState(message: message)
            }
        }
    }
    
    private func showLoadingState() {
        tableView.isHidden = true
        emptyStateLabel.isHidden = true
        errorStateLabel.isHidden = true
        retryButton.isHidden = true
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    private func showContentState(posts: [PostViewModel]) {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        emptyStateLabel.isHidden = true
        errorStateLabel.isHidden = true
        retryButton.isHidden = true
        tableView.isHidden = false
        
        listManager.setItems(posts)
        tableView.reloadData()
    }
    
    private func showEmptyState() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        tableView.isHidden = true
        errorStateLabel.isHidden = true
        retryButton.isHidden = true
        emptyStateLabel.isHidden = false
    }
    
    private func showErrorState(message: String) {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        tableView.isHidden = true
        emptyStateLabel.isHidden = true
        errorStateLabel.isHidden = false
        retryButton.isHidden = false
        errorStateLabel.text = message
    }
}

extension FeedViewImpl: FeedListManagerDelegate {
    func didSelectPost(id: String) {
        presenter.didSelectPost(id: id)
    }
}
