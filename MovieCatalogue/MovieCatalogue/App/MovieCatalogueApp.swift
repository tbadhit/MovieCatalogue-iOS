//
//  MovieCatalogueApp.swift
//  MovieCatalogue
//
//  Created by Tubagus Adhitya Permana on 01/01/23.
//

import SwiftUI
import UIKit
import RealmSwift
import Core
import Movie

@main
struct MovieCatalogueApp: SwiftUI.App {
    var body: some Scene {
        let movieUseCase: Interactor<
            Any,
            [MovieModel],
            GetPopularMoviesRepository<
                GetPopularMoviesLocaleDataSource,
                GetPopularMoviesRemoteDataSource,
                MovieTransformer>
        >  = Injection.init().providePopularMovies()
        let homePresenter = GetListPresenter(useCase: movieUseCase)
        let favoriteUseCase: Interactor<
            Int,
            [MovieModel],
            GetFavoriteMoviesRepository<
                GetFavoriteMoviesLocaleDataSource,
                MovieTransformer>
        >  = Injection.init().provideFavoriteMovies()
        let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
        let searchUseCase: Interactor<
            String,
            [MovieModel],
            SearchMoviesRepository<
                GetPopularMoviesRemoteDataSource,
                MovieTransformer>
        >  = Injection.init().provideSearch()
        let searchPresenter = SearchPresenter(useCase: searchUseCase)
        WindowGroup {
            SplashView()
                .environmentObject(homePresenter)
                .environmentObject(favoritePresenter)
                .environmentObject(searchPresenter)
        }
    }
}
