//
//  ThumbnailPosterView.swift
//  TMDB App
//
//  Created by Aleksandar Milidrag on 3/21/24.
//

import SwiftUI

struct ThumbnailPosterView: View {
    
    let movie: SingleMovieEntity
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5)
            if let posterPath = movie.posterPath {
                CachedImage(url: posterPath) { phase in
                    switch phase {
                    case .empty:
                    Color.gray.opacity(0.5)
                    case .success(let image):
                        image.resizable()
                    case .failure(let error):
                        Text(error.localizedDescription)
                    @unknown default:
                        EmptyView()
                    }
                }
            }

        }
        .frame(width: 204, height: 306)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

#Preview {
    ThumbnailPosterView(movie: SingleMovieEntity.dummySingleMovie() )
}



