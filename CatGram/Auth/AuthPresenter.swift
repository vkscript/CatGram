//
//  AuthPresenter.swift
//  CatGram
//

protocol AuthPresenter {
    func didLoad()
    func didTapLogin(email: String, password: String)
}

final class AuthPresenterImpl: AuthPresenter {

    private weak var view: AuthView?
    private let authService: AuthService
    private let router: AuthRouter

    init(
        view: AuthView,
        authService: AuthService,
        router: AuthRouter
    ) {
        self.view = view
        self.authService = authService
        self.router = router
    }

    func didLoad() {
        view?.render(.initial)
    }

    func didTapLogin(email: String, password: String) {
        view?.render(.loading)
        Task {
            do {
                _ = try await authService.login(
                    email: email,
                    password: password
                )
                await MainActor.run {
                    router.openMainScreen()
                    view?.render(.initial)
                }
            } catch {
                await MainActor.run {
                    view?.render(.error(message: "Invalid email or password"))
                }
            }
        }
    }
}
