//
//  MovieViewModel.swift
//  CombineNetworkCall
//
//  Created by Mehrdad Behrouz Ahmadian on 2024-01-25.
//

import Combine
import Foundation

final class MovieViewModel: ObservableObject {
    @Published private var upcomingMovies: [Movie] = []
    @Published private var searchResults: [Movie] = []
    @Published var searchQuery: String = ""
    
    var movies: [Movie] {
        searchResults.isEmpty ? upcomingMovies : searchResults
    }
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchQuery
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .map { searchQuery in
                searchMovies(for: searchQuery)
                    .replaceError(with: MovieResponse(results: []))
            }
            .switchToLatest()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .assign(to: &$searchResults)
    }
    
    func fetchInitialData() {
         fetchMovies()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
//            .catch { error in
//                Just([])
//            }
            .assign(to: &$upcomingMovies)
//            .assign(to: \.movies, on: dataStore)
//            .store(in: &cancellables)
        
        
//            .sink { completion in
//                switch completion {
//                case .finished:()
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            } receiveValue: { [weak self] movies in
//                self?.movies = movies
//            }
//            .store(in: &cancellables)

    }
}
