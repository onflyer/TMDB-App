//
//  DetailView.swift
//  TMDB App
//
//  Created by Aleksandar Milidrag on 3/21/24.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel = Resolver.shared.resolve(DetailViewModel.self)
    
    var body: some View {
        ZStack {
            BaseStateView(viewModel: viewModel) {
                if let movie = viewModel.singleMovie {
                    VStack {
                        Text(viewModel.singleMovie?.title ?? "no movie")
                    }
                    
                }
                    
                
            } emptyView: {
                
            } errorView: { error in
                
            }

        }
        .task {
            await viewModel.loadMovieById(movieId: 3)
        }
    }
}

#Preview {
    DetailView()
}
