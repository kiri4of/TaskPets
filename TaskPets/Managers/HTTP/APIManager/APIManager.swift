
import Foundation
import Alamofire

protocol APIManagerProtocol {
    func makeRequest(for endPoint: Endpoint) async throws -> [BreedModel]
}

final class APIManager: APIManagerProtocol {
    func makeRequest(for endPoint: Endpoint) async throws -> [BreedModel] {
        //request from Endpoint
        guard let request = endPoint.urlRequest else {
            throw APIError.networkError(message: "Failed to create URLRequest")
        }
        
        //make request via networkManager
        let data = try await AF.request(request)
            .serializingDecodable([BreedModel].self).value
        
        return data
    }
    
}

