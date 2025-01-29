
import Kingfisher
import SwiftUI



@main
struct TaskPetsApp: App {
    
    init() {
        confgigurateKingFisherCache()
    }
    
    var body: some Scene {
        WindowGroup {
            BreedListView(viewModel: BreedListViewModel())
                .preferredColorScheme(.light)
        }
    }
    
    //cache setup (only 1 small func, thats why it here)
    func confgigurateKingFisherCache() {
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024 // 100mb
        cache.diskStorage.config.sizeLimit = 500 * 1024 * 1024 // 500mb
    }
}
