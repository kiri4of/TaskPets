
import Foundation
import Alamofire

protocol APIManagerProtocol {
    func fetchBreeds(limit: Int) async throws -> [BreedModel]
    func fetchImageById(_ id: String) async throws -> CatImage
}

final class APIManager: APIManagerProtocol {
    //fetching breeds
    func fetchBreeds(limit: Int) async throws -> [BreedModel] {
        let endPoint = CatEndpoint.getBreeds(limit: limit)
        //request from Endpoint
        guard let request = endPoint.urlRequest else {
            throw APIError.networkError(message: "Failed to create URLRequest for breeds")
        }
        //API response
        let response = try await AF.request(request)
            .validate(statusCode: 200..<300) //statusCode validation 
            .serializingData()
            .response
        
        //cheking for error
        switch response.result {
        case .success(let rawData):
            do {
                //return breeds array
                let breeds = try JSONDecoder().decode([BreedModel].self, from: rawData)
                return breeds
            } catch {
                let text = String(data: rawData, encoding: .utf8) ?? nil
                print("Raw response (breed) was: \(String(describing: text))")
                throw APIError.decodingError("Failed to decode :\(error)")
            }
        case .failure(let error):
            throw APIError.networkError(message: error.localizedDescription)
        }
    }
    
    func fetchImageById(_ id: String) async throws -> CatImage {
        let endPoint = CatEndpoint.getImage(id)
        //request from Endpoint
        guard let request = endPoint.urlRequest else {
            throw APIError.networkError(message: "Failed to create URLRequest for iamge")
        }
        
        let response = try await AF.request(request)
            .validate(statusCode: 200..<300) //statusCode validation
            .serializingData()
            .response
        
        //cheking for error
        switch response.result {
        case .success(let rawData):
            do {
                //return image
                let catImage = try JSONDecoder().decode(CatImage.self, from: rawData)
                return catImage
            } catch {
                let text = String(data: rawData, encoding: .utf8) ?? nil
                print("Raw response (catImage) was: \(String(describing: text))")
                throw APIError.decodingError("Failed to decode")
            }
        case .failure(let error):
            throw APIError.networkError(message: error.localizedDescription)
        }
    }
    
}

