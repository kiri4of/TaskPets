
import SwiftUI

struct BreedCellView: View {
    
    let breed: BreedModel
    
    var body: some View {
        VStack {
            //Image (if not nil)
            if let urlString = breed.image?.url, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 80, height: 80)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipped()
                    case .failure:
                        //if there no image
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                   @unknown default:
                        EmptyView()
                    }
                }
            } else {
                //No url
                Image(systemName: "photo.on.rectangle.angled")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
            }
            
            Text(breed.name)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
    
        }
        .padding(5)
        .background(Color(white: 0.95))
        .cornerRadius(8)
    }
}

#Preview {
    BreedCellView(
        breed: BreedModel(
            id: "test",
            name: "Test Cat",
            description: "test desc",
            image: BreedImage(id: nil, url: nil, width: nil, height: nil)
        )
    )
    .previewLayout(.sizeThatFits)
}
