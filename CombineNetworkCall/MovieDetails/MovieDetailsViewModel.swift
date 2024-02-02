//
//  MovieDetailsViewModel.swift
//  CombineNetworkCall
//
//  Created by Mehrdad Behrouz Ahmadian on 2024-01-30.
//

import Combine
import Foundation


class MovieDetailsViewModel: ObservableObject {
    
    let movie: Movie
    @Published var data: (credits: [MovieCastMember], reviews: [MovieReview]) = ([], [])
    
//    private var cancellables = Set<AnyCancellable>()
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func fetchData() {
        let creditsPublisher = fetchCredits(for: movie).map(\.cast).replaceError(with: [])
        let reviewsPublisher = fetchReviews(for: movie).map(\.results).replaceError(with: [])
        
        Publishers.Zip(creditsPublisher, reviewsPublisher)
            .receive(on: DispatchQueue.main)
            .map { (credits: $0.0, reviews: $0.1) }
            .assign(to: &$data)
//            .sink { [weak self] data in
//                self?.data = data
//            }
//            .store(in: &cancellables)
    }
}
