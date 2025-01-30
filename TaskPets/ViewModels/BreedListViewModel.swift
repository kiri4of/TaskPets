
import Foundation

@MainActor
class BreedListViewModel: ObservableObject {
    
    @Published var breeds: [BreedModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiManager: APIManagerProtocol
    
    //pagination
    private let limit = 12 //cells with cat limit
    private var currentPage = 0
    var canLoadMore = true
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
        Task {
            await fetchNextPage()
        }
    }
    //Fetching data
    func fetchNextPage() async {
        //not fetching and not last page
        guard canLoadMore, !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            //request current page
            let rawBreeds = try await apiManager.fetchBreeds(limit: limit, page: currentPage)
            
            //if less then limit => no more data
            if rawBreeds.count < limit {
                canLoadMore = false
            }
            
            var updatedBreeds = rawBreeds //copy arr that we gonna change
            
            
            //Creating task group that return Tuple(String,String?) where (breed id, image url or nil)
            try await withThrowingTaskGroup(of: (String,String?).self) { group in
                for breed in rawBreeds {
                    // if we have an id
                    if let refId = breed.reference_image_id, !refId.isEmpty {
                        //add concrurrent task
                        group.addTask {
                            do {
                                let catImage = try await self.apiManager.fetchImageById(refId)
                                return (breed.id, catImage.url)
                            } catch {
                                print("Failed to load image from breed \(breed.id): \(error)")
                                return (breed.id, nil)
                            }
                        }
                    }
                }
                //Asynchronously wait for all tasks to complete and collect results
                for try await (breedId, imageUrl) in group {
                    //searching breed in updatedBreeds
                    if let index = updatedBreeds.firstIndex(where: { $0.id == breedId }) {
                        updatedBreeds[index].imageURL = imageUrl
                    }
                }
            }
            //append new breeds to general array
            self.breeds += updatedBreeds
            //increase page
            currentPage += 1
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false 
    }
}
