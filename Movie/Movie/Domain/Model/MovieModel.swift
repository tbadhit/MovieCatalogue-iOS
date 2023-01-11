//
//  MovieModel.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 10/01/23.
//

import Foundation

public struct MovieModel: Equatable, Identifiable {
    public let adult: Bool
    public let backdropImage: String
    public let genreIDS: [Int]
    public let id: Int
    public let language, title, overview: String
    public let popularity: Double
    public let posterImage, releaseDate: String
    public let voteAverage: Double
    public let voteCount: Int
    public let isFavorite: Bool
}
