import Foundation
import Alamofire

enum CatEndpoint: Endpoint {
    case getBreeds(limit: Int)
    case getImage(String) //reference_image_ids

    
    var baseURL: URL {
        return URL(string: "https://api.thecatapi.com/v1")!
    }
    
    var path: String {
        switch self {
        case .getBreeds:
            return "breeds"
        case .getImage(let referenceId):
            return "images/\(referenceId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return ["x-api-key": "live_2Fy06qOv4GECl8r516tvgsWpvKCnj2xXtHrH7r2fwDUGoDJYJC7viDbJO2EXTIwF"]
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getBreeds(let limit):
            return ["limit": limit]
        case .getImage:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}
