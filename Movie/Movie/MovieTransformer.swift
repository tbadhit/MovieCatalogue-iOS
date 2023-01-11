//
//  MovieTransformer.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 10/01/23.
//

import RealmSwift
import Core

public struct MovieTransformer: Mapper {
    public typealias Request = String
    public typealias Responses = [MovieResponse]
    public typealias Entity = MovieEntity
    public typealias Entities = [MovieEntity]
    public typealias Domain = MovieModel
    public typealias Domains = [MovieModel]
    private let urlPoster = "https://image.tmdb.org/t/p/w500"
    public init() {}
    public func transformResponseToEntity(response: [MovieResponse]) -> [MovieEntity] {
        return response.map { result in
            let newPopularMovie = MovieEntity()
            newPopularMovie.title = result.title ?? ""
            newPopularMovie.id = result.id ?? 0
            newPopularMovie.voteCount = result.voteCount ?? 0
            newPopularMovie.voteAverage = result.voteAverage ?? 0.0
            newPopularMovie.releaseDate = result.releaseDate ?? ""
            newPopularMovie.posterPath = "\(urlPoster)\(result.posterPath ?? "")"
            newPopularMovie.popularity = result.popularity ?? 0.0
            newPopularMovie.overview = result.overview ?? ""
            newPopularMovie.language = result.language ?? ""
            newPopularMovie.backdropPath = "\(urlPoster)\(result.backdropPath ?? "")"
            newPopularMovie.isFavorite = false
            return newPopularMovie
        }
    }
    public func transformEntityToDomain(entity: [MovieEntity]) -> [MovieModel] {
        return entity.map { result in
            return MovieModel(
                adult: false,
                backdropImage: result.backdropPath,
                genreIDS: [],
                id: result.id,
                language: result.language,
                title: result.title,
                overview: result.overview,
                popularity: result.popularity,
                posterImage: result.posterPath,
                releaseDate: result.releaseDate,
                voteAverage: result.voteAverage,
                voteCount: result.voteCount,
                isFavorite: result.isFavorite)
        }
    }
    public func transformResponseToDomain(response: [MovieResponse]) -> [MovieModel] {
        return response.map { result in
            return MovieModel(
                adult: result.adult ?? false,
                backdropImage: "\(urlPoster)\(result.backdropPath ?? "")",
                genreIDS: result.genreIDS ?? [],
                id: result.id ?? 0,
                language: result.language ?? "",
                title: result.title ?? "",
                overview: result.overview ?? "",
                popularity: result.popularity ?? 0.0,
                posterImage: "\(urlPoster)\(result.posterPath ?? "")",
                releaseDate: result.releaseDate ?? "",
                voteAverage: result.voteAverage ?? 0.0,
                voteCount: result.voteCount ?? 0,
                isFavorite: false)
        }
    }
    public func transformDomainToEntity(model: MovieModel) -> MovieEntity {
        let newPopularMovie = MovieEntity()
        newPopularMovie.title = model.title
        newPopularMovie.id = model.id
        newPopularMovie.voteCount = model.voteCount
        newPopularMovie.voteAverage = model.voteAverage
        newPopularMovie.releaseDate = model.releaseDate
        newPopularMovie.posterPath = "\(urlPoster)\(model.posterImage)"
        newPopularMovie.popularity = model.popularity
        newPopularMovie.overview = model.overview
        newPopularMovie.language = model.language
        newPopularMovie.backdropPath = "\(urlPoster)\(model.backdropImage)"
        newPopularMovie.isFavorite = model.isFavorite
        return newPopularMovie
    }
}
