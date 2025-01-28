import SwiftUI

struct BreedListView: View {
    
    @StateObject var viewModel: BreedListViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            NavigationStack {
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading Breeds")
                    } else if let error = viewModel.errorMessage {
                        Text("Error: \(error)")
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(viewModel.breeds) { breed in
//                                    NavigationLink(value: breed) {
//                                        BreedCellView(breed: breed)
//                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .navigationTitle("Cat Breeds")
                //destination
            }
        }
        .padding()
    }
}

#Preview {
    BreedListView(viewModel: BreedListViewModel())
}

