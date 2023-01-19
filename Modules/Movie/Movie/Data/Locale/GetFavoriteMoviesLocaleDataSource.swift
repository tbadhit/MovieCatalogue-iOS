//
//  GetFavoriteMoviesLocaleDataStore.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 11/01/23.
//

import Foundation
import Combine
import Core
import RealmSwift

public struct GetFavoriteMoviesLocaleDataSource: LocaleDataSource {
    public typealias Request = Int
    
    public typealias Response = MovieEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Int?) -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { completion in
            let favoritesMovies: Results<MovieEntity> = {
                _realm.objects(MovieEntity.self)
                    .filter("isFavorite == true")
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(favoritesMovies.toArray(ofType: MovieEntity.self)))
        }
        .eraseToAnyPublisher()
    }
    
    public func add(entities: [MovieEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func update(entity: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    if let newFavMovie = _realm.objects(MovieEntity.self)
                        .filter("id == \(entity.id)")
                        .first {
                        newFavMovie.isFavorite = !newFavMovie.isFavorite
                        completion(.success(newFavMovie.isFavorite))
                    } else {
                        let newMovie = MovieEntity()
                        newMovie.title = entity.title
                        newMovie.id = entity.id
                        newMovie.voteCount = entity.voteCount
                        newMovie.voteAverage = entity.voteAverage
                        newMovie.releaseDate = entity.releaseDate
                        newMovie.posterPath = entity.posterPath
                        newMovie.popularity = entity.popularity
                        newMovie.overview = entity.overview
                        newMovie.language = entity.language
                        newMovie.backdropPath = entity.backdropPath
                        newMovie.isFavorite = true
                        _realm.add(newMovie)
                        completion(.success(newMovie.isFavorite))
                    }
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let movie = _realm.objects(MovieEntity.self)
                .filter("id == \(id)")
                .filter("isFavorite == true")
            completion(.success(!movie.isEmpty))
        }
        .eraseToAnyPublisher()
    }
}
