//
//  MovieHomeScreenViewModel.swift
//  TMDB App
//
//  Created by Aleksandar Milidrag on 12/17/23.
//

import Foundation


@MainActor
final class MovieHomeScreenViewModel: ObservableObject {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    @Published var alert: CustomAlert? = nil
    @Published var showAlert: Bool = false
    
    @Published var nowPlayingMovies1: [Movie] = []
    @Published var upcomingMovies1: [Movie] = []
    @Published var topRatedMovies1: [Movie] = []
    @Published var popularMovies1: [Movie] = []
    private var page = 1
    
    func fetchNowPlayingMovies() async throws {
        let resource = Resource(url: Constants.Urls.nowPlaying,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef")]), modelType: MovieResponse.self)
        
        let movieResults = try await httpClient.load(resource)
        nowPlayingMovies1 = movieResults.results
    }
    
    func loadNowPlayingMovies() async {
        do {
            try await self.fetchNowPlayingMovies()
        } catch {
            self.showAlert = true
            self.alert = .noInternetConnection(onOkPressed: {
                
            }, onRetryPressed: {
                Task {
                    try await self.fetchNowPlayingMovies()
                }
            })
            print(error)
        }
    }
    
    func fetchNextPageOfNowPlayingMovies() async throws {
        page += 1
        let resource = Resource(url: Constants.Urls.nowPlaying,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef"), URLQueryItem(name: "page", value: String(page))]), modelType: MovieResponse.self)
        
        let movieResults = try await httpClient.load(resource)
        nowPlayingMovies1.append(contentsOf: movieResults.results)
        
        
    }
    
    func fetchUpcomingMovies() async throws {
        let resource = Resource(url: Constants.Urls.upcoming,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef")]), modelType: MovieResponse.self)
        
        let movieResults = try await httpClient.load(resource)
        upcomingMovies1 = movieResults.results
        
        
    }
    func loadUpcomingMovies() async {
        do {
            try await self.fetchUpcomingMovies()
        } catch {
            print(error)
        }
    }
    
    func fetchTopRatedMovies() async throws {
        let resource = Resource(url: Constants.Urls.topRated,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef")]), modelType: MovieResponse.self)
        
        let movieResults = try await httpClient.load(resource)
        topRatedMovies1 = movieResults.results
    }
    
    func loadTopRatedMovies() async {
        
        do {
            try await self.fetchTopRatedMovies()
        } catch {
            print(error)
        }
        
    }
    
    func fetchPopularMovies() async throws {
        let resource = Resource(url: Constants.Urls.popular,method: .get([URLQueryItem(name: "api_key", value: "89e4bae37305d94ef67db0a32d6e79ef")]), modelType: MovieResponse.self)
        
        let movieResults = try await httpClient.load(resource)
        popularMovies1 = movieResults.results
    }
    func loadPopularMovies() async {
        
        do {
            try await self.fetchPopularMovies()
        } catch {
            print(error)
        }
    }
   
}