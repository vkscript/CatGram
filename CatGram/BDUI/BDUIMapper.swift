//
//  BDUIMapper.swift
//  CatGram
//

import UIKit

protocol BDUIMapper {
    func map(_ component: BDUIComponent) -> UIView
    func setActionHandler(_ handler: @escaping (BDUIAction) -> Void)
}

final class BDUIMapperImpl: BDUIMapper {
    
    private var actionHandler: ((BDUIAction) -> Void)?
    private var componentRegistry: [String: UIView] = [:]
    
    func setActionHandler(_ handler: @escaping (BDUIAction) -> Void) {
        self.actionHandler = handler
    }
    
    func map(_ component: BDUIComponent) -> UIView {
        let view = createView(for: component)
        
        if let id = component.id {
            componentRegistry[id] = view
        }

        applyCommonProperties(to: view, content: component.content)
        
        if let constraints = component.constraints {
            applyConstraints(to: view, constraints: constraints)
        }
        
        if let subviews = component.subviews {
            addSubviews(to: view, components: subviews, parentType: component.type)
        }
        
        return view
    }
    
    private func createView(for component: BDUIComponent) -> UIView {
        switch component.type {
        case .contentView:
            return createContentView(content: component.content)
        case .stackView:
            return createStackView(content: component.content)
        case .scrollView:
            return createScrollView(content: component.content)
        case .label:
            return createLabel(content: component.content)
        case .button:
            return createButton(content: component.content)
        case .textField:
            return createTextField(content: component.content)
        case .imageView:
            return createImageView(content: component.content)
        case .spacer:
            return createSpacer(content: component.content)
        case .divider:
            return createDivider(content: component.content)
        case .card:
            return createCard(content: component.content)
        case .loadingView:
            return createLoadingView(content: component.content)
        case .emptyView:
            return createEmptyView(content: component.content)
        case .errorView:
            return createErrorView(content: component.content)
        }
    }
    
    // MARK: - View Creators
    
    private func createContentView(content: BDUIComponent.BDUIContent) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func createStackView(content: BDUIComponent.BDUIContent) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = content.axis?.nsLayoutAxis ?? .vertical
        stackView.spacing = content.spacing?.value ?? DS.Spacing.m
        stackView.alignment = content.alignment?.stackAlignment ?? .fill
        stackView.distribution = content.distribution?.stackDistribution ?? .fill
        return stackView
    }
    
    private func createScrollView(content: BDUIComponent.BDUIContent) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
    
    private func createLabel(content: BDUIComponent.BDUIContent) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = content.text
        label.font = content.font?.font ?? DS.Typography.body()
        label.textColor = content.textColor?.uiColor ?? DS.Colors.textPrimary
        label.textAlignment = content.textAlignment?.textAlignment ?? .natural
        label.numberOfLines = content.numberOfLines ?? 1
        return label
    }
    
    private func createButton(content: BDUIComponent.BDUIContent) -> DSButton {
        let style = content.buttonStyle?.dsStyle ?? .primary
        let button = DSButton(style: style, title: content.title)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let action = content.action {
            button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
            objc_setAssociatedObject(button, &actionKey, action, .OBJC_ASSOCIATION_RETAIN)
        }
        
        return button
    }
    
    private func createTextField(content: BDUIComponent.BDUIContent) -> DSTextField {
        let textField = DSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = content.placeholder
        textField.title = content.fieldTitle
        textField.isSecure = content.isSecure ?? false
        
        if let keyboardType = content.keyboardType {
            switch keyboardType {
            case "email": textField.keyboardType = .emailAddress
            case "number": textField.keyboardType = .numberPad
            case "phone": textField.keyboardType = .phonePad
            case "url": textField.keyboardType = .URL
            default: textField.keyboardType = .default
            }
        }
        
        return textField
    }
    
    private func createImageView(content: BDUIComponent.BDUIContent) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = content.contentMode?.uiContentMode ?? .scaleAspectFit
        imageView.clipsToBounds = true
        
        if let systemImage = content.systemImage {
            imageView.image = UIImage(systemName: systemImage)
            imageView.tintColor = content.tintColor?.uiColor ?? DS.Colors.textSecondary
        } else if let imageUrl = content.imageUrl, let url = URL(string: imageUrl) {
            loadImage(into: imageView, from: url)
        }
        
        return imageView
    }
    
    private func createSpacer(content: BDUIComponent.BDUIContent) -> UIView {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.backgroundColor = .clear
        
        let size = content.spacerSize?.value ?? DS.Spacing.m
        spacer.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        return spacer
    }
    
    private func createDivider(content: BDUIComponent.BDUIContent) -> UIView {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = content.backgroundColor?.uiColor ?? DS.Colors.separator
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return divider
    }
    
    private func createCard(content: BDUIComponent.BDUIContent) -> UIView {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = content.backgroundColor?.uiColor ?? DS.Colors.secondaryBackground
        card.layer.cornerRadius = content.cornerRadius?.value ?? DS.Spacing.cornerRadiusMedium
        
        if content.hasShadow == true {
            card.layer.shadowColor = UIColor.black.cgColor
            card.layer.shadowOpacity = 0.1
            card.layer.shadowOffset = CGSize(width: 0, height: 2)
            card.layer.shadowRadius = 8
        }
        
        return card
    }
    
    private func createLoadingView(content: BDUIComponent.BDUIContent) -> DSLoadingView {
        let message = content.message ?? "Загрузка..."
        let loadingView = DSLoadingView(message: message)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }
    
    private func createEmptyView(content: BDUIComponent.BDUIContent) -> DSEmptyView {
        let title = content.title ?? "Пусто"
        let message = content.message ?? ""
        let icon: UIImage? = content.icon != nil ? UIImage(systemName: content.icon!) : nil
        let emptyView = DSEmptyView(title: title, message: message, icon: icon)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }
    
    private func createErrorView(content: BDUIComponent.BDUIContent) -> DSErrorView {
        let message = content.message ?? "Произошла ошибка"
        let showRetry = content.showRetryButton ?? true
        let errorView = DSErrorView(message: message, showRetryButton: showRetry)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        if let action = content.action {
            errorView.onRetry = { [weak self] in
                self?.actionHandler?(action)
            }
        }
        
        return errorView
    }
    
    // MARK: - Property Application
    
    private func applyCommonProperties(to view: UIView, content: BDUIComponent.BDUIContent) {
        if let backgroundColor = content.backgroundColor {
            view.backgroundColor = backgroundColor.uiColor
        }
        
        if let cornerRadius = content.cornerRadius {
            view.layer.cornerRadius = cornerRadius.value
        } else if let customRadius = content.customCornerRadius {
            view.layer.cornerRadius = CGFloat(customRadius)
        }
        
        if let isHidden = content.isHidden {
            view.isHidden = isHidden
        }
        
        if let alpha = content.alpha {
            view.alpha = CGFloat(alpha)
        }
    }
    
    private func applyConstraints(to view: UIView, constraints: BDUIComponent.BDUIConstraints) {
        if let width = constraints.width {
            view.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        }
        
        if let height = constraints.height {
            view.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        }
        
        if let aspectRatio = constraints.aspectRatio {
            view.widthAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: CGFloat(aspectRatio)
            ).isActive = true
        }
    }
    
    private func addSubviews(to view: UIView, components: [BDUIComponent], parentType: BDUIComponentType) {
        for component in components {
            let subview = map(component)
            
            if let stackView = view as? UIStackView {
                stackView.addArrangedSubview(subview)
            } else if let scrollView = view as? UIScrollView {
                scrollView.addSubview(subview)
                // Для scrollView нужно установить constraints для content
                NSLayoutConstraint.activate([
                    subview.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    subview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    subview.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                    subview.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                    subview.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                ])
            } else {
                view.addSubview(subview)
                // Для обычных view, если не заданы constraints, растягиваем на всю область
                if component.constraints == nil {
                    NSLayoutConstraint.activate([
                        subview.topAnchor.constraint(equalTo: view.topAnchor),
                        subview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        subview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        subview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                    ])
                }
            }
        }
    }
    
    // MARK: - Image Loading
    
    private func loadImage(into imageView: UIImageView, from url: URL) {
        if let cachedImage = ImageCache.shared.image(for: url) {
            imageView.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            ImageCache.shared.setImage(image, for: url)
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
    
    // MARK: - Action Handling
    
    @objc private func handleButtonTap(_ sender: DSButton) {
        if let action = objc_getAssociatedObject(sender, &actionKey) as? BDUIAction {
            actionHandler?(action)
        }
    }
}

// Associated object key for storing BDUIAction in buttons
private var actionKey: UInt8 = 0
