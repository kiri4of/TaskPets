import SwiftUI
import Kingfisher

struct BreedDetailView: View {
    
    let breed: BreedModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                //KFImage for image caching
                if let urlString = breed.imageURL, let url = URL(string: urlString) {
                    KFImage(url)
                        .resizable()
                        .placeholder {
                            ProgressView()
                                .frame(maxWidth: .infinity, minHeight: 200)
                        }
                        .cancelOnDisappear(true) //cancel the download if view disappears
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                } else {
                    //if no url
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .foregroundColor(.gray)
                }
                
                Text(breed.name)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
                if let description = breed.description {
                    Text(description)
                        .font(.body)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(breed.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BreedDetailView(breed: BreedModel(id: "test", name: "Abyssinian", description: "A very cool story about cat", reference_image_id: "0XYvRd7oD"))
}
