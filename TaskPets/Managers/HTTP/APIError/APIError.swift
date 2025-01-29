
import Foundation

enum APIError: Error {
    case networkError(message: String)
    case decodingError(String)
}

//Typers of error
extension APIError {
    var displayMessage: String {
        switch self {
        case .networkError(let message):
            return message
        case .decodingError(let message):
           return message
        }
    }
}

