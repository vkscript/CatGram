//
//  AuthView.swift
//  CatGram
//

import UIKit

protocol AuthView: AnyObject {
    func render(_ state: AuthViewState)
}

final class AuthViewImpl: UIViewController, UITextFieldDelegate, AuthView {

    var presenter: AuthPresenter!

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let emailField = DSTextField()
    private let passwordField = DSTextField()
    private let loginButton = DSButton(style: .primary, title: "Войти")
    
    func setupUI() {
        view.backgroundColor = DS.Colors.background

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [logoImage, emailField, passwordField, loginButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        // Настройка полей
        emailField.title = "Электронная почта"
        emailField.placeholder = "example@mail.com"
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.textField.returnKeyType = .next
        emailField.textField.delegate = self
        emailField.setIcon(UIImage(systemName: "envelope.fill"))
        
        passwordField.title = "Пароль"
        passwordField.placeholder = "Введите пароль"
        passwordField.isSecure = true
        passwordField.textField.returnKeyType = .go
        passwordField.textField.delegate = self
        passwordField.setIcon(UIImage(systemName: "lock.fill"))

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: DS.Spacing.xxl),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200),

            emailField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: DS.Spacing.xxl),
            emailField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DS.Spacing.l),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DS.Spacing.l),

            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: DS.Spacing.m),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),

            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: DS.Spacing.l),
            loginButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -DS.Spacing.l)
        ])

        loginButton.addTarget(
            self,
            action: #selector(loginTapped),
            for: .touchUpInside
        )
        
        emailField.textField.addTarget(
            self,
            action: #selector(emailChanged),
            for: .editingDidEnd
        )
    }
    
    func setupKeyboard() {
        emailField.textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField.textField {
            passwordField.textField.becomeFirstResponder()
        } else if textField == passwordField.textField {
            loginTapped()
        }
        return true
    }

    @objc
    func loginTapped() {
        presenter.didTapLogin(
            email: emailField.text ?? "",
            password: passwordField.text ?? ""
        )
    }
    
    @objc
    private func emailChanged() {
        let email = emailField.text ?? ""
        if !email.isEmpty {
            if isValidEmail(email) {
                emailField.setValidationState(.success)
            } else {
                emailField.setValidationState(.error(message: "Неверный формат email"))
            }
        } else {
            emailField.setValidationState(.normal)
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^\S+@\S+\.\S+$"#
        return NSPredicate(
            format: "SELF MATCHES %@",
            pattern
        ).evaluate(with: email)
    }
    
    private func startLogoAnimation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = 0.5
        rotation.repeatCount = .infinity
        logoImage.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    private func stopLogoAnimation() {
        logoImage.layer.removeAnimation(forKey: "rotationAnimation")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboard()
        presenter.didLoad()
    }
    
    func render(_ state: AuthViewState) {
        switch state {
        case .initial:
            loginButton.setLoading(false)
            stopLogoAnimation()
        case .loading:
            loginButton.setLoading(true)
            startLogoAnimation()
        case .error(let message):
            loginButton.setLoading(false)
            stopLogoAnimation()
            let alert = UIAlertController(
                title: "Ошибка",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
