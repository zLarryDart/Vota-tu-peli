import Foundation

class MovieListPresenter: ObservableObject {
    @Published var movies: [MovieModel] = []
    private let movieService = MovieService()

    func fetchMovies() {
        movieService.fetchMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    print("Error al cargar las películas: \(error.localizedDescription)")
                }
            }
        }
    }
}
