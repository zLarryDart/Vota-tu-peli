import SwiftUI

struct MovieDetailView: View {
    let movie: MovieModel

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: movie.imageURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 400)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }

                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 150)

                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                    .padding(.horizontal)
            }

            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Rating:")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("\(String(format: "%.1f", movie.rating)) ⭐️")
                        .font(.headline)
                        .foregroundColor(.yellow)
                }

                Text(movie.description)
                    .font(.body)
                    .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
        }
        .modifier(NavigationBarModifier(backgroundColor: .black, foregroundColor: .white))
        .navigationBarTitleDisplayMode(.inline)
    }
}
