
import Foundation

struct BreedModel: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String?
    let image: BreedImage?
    
}

struct BreedImage: Decodable {
    let id: String?
    let url: String?
    let width: Int?
    let height: Int?
}
