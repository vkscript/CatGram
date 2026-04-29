//
//  BDUIViewController.swift
//  CatGram
//

import UIKit

final class BDUIViewController: UIViewController {
    
    private let mapper: BDUIMapper
    private let component: BDUIComponent
    private let actionHandler = BDUIActionHandler()
    
    init(component: BDUIComponent, mapper: BDUIMapper = BDUIMapperImpl()) {
        self.component = component
        self.mapper = mapper
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionHandler.delegate = self
        mapper.setActionHandler { [weak self] action in
            self?.actionHandler.handle(action)
        }
        
        setupView()
    }
    
    private func setupView() {
        let rootView = mapper.map(component)
        view.addSubview(rootView)
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension BDUIViewController: BDUIActionHandlerDelegate {
    func handleNavigation(to route: String, with params: [String : String]?) {
        print("📱 Navigate to: \(route), params: \(params ?? [:])")
        // Здесь можно добавить реальную навигацию через Router
    }
    
    func handleReload() {
        print("📱 Reload screen")
        // Перезагрузка экрана
        setupView()
    }
    
    func handleDismiss() {
        print("📱 Dismiss screen")
        dismiss(animated: true)
    }
}
