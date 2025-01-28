
import Foundation

enum APIError: Error {
    case clientError(String)
    case serverError(String)
    case unknownError(String)
    case networkError(message: String)
}

//Typers of error
extension APIError {
    var displayMessage: String {
        switch self {
        case .clientError(let message):
            return message
        case .serverError(let message):
            return message
        case .unknownError(let message):
            return message
        case .networkError(let message):
            return message
        }
    }
}

