//
//  FavoriteView.swift
//  MovieCatalogue
//
//  Created by Tubagus Adhitya Permana on 03/01/23.
//

import SwiftUI
import CachedAsyncImage
import Core
import Movie

struct FavoriteView: View {
    @ObservedObject var presenter: GetListPresenter<
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
    var body: some View {
        NavigationStack {
            ZStack {
                if presenter.isLoading {
                    VStack {
                        ProgressView()
                    }
                } else {
                    if presenter.list.isEmpty {
                        Text("Favorite is empty")
                    } else {
                        List {
                            ForEach(presenter.list, id: \.id) { movie in
                                linkBuilder(for: movie) {
                                    HStack {
                                        CachedAsyncImage(url: URL(string: movie.posterImage)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .cornerRadius(30)
                                        .scaledToFit()
                                        .frame(width: 120)
                                        VStack(alignment: .leading) {
                                            Text(movie.title)
                                                .lineLimit(3)
                                                .font(.title)
                                                .bold()
                                                .padding(.top, 20)
                                            Spacer()
                                            Text(movie.releaseDate)
                                                .font(.title3)
                                                .padding(.bottom, 20)
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(.grouped)
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                self.presenter.getList(request: nil)
        }
        }
    }
}

extension FavoriteView {
    func linkBuilder<Content: View> (
        for movie: MovieModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: movie)
        ) {
            content()
        }
    }
}
