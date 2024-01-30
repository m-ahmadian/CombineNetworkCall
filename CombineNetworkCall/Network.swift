//
//  Network.swift
//  CombineNetworkCall
//
//  Created by Mehrdad Behrouz Ahmadian on 2024-01-25.
//

import Combine
import Foundation

enum Constants {
    static let apiKey = "8aacffb8202f899689c714c0c7c880ca"
}

func fetchMovies() -> some Publisher<MovieResponse, Error> {
    let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(Constants.apiKey)")!
    
    return URLSession
        .shared
        .dataTaskPublisher(for: url)
        .map(\.data)
//        .tryMap { data in
//            let decoded = try jsonDecoder.decode(MovieResponse.self, from: data)
//            return decoded
//        }
        .decode(type: MovieResponse.self, decoder: jsonDecoder)
}

func searchMovies(for query: String) -> some Publisher<MovieResponse, Error> {
    let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(Constants.apiKey)&query=\(encodedQuery!)")!
    
    return URLSession
        .shared
        .dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: MovieResponse.self, decoder: jsonDecoder)
}
