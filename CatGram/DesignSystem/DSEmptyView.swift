//
//  DSEmptyView.swift
//  CatGram
//

import UIKit

final class DSEmptyView: UIView {
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "tray.fill")
        iv.tintColor = DS.Colors.textTertiary
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = DS.Typography.title3()
        label.textColor = DS.Colors.textPrimary
        label.textAlignment = .center
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
    
    init(title: String, message: String, icon: UIImage? = nil) {
        super.init(frame: .zero)
        titleLabel.text = title
        messageLabel.text = message
        if let icon = icon {
            iconImageView.image = icon
        }
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
            messageLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = DS.Spacing.m
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: DS.Spacing.l),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -DS.Spacing.l)
        ])
    }
}
