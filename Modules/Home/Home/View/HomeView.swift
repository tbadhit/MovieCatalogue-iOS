//
//  HomeView.swift
//  Home
//
//  Created by Tubagus Adhitya Permana on 19/01/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Movie

public struct HomeView<DetailRoute: View>: View {
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
    let detailRoute: ((MovieModel) -> DetailRoute)
    
    public init(detailRoute: @escaping ((MovieModel) -> DetailRoute)) {
        self.detailRoute = detailRoute
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                if presenter.isLoading {
                    loadingIndicator
                } else {
                    List {
                        ForEach(self.presenter.list, id: \.id) { movie in
                            linkBuilder(for: movie) {
                                HStack {
                                    WebImage(url: URL(string: movie.posterImage))
                                        .resizable()
                                        .placeholder{
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
            .navigationTitle("Movies")
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
            destination: self.detailRoute(movie)
        ) {
            content()
        }
    }
}
