//
//  SearchView.swift
//  MovieCatalogue
//
//  Created by Tubagus Adhitya Permana on 03/01/23.
//

import SwiftUI
import CachedAsyncImage
import Core
import Movie

struct SearchView: View {
    @ObservedObject var presenter: SearchPresenter<
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
        NavigationStack {
            VStack {
                SearchBar(text: $presenter.keyword) { _ in
                    self.presenter.search()
                }
                if presenter.isLoading {
                    Spacer()
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    if presenter.keyword.isEmpty {
                        Spacer()
                        Spacer()
                        Text("Search")
                        Spacer()
                    } else if presenter.list.isEmpty {
                        Spacer()
                        Spacer()
                        Text("Not Found")
                        Spacer()
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
                    }
                }
                Spacer()
            }
            .onAppear {
                presenter.search()
            }
        }
    }
}

extension SearchView {
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
