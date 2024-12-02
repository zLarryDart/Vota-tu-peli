import SwiftUI

struct ContentView: View {
    @StateObject private var presenter = MovieListPresenter()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Carrusel
                    if !presenter.movies.isEmpty {
                        TabView {
                            ForEach(presenter.movies.prefix(5)) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    ZStack(alignment: .bottomLeading) {
                                        AsyncImage(url: URL(string: movie.imageURL)) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(height: 300)
                                                .clipped()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                                            startPoint: .bottom,
                                            endPoint: .top
                                        )
                                        .frame(height: 100)
                                        Text(movie.title)
                                            .font(.title)
                                            .bold()
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .frame(height: 300)
                        .tabViewStyle(PageTabViewStyle())
                    }

                    // Lista
                    LazyVStack(spacing: 15) {
                        ForEach(presenter.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                HStack(spacing: 15) {
                                    AsyncImage(url: URL(string: movie.imageURL)) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 150)
                                            .cornerRadius(8)
                                    } placeholder: {
                                        ProgressView()
                                    }

                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(movie.title)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .lineLimit(2)
                                        Text("Rating: \(String(format: "%.1f", movie.rating)) ⭐️")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text(movie.description)
                                            .font(.footnote)
                                            .lineLimit(3)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Vota tu Peli")
            .onAppear {
                presenter.fetchMovies()
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
