import Foundation
import Alamofire

enum CatEndpoint: Endpoint {
    case getBreeds
    
    var baseURL: URL {
        return URL(string: "https://api.thecatapi.com")!
    }
    
    var path: String {
        switch self {
        case .getBreeds:
            return "/v1/breeds"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        //APIkey
        return ["x-api-key": "apiKey"]
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}
