//
//  DSErrorView.swift
//  CatGram
//

import UIKit

final class DSErrorView: UIView {
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "exclamationmark.triangle.fill")
        iv.tintColor = DS.Colors.error
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = DS.Typography.title3()
        label.textColor = DS.Colors.textPrimary
        label.textAlignment = .center
        label.text = "Что-то пошло не так"
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = DS.Typography.body()
        label.textColor = DS.Colors.textSecondary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let retryButton = DSButton(style: .primary, title: "Повторить")
    
    var onRetry: (() -> Void)?
    
    init(message: String, showRetryButton: Bool = true) {
        super.init(frame: .zero)
        messageLabel.text = message
        retryButton.isHidden = !showRetryButton
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = DS.Colors.background
        
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView,
            titleLabel,
            messageLabel,
            retryButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = DS.Spacing.m
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            
            retryButton.widthAnchor.constraint(equalToConstant: 200),
            
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: DS.Spacing.l),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -DS.Spacing.l)
        ])
        
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
    }
    
    @objc private func retryTapped() {
        onRetry?()
    }
    
    func updateMessage(_ message: String) {
        messageLabel.text = message
    }
}
