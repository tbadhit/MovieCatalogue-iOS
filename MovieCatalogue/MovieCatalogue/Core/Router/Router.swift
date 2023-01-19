//
//  Router.swift
//  MovieCatalogue
//
//  Created by Tubagus Adhitya Permana on 20/01/23.
//

import SwiftUI
import Movie
import Core
import Detail

class Router {
    func makeDetailView(for movie: MovieModel) -> DetailView {
        let useCase: Interactor<
            Int,
            Bool,
            GetFavoriteMovieRepository<
                GetFavoriteMoviesLocaleDataSource,
                MovieTransformer
            >
        > = Injection.init().provideMovie()
        let favoriteUseCase: Interactor<
            MovieModel,
            Bool,
            UpdateFavoriteMovieRepository<
                GetFavoriteMoviesLocaleDataSource,
                MovieTransformer
            >
        > = Injection.init().provideUpdateFavorite()
        let presenter = MoviePresenter(movieUseCase: useCase, favoriteUseCase: favoriteUseCase)
        return DetailView(presenter: presenter, movie: movie)
    }
}
