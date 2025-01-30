
import Foundation

struct BreedModel: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String?
    let reference_image_id: String?
    
    var imageURL: String?
}

struct CatImage: Decodable, Hashable {
    let id: String?
    let width: Int?
    let height: Int?
    let url: String?
}

