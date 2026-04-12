//
//  DSTextField.swift
//  CatGram
//

import UIKit

final class DSTextField: UIView {
    
    enum ValidationState {
        case normal
        case error(message: String)
        case success
    }
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = DS.Typography.footnote()
        label.textColor = DS.Colors.textSecondary
        return label
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.font = DS.Typography.body()
        tf.textColor = DS.Colors.textPrimary
        tf.tintColor = DS.Colors.primary
        return tf
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = DS.Colors.secondaryBackground
        view.layer.cornerRadius = DS.Spacing.cornerRadiusMedium
        view.layer.borderWidth = 1
        view.layer.borderColor = DS.Colors.border.cgColor
        return view
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = DS.Typography.caption1()
        label.textColor = DS.Colors.error
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = DS.Colors.textSecondary
        return iv
    }()
    
    // MARK: - Properties
    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
            titleLabel.isHidden = title == nil
        }
    }
    
    var isSecure: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecure
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType = .sentences {
        didSet {
            textField.autocapitalizationType = autocapitalizationType
        }
    }
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        [titleLabel, containerView, errorLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        [iconImageView, textField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DS.Spacing.xs),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DS.Spacing.xs),
            
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DS.Spacing.xs),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: DS.Spacing.textFieldHeight),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: DS.Spacing.m),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: DS.Spacing.s),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -DS.Spacing.m),
            textField.topAnchor.constraint(equalTo: containerView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: DS.Spacing.xs),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DS.Spacing.xs),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DS.Spacing.xs),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        iconImageView.isHidden = true
    }
    
    // MARK: - Public Methods
    func setIcon(_ image: UIImage?) {
        iconImageView.image = image
        iconImageView.isHidden = image == nil
        
        // Обновляем constraints для textField
        textField.leadingAnchor.constraint(
            equalTo: image == nil ? containerView.leadingAnchor : iconImageView.trailingAnchor,
            constant: DS.Spacing.m
        ).isActive = true
    }
    
    func setValidationState(_ state: ValidationState) {
        switch state {
        case .normal:
            containerView.layer.borderColor = DS.Colors.border.cgColor
            errorLabel.isHidden = true
            iconImageView.tintColor = DS.Colors.textSecondary
            
        case .error(let message):
            containerView.layer.borderColor = DS.Colors.error.cgColor
            errorLabel.text = message
            errorLabel.isHidden = false
            iconImageView.tintColor = DS.Colors.error
            
            // Анимация "тряски"
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            animation.duration = 0.4
            animation.values = [-10, 10, -8, 8, -5, 5, 0]
            containerView.layer.add(animation, forKey: "shake")
            
        case .success:
            containerView.layer.borderColor = DS.Colors.success.cgColor
            errorLabel.isHidden = true
            iconImageView.tintColor = DS.Colors.success
        }
    }
}
