//
//  DummyAuthService.swift
//  CatGram
//

final class DummyAuthService: AuthService {

    func login(email: String, password: String) async throws -> UserSession {

        // WHY nanoseconds?
        try await Task.sleep(nanoseconds: 1_000_000_000)

        if email == "alfa@itmo.ru", password == "student" {
            return UserSession(token: "token", userId: "42")
        }

        throw AuthError.invalidCredentials
    }
}

enum AuthError: Error {
    case invalidCredentials
}
