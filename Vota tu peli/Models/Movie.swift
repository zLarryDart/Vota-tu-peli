import Foundation

struct MovieModel: Identifiable {
    let id = UUID() // Usamos un UUID porque la API no devuelve un ID único en el JSON.
    let title: String
    let rating: Double
    let description: String
    let imageURL: String
}

// Estructuras para decodificar directamente el JSON
struct MovieResponse: Codable {
    let results: [MovieResult]
}

struct MovieResult: Codable {
    let title: String
    let vote_average: Double
    let overview: String
    let poster_path: String
}
