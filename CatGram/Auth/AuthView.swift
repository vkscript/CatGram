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

    private let emailField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Почта"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let emailErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    private let passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Пароль"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        return tf
    }()

    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Войти", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return btn
    }()

    private let activity = UIActivityIndicatorView(style: .medium)
    
    func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [logoImage, emailField, emailErrorLabel, passwordField, loginButton, activity].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200),

            emailField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            emailField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            emailErrorLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 4),
            emailErrorLabel.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            emailErrorLabel.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),

            passwordField.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 12),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),

            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24),
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            activity.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            activity.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activity.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        loginButton.addTarget(
            self,
            action: #selector(loginTapped),
            for: .touchUpInside
        )
        
        emailField.addTarget(
            self,
            action: #selector(emailChanged),
            for: .editingChanged
        )
    }
    
    func setupKeyboard() {
        emailField.delegate = self
        passwordField.delegate = self
        emailField.returnKeyType = .next
        passwordField.returnKeyType = .go
        
        emailField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
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
        if isValidEmail(email) {
            showEmailValidState()
        } else {
            showEmailInvalidState()
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^\S+@\S+\.\S+$"#
        return NSPredicate(
            format: "SELF MATCHES %@",
            pattern
        ).evaluate(with: email)
    }
    
    private func showEmailValidState() {
        emailField.layer.borderWidth = 0
        emailErrorLabel.isHidden = true
    }
    
    private func showEmailInvalidState() {
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.systemRed.cgColor
        emailErrorLabel.text = "Invalid email format"
        emailErrorLabel.isHidden = false
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
            activity.stopAnimating()
            loginButton.isEnabled = true
            stopLogoAnimation()
        case .loading:
            activity.startAnimating()
            loginButton.isEnabled = false
            startLogoAnimation()
        case .error(let message):
            activity.stopAnimating()
            loginButton.isEnabled = true
            stopLogoAnimation()
            let alert = UIAlertController(
                title: "Error",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
