//
//  DetailView.swift
//  MovieCatalogue
//
//  Created by Tubagus Adhitya Permana on 02/01/23.
//

import SwiftUI
import CachedAsyncImage
import Movie
import Core

struct DetailView: View {
    @ObservedObject var presenter: MoviePresenter<
        Interactor<
            Int,
            Bool,
            GetFavoriteMovieRepository<
                GetFavoriteMoviesLocaleDataSource,
                MovieTransformer
            >
        >,
        Interactor<
            MovieModel,
            Bool,
            UpdateFavoriteMovieRepository<
                GetFavoriteMoviesLocaleDataSource,
                MovieTransformer
            >
        >
    >
    var movie: MovieModel
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else {
                ScrollView {
                    VStack {
                        imagePoster
                        VStack(alignment: .leading) {
                            HStack {
                                Text(movie.title)
                                    .font(.title)
                                    .bold()
                                Spacer()
                                Button {
                                    presenter.updateFavoriteMovie(request: movie)
                                } label: {
                                    if presenter.isFavorited {
                                        Image(systemName: "heart.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25)
                                    } else {
                                        Image(systemName: "heart")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25)
                                    }
                                }
                                .padding(.leading, 20)

                            }
                            .padding(.vertical, 10)
                            Text(movie.overview)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.presenter.getMovie(request: movie.id)
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

extension DetailView {
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }
    var imagePoster: some View {
        CachedAsyncImage(url: URL(string: movie.backdropImage)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .scaledToFill()
    }
}
