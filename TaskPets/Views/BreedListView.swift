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
                    if viewModel.isLoading && viewModel.breeds.isEmpty{
                        ProgressView("Loading Breeds")
                    } else if let error = viewModel.errorMessage {
                        Text("Error: \(error)")
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(viewModel.breeds) { breed in
                                    NavigationLink(value: breed) {
                                        BreedCellView(breed: breed)
                                        .frame(width: 110, height: 150)
                                        .onAppear {
                                            if breed == viewModel.breeds.last {
                                                Task {
                                                    await viewModel.fetchNextPage()
                                                }
                                            }
                                        }
                                    }
                                }
                                if viewModel.isLoading {
                                    ProgressView()
                                        .frame(height: 50)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                .navigationTitle("Cat Breeds")
                .navigationDestination(for: BreedModel.self) { breed in
                    BreedDetailView(breed: breed)
                }

            }
        }
        .padding()
    }
    
}

#Preview {
    BreedListView(viewModel: BreedListViewModel())
}

