//
//  ContentView.swift
//  CombineNetworkCall
//
//  Created by Mehrdad Behrouz Ahmadian on 2024-01-25.
//

import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        List(viewModel.movies) { movie in
            NavigationLink {
                MovieDetailsView(movie: movie)
            } label: {
                HStack {
                    AsyncImage(url: movie.posterURL) { poster in
                        poster
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.headline)
                        Text(movie.overview)
                            .font(.caption)
                            .lineLimit(3)
                    }
                }
            }
        }
        .navigationTitle("Upcoming Movies")
        .searchable(text: $viewModel.searchQuery)
        .onAppear {
            viewModel.fetchInitialData()
        }
    }
}

#Preview {
    MoviesView()
}
