//
//  DSLoadingView.swift
//  CatGram
//

import UIKit

final class DSLoadingView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = DS.Colors.primary
        return indicator
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = DS.Typography.body()
        label.textColor = DS.Colors.textSecondary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    init(message: String = "Загрузка...") {
        super.init(frame: .zero)
        messageLabel.text = message
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = DS.Colors.background
        
        [activityIndicator, messageLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            
            messageLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: DS.Spacing.m),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DS.Spacing.l),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DS.Spacing.l)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func updateMessage(_ message: String) {
        messageLabel.text = message
    }
}
