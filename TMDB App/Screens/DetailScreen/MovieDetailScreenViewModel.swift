//
//  MovieDetailScreenViewModel.swift
//  TMDB App
//
//  Created by Aleksandar Milidrag on 12/17/23.
//

import Foundation


@MainActor
final class MovieDetailScreenViewModel: ObservableObject {
    
    let httpClient: HTTPClient
    
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    
    @Published var isLoading: Bool = false
    @Published var movie: SingleMovieResponse? = nil
    
    
    func fetchSingleMovie(movieId: Int) async throws {
        let resource = Resource(url: Constants.Urls.singleMovie(movieId: movieId), method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef"), URLQueryItem(name: "append_to_response", value: "videos,credits")]), modelType: SingleMovieResponse.self)
        
        movie = try await httpClient.load(resource)
    }
    func loadMoviebyId(movieId: Int) async {
        self.isLoading = true
        do {
            try await self.fetchSingleMovie(movieId: movieId)
            self.isLoading = false
        } catch {
            print(error)
        }
    }
    
    func postToFavorites(movieId: Int) async throws {
        
        let data = FavoriteRequestDTO(mediaID: movieId)
        
        let resource = try Resource(url: Constants.Urls.postToFavorites, method: .post(JSONEncoder().encode(data), [URLQueryItem(name: "session_id", value: "954a0e7f7e9c282ade3daaab053db4e20c870209"), URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef")]), modelType: FavoriteResponseDTO.self)
        print(resource)
        
        let newFavoriteMovie = try await httpClient.load(resource)
        print(newFavoriteMovie)
    }
    
    func loadPostToFavorites(movieId: Int) async {
        do {
            try await self.postToFavorites(movieId: movieId)
        } catch {
            print(error)
        }
    }
    
    
    
}