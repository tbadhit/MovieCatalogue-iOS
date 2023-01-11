//
//  ContentView.swift
//  MovieCatalogue
//
//  Created by Tubagus Adhitya Permana on 01/01/23.
//

import SwiftUI
import Core
import Movie

struct ContentView: View {
    @EnvironmentObject var presenter: GetListPresenter<
        Any,
        MovieModel,
        Interactor<
            Any,
            [MovieModel],
            GetPopularMoviesRepository<
                GetPopularMoviesLocaleDataSource,
                GetPopularMoviesRemoteDataSource,
                MovieTransformer
            >
        >
    >
    @EnvironmentObject var favoritePresenter: GetListPresenter<
        Int,
        MovieModel,
        Interactor<
            Int,
            [MovieModel],
            GetFavoriteMoviesRepository<
                GetFavoriteMoviesLocaleDataSource,
                MovieTransformer>
        >
    >
    @EnvironmentObject var searchPresenter: SearchPresenter<
        MovieModel,
        Interactor<
            String,
            [MovieModel],
            SearchMoviesRepository<
                GetPopularMoviesRemoteDataSource,
                MovieTransformer>
        >
    >
    var body: some View {
        TabView {
            HomeView(presenter: presenter)
                .tabItem {
                    Label("home_tabbar".localized(identifier: "tbadhit.Core"), systemImage: "house.fill")
                }
            SearchView(presenter: searchPresenter)
                .tabItem {
                    Label("search_tabbar".localized(identifier: "tbadhit.Core"), systemImage: "magnifyingglass")
                }
            FavoriteView(presenter: favoritePresenter)
                .tabItem {
                    Label("favorite_tabbar".localized(identifier: "tbadhit.Core"), systemImage: "heart")
                }
            ProfileView()
                .tabItem {
                    Label("profile_tabbar".localized(identifier: "tbadhit.Core"), systemImage: "person.crop.circle.fill")
                }
        }
    }
}
