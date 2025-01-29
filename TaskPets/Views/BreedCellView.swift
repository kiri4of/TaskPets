
import SwiftUI
import Kingfisher

struct BreedCellView: View {
    
    let breed: BreedModel
    
    var body: some View {
        VStack(spacing: 8){
            //Image (if not nil)
            //KFImage for image caching
            if let urlString = breed.imageURL, let url = URL(string: urlString) {
               KFImage(url)
                    .placeholder {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }
                    //cancel download if user left the screen
                    .cancelOnDisappear(true)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipped()
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
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.5) //decrease text size of needed
                .frame(maxWidth: .infinity, minHeight: 40)
    
        }
        .padding(5)
        .frame(width: 110, height: 150)
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
            reference_image_id: "ozEvzdVM-",
            imageURL: "https://cdn2.thecatapi.com/images/ozEvzdVM-.jpg")
    )
    .previewLayout(.sizeThatFits)
}
