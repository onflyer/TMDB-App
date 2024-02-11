//
//  MovieHomeScreenViewModel.swift
//  TMDB App
//
//  Created by Aleksandar Milidrag on 12/17/23.
//

import Foundation
import Dependencies


@MainActor
final class MovieHomeScreenViewModel: ObservableObject {
    
//    @Dependency(\.httpClient) var httpClient
    
    @Published var alert: CustomAlert? = nil
    @Published var showAlert: Bool = false
    
    @Published var error: NetworkError?
    @Published var hasError: Bool = false
    
    @Published var nowPlayingMovies1: [Movie] = []
    @Published var upcomingMovies1: [Movie] = []
    @Published var topRatedMovies1: [Movie] = []
    @Published var popularMovies1: [Movie] = []
    private var page = 1
    
    func fetchNowPlayingMovies() async throws {
        let resource = Resource(url: Constants.Urls.nowPlaying,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef")]), modelType: MovieResponse.self)
        
        let movieResults = try await HTTPClient.shared.load(resource)
        nowPlayingMovies1 = movieResults.results
        
        
    }
    
    func loadNowPlayingMovies() async {
        do {
            try await self.fetchNowPlayingMovies()
        } catch {
            print(error)
            self.hasError = true
            if let networkingError = error as? NetworkError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    func fetchNextPageOfNowPlayingMovies() async throws {
        page += 1
        let resource = Resource(url: Constants.Urls.nowPlaying,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef"), URLQueryItem(name: "page", value: String(page))]), modelType: MovieResponse.self)
        
        let movieResults = try await HTTPClient.shared.load(resource)
        nowPlayingMovies1.append(contentsOf: movieResults.results)
        
        
    }
    
    func loadNextSetOfNowPlayingMovies() async {
            do {
                try await self.fetchNextPageOfNowPlayingMovies()
            } catch {
                print(error)
                self.hasError = true
                if let networkingError = error as? NetworkError {
                    self.error = networkingError
                } else {
                    self.error = .custom(error: error)
                }
            }
        }
    
    func fetchUpcomingMovies() async throws {
        let resource = Resource(url: Constants.Urls.upcoming,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef")]), modelType: MovieResponse.self)
        
        let movieResults = try await HTTPClient.shared.load(resource)
        upcomingMovies1 = movieResults.results
        
        
    }
    func loadUpcomingMovies() async {
        do {
            try await self.fetchUpcomingMovies()
        } catch {
            print(error)
            self.hasError = true
            if let networkingError = error as? NetworkError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    func fetchNextPageOfUpcomingMovies() async throws {
        page += 1
        let resource = Resource(url: Constants.Urls.upcoming,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef"), URLQueryItem(name: "page", value: String(page))]), modelType: MovieResponse.self)
        
        let movieResults = try await HTTPClient.shared.load(resource)
        upcomingMovies1.append(contentsOf: movieResults.results)
        
        
    }
    func loadNextSetOfUpcomingMovies() async {
            do {
                try await self.fetchNextPageOfUpcomingMovies()
            } catch {
                print(error)
                self.hasError = true
                if let networkingError = error as? NetworkError {
                    self.error = networkingError
                } else {
                    self.error = .custom(error: error)
                }
            }
        }
    
    
    
    
    func fetchTopRatedMovies() async throws {
        let resource = Resource(url: Constants.Urls.topRated,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef")]), modelType: MovieResponse.self)
        
        let movieResults = try await HTTPClient.shared.load(resource)
        topRatedMovies1 = movieResults.results
    }
    
    func loadTopRatedMovies() async {
        
        do {
            try await self.fetchTopRatedMovies()
        } catch {
            print(error)
            self.hasError = true
            if let networkingError = error as? NetworkError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
        
    }
    
    func fetchNextPageOfTopRatedMovies() async throws {
        page += 1
        let resource = Resource(url: Constants.Urls.topRated,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef"), URLQueryItem(name: "page", value: String(page))]), modelType: MovieResponse.self)
        
        let movieResults = try await HTTPClient.shared.load(resource)
        topRatedMovies1.append(contentsOf: movieResults.results)
        
        
    }
    func loadNextSetOfTopRatedMovies() async {
            do {
                try await self.fetchNextPageOfTopRatedMovies()
            } catch {
                print(error)
                self.hasError = true
                if let networkingError = error as? NetworkError {
                    self.error = networkingError
                } else {
                    self.error = .custom(error: error)
                }
            }
        }
    
    func fetchPopularMovies() async throws {
        let resource = Resource(url: Constants.Urls.popular,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef")]), modelType: MovieResponse.self)
        
        let movieResults = try await HTTPClient.shared.load(resource)
        popularMovies1 = movieResults.results
    }
    func loadPopularMovies() async {
        
        do {
            try await self.fetchPopularMovies()
        } catch {
            print(error)
            self.hasError = true
            if let networkingError = error as? NetworkError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    func fetchNextPageOfPopularMovies() async throws {
        page += 1
        let resource = Resource(url: Constants.Urls.upcoming,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef"), URLQueryItem(name: "page", value: String(page))]), modelType: MovieResponse.self)
        
        let movieResults = try await HTTPClient.shared.load(resource)
        popularMovies1.append(contentsOf: movieResults.results)
        
        
    }
    func loadNextSetOfPopularMovies() async {
            do {
                try await self.fetchNextPageOfPopularMovies()
            } catch {
                print(error)
                self.hasError = true
                if let networkingError = error as? NetworkError {
                    self.error = networkingError
                } else {
                    self.error = .custom(error: error)
                }
            }
        }
   
}
