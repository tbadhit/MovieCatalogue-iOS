//
//  HomeView.swift
//  MovieCatalogue
//
//  Created by Tubagus Adhitya Permana on 02/01/23.
//

import SwiftUI
import CachedAsyncImage
import Core
import Movie

struct HomeView: View {
    @ObservedObject var presenter: GetListPresenter<
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
    var body: some View {
        NavigationStack {
            ZStack {
                if presenter.isLoading {
                    loadingIndicator
                } else {
                    List {
                        ForEach(self.presenter.list, id: \.id) { movie in
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
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("movies_title".localized(identifier: "tbadhit.Core"))
            .onAppear {
                self.presenter.getList(request: nil)
            }
        }
    }
}

extension HomeView {
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }
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
