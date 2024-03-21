//
//  FavoritesViewModel.swift
//  TMDB App
//
//  Created by Aleksandar Milidrag on 3/21/24.
//

import Foundation

@MainActor
final class FavoritesViewModel: ViewModel {
    // MARK: - Dependencies -
    private let getFavoritesUseCase: any GetFavoritesUseCase
    
   // MARK: - Properties -
    @Published var favoriteMovies: [MovieEntity] = []
    private var page = 1
    
    // MARK: - Init -
    init(getFavoritesUseCase: any GetFavoritesUseCase) {
        self.getFavoritesUseCase = getFavoritesUseCase
    }
}


extension FavoritesViewModel {
    func loadFavoriteMovies() async {
            state = .loading
            let result = await getFavoritesUseCase.execute(page: page)
            
            switch result {
            case .success(let data):
                favoriteMovies.append(contentsOf: data)
                if favoriteMovies.isEmpty {
                    state = .empty
                } else {
                    state = .success
                }
            case .failure(let error):
                print(error)
                state = .error(error.localizedDescription)
            
        }
    }
}