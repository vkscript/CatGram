//
//  DSButton.swift
//  CatGram
//

import UIKit

final class DSButton: UIButton {
    
    enum Style {
        case primary
        case secondary
        case destructive
        case text
    }
    
    private let style: Style
    private var isLoading = false
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    init(style: Style, title: String? = nil) {
        self.style = style
        super.init(frame: .zero)
        setupButton()
        if let title = title {
            setTitle(title, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        // Базовая настройка
        layer.cornerRadius = DS.Spacing.cornerRadiusMedium
        titleLabel?.font = DS.Typography.headline()
        
        // Индикатор загрузки
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalToConstant: DS.Spacing.buttonHeight)
        ])
        
        // Применяем стиль
        applyStyle()
        
        // Анимация нажатия
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    private func applyStyle() {
        switch style {
        case .primary:
            backgroundColor = DS.Colors.primary
            setTitleColor(.white, for: .normal)
            setTitleColor(.white.withAlphaComponent(0.5), for: .disabled)
            layer.shadowColor = DS.Colors.primary.cgColor
            layer.shadowOpacity = 0.3
            layer.shadowOffset = CGSize(width: 0, height: 4)
            layer.shadowRadius = 8
            
        case .secondary:
            backgroundColor = DS.Colors.secondaryBackground
            setTitleColor(DS.Colors.primary, for: .normal)
            setTitleColor(DS.Colors.textSecondary, for: .disabled)
            layer.borderWidth = 1
            layer.borderColor = DS.Colors.border.cgColor
            
        case .destructive:
            backgroundColor = DS.Colors.error
            setTitleColor(.white, for: .normal)
            setTitleColor(.white.withAlphaComponent(0.5), for: .disabled)
            
        case .text:
            backgroundColor = .clear
            setTitleColor(DS.Colors.primary, for: .normal)
            setTitleColor(DS.Colors.textSecondary, for: .disabled)
            layer.cornerRadius = 0
        }
        
        activityIndicator.color = style == .secondary ? DS.Colors.primary : .white
    }
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.6
        }
    }
    
    // MARK: - Loading State
    func setLoading(_ loading: Bool) {
        isLoading = loading
        isEnabled = !loading
        
        if loading {
            titleLabel?.alpha = 0
            activityIndicator.startAnimating()
        } else {
            titleLabel?.alpha = 1
            activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Animation
    @objc private func touchDown() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc private func touchUp() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }
}
