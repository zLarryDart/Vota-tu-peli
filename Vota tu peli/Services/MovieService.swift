import Foundation

class MovieService {
    private let apiKey = "f60a384ebe8982a9772e0890e9d4c4f2"
    private let baseURL = "https://api.themoviedb.org/3/movie/popular"
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500"

    func fetchMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?api_key=\(apiKey)&language=en-US&page=1") else {
            completion(.failure(NSError(domain: "URL Error", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                print("Error en la solicitud: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                print("Error: No se recibieron datos.")
                return
            }

            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                let movies = response.results.map { result in
                    MovieModel(
                        title: result.title,
                        rating: result.vote_average,
                        description: result.overview,
                        imageURL: "\(self.imageBaseURL)\(result.poster_path)"
                    )
                }
                completion(.success(movies))
            } catch {
                print("Error al decodificar JSON: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
