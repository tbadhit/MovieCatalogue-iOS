//
//  Injection.swift
//  MovieCatalogue
//
//  Created by Tubagus Adhitya Permana on 02/01/23.
//

import Foundation
import RealmSwift
import Core
import Movie
import UIKit

final class Injection: NSObject {
    var realm: Realm! = try! Realm()
    func providePopularMovies<U: UseCase>() -> U where U.Request == Any, U.Response == [MovieModel] {
        let locale = GetPopularMoviesLocaleDataSource(realm: realm)
        let remote = GetPopularMoviesRemoteDataSource(endPoint: Endpoints.Gets.popular.url)
        let mapper = MovieTransformer()
        let repository = GetPopularMoviesRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        return Interactor(repository: repository) as! U // swiftlint:disable:this force_cast
    }
    func provideMovie<U: UseCase>() -> U where U.Request == Int, U.Response == Bool {
        let locale = GetFavoriteMoviesLocaleDataSource(realm: realm)
        let mapper = MovieTransformer()
        let repository = GetFavoriteMovieRepository(localeDataSource: locale, mapper: mapper)
        return Interactor(repository: repository) as! U // swiftlint:disable:this force_cast
    }
    func provideUpdateFavorite<U: UseCase>() -> U where U.Request == MovieModel, U.Response == Bool {
        let locale = GetFavoriteMoviesLocaleDataSource(realm: realm)
        let mapper = MovieTransformer()
        let repository = UpdateFavoriteMovieRepository(localeDataSource: locale, mapper: mapper)
        return Interactor(repository: repository) as! U // swiftlint:disable:this force_cast
    }
    func provideFavoriteMovies<U: UseCase>() -> U where U.Request == Int, U.Response == [MovieModel] {
        let locale = GetFavoriteMoviesLocaleDataSource(realm: realm)
        let mapper = MovieTransformer()
        let repository = GetFavoriteMoviesRepository(localeDataSource: locale, mapper: mapper)
        return Interactor(repository: repository) as! U // swiftlint:disable:this force_cast
    }
    func provideSearch<U: UseCase>() -> U where U.Request == String, U.Response == [MovieModel] {
        let remote = GetPopularMoviesRemoteDataSource(endPoint: Endpoints.Gets.search.url)
        let mapper = MovieTransformer()
        let repository = SearchMoviesRepository(remoteDataSource: remote, mapper: mapper)
        return Interactor(repository: repository) as! U // swiftlint:disable:this force_cast
    }
}
