//
//  FavoriteMoviesViewModel.swift
//  TMDB App
//
//  Created by Aleksandar Milidrag on 12/23/23.
//

import Foundation

@MainActor
class FavoriteMoviesViewModel: ObservableObject {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    var page = 1
    
    @Published var favoriteMovies: [Movie] = []
    
    
    func fetchFavoriteMovies() async throws {
        let resource =  Resource(url: Constants.Urls.favoriteMovies, method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef"), URLQueryItem(name: "session_id", value: "954a0e7f7e9c282ade3daaab053db4e20c870209"),URLQueryItem(name: "page", value: String(page)),URLQueryItem(name: "language", value: "en-US"),URLQueryItem(name: "sort_by", value: "created_at.desc")]), modelType: MovieResponse.self)
        
        let favoriteResults = try await httpClient.load(resource)
         favoriteMovies = favoriteResults.results
    }
    
    func loadFavoriteMovies() async {
        do {
            try await fetchFavoriteMovies()
        } catch {
            print(error)
        }
    }
}
