import SwiftUI

struct MovieListView: View {
    @StateObject private var presenter = MovieListPresenter()

    var body: some View {
        NavigationView {
            List(presenter.movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    HStack {
                        AsyncImage(url: URL(string: movie.imageURL)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 75)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }

                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text("Rating: \(String(format: "%.1f", movie.rating))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Vota tu Peli")
            .onAppear {
                presenter.fetchMovies()
            }
        }
    }
}
