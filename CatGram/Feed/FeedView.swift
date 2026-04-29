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
    
    private var loadingView: DSLoadingView?
    private var errorView: DSErrorView?
    private var emptyView: DSEmptyView?
    
    private lazy var listManager = FeedListManager()
    private var currentState: FeedViewState = .loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        presenter.didLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = DS.Colors.background
        title = "Лента"
        
        // Setup tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = DS.Colors.background
        tableView.separatorColor = DS.Colors.separator
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
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
        
        // Setup pull-to-refresh с DS цветами
        refreshControl.tintColor = DS.Colors.primary
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        listManager.delegate = self
    }
    
    @objc private func refreshData() {
        presenter.didPullToRefresh()
    }
    
    func render(_ state: FeedViewState) {
        currentState = state
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.removeAllStateViews()
            
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
    
    private func removeAllStateViews() {
        loadingView?.removeFromSuperview()
        errorView?.removeFromSuperview()
        emptyView?.removeFromSuperview()
        loadingView = nil
        errorView = nil
        emptyView = nil
    }
    
    private func showLoadingState() {
        tableView.isHidden = true
        
        let loading = DSLoadingView(message: "Загружаем ленту...")
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        
        NSLayoutConstraint.activate([
            loading.topAnchor.constraint(equalTo: view.topAnchor),
            loading.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loading.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loading.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loadingView = loading
    }
    
    private func showContentState(posts: [PostViewModel]) {
        tableView.isHidden = false
        listManager.setItems(posts)
        tableView.reloadData()
    }
    
    private func showEmptyState() {
        tableView.isHidden = true
        
        let empty = DSEmptyView(
            title: "Нет постов",
            message: "Здесь пока ничего нет. Попробуйте обновить ленту.",
            icon: UIImage(systemName: "photo.on.rectangle.angled")
        )
        empty.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(empty)
        
        NSLayoutConstraint.activate([
            empty.topAnchor.constraint(equalTo: view.topAnchor),
            empty.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            empty.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            empty.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        emptyView = empty
    }
    
    private func showErrorState(message: String) {
        tableView.isHidden = true
        
        let error = DSErrorView(message: message)
        error.translatesAutoresizingMaskIntoConstraints = false
        error.onRetry = { [weak self] in
            self?.presenter.didLoad()
        }
        view.addSubview(error)
        
        NSLayoutConstraint.activate([
            error.topAnchor.constraint(equalTo: view.topAnchor),
            error.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            error.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            error.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        errorView = error
    }
}

extension FeedViewImpl: FeedListManagerDelegate {
    func didSelectPost(id: String) {
        presenter.didSelectPost(id: id)
    }
}
