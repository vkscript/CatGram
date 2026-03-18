//
//  NetworkError.swift
//  CatGram
//

enum NetworkError: Error, Equatable {
    case unreachable
    case badStatus(code: Int)
    case decodingFailed
    case unknown

    var userMessage: String {
        switch self {
        case .unreachable:
            return "Нет соединения с сервером. Проверьте интернет."
        case .badStatus(let code):
            return "Ошибка сервера (код \(code)). Попробуйте позже."
        case .decodingFailed:
            return "Не удалось обработать данные от сервера."
        case .unknown:
            return "Произошла неизвестная ошибка."
        }
    }
}
