
import Foundation

@MainActor
class BreedListViewModel: ObservableObject {
    
    @Published var breeds: [BreedModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
        Task {
            await fetchBreeds()
        }
    }
    //Fetching data
    func fetchBreeds() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let data = try await apiManager.makeRequest(for: CatEndpoint.getBreeds)
            breeds = data
        } catch let apiError as APIError {
            //custom APIError
            errorMessage = apiError.displayMessage
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
