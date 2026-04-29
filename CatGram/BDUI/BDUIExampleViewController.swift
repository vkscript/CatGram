//
//  BDUIExampleViewController.swift
//  CatGram
//

import UIKit

final class BDUIExampleViewController: UIViewController {
    
    private let tableView = UITableView()
    private let examples: [(title: String, json: String)] = [
        ("Простой экран", BDUIExamples.simpleScreenJSON),
        ("Карточка с изображением", BDUIExamples.cardWithImageJSON),
        ("Форма регистрации", BDUIExamples.formJSON),
        ("Загрузка", BDUIExamples.loadingStateJSON),
        ("Пустое состояние", BDUIExamples.emptyStateJSON),
        ("Ошибка", BDUIExamples.errorStateJSON)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "BDUI Примеры"
        view.backgroundColor = DS.Colors.background
        
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = DS.Colors.background
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension BDUIExampleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = examples[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = DS.Colors.background
        cell.textLabel?.textColor = DS.Colors.textPrimary
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let example = examples[indexPath.row]
        guard let component = BDUIExamples.decode(example.json) else {
            print("❌ Failed to decode JSON")
            return
        }
        
        let bduiVC = BDUIViewController(component: component)
        bduiVC.title = example.title
        navigationController?.pushViewController(bduiVC, animated: true)
    }
}
