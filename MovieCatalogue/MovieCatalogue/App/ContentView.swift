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
                    Label("Home", systemImage: "house.fill")
                }
            SearchView(presenter: searchPresenter)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            FavoriteView(presenter: favoritePresenter)
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
    }
}
