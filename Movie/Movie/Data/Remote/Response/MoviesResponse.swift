//
//  MoviesResponse.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 10/01/23.
//

import Foundation

public struct MoviesResponse: Codable {
    let page: Int
    let movies: [MovieResponse]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
public struct MovieResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let language, title, overview: String?
    let popularity: Double?
    let posterPath, releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case language = "original_language"
        case title = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
