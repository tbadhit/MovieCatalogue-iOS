//
//  ContentView.swift
//  MovieCatalogue
//
//  Created by Tubagus Adhitya Permana on 01/01/23.
//

import SwiftUI
import Core
import Movie
import Home
import Favorite
import Search
import Detail
import Profile

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
    let router = Router()
    var body: some View {
        TabView {
            HomeView<DetailView>(detailRoute: { movie in
                router.makeDetailView(for: movie)
            })
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            SearchView<DetailView>(detailRoute: { movie in
                router.makeDetailView(for: movie)
            })
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            FavoriteView<DetailView>(detailRoute: { movie in
                router.makeDetailView(for: movie)
            })
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
