//
//  SearchView.swift
//  Search
//
//  Created by Tubagus Adhitya Permana on 20/01/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Movie

public struct SearchView<DetailRoute: View>: View {
    @EnvironmentObject var presenter: SearchPresenter<
        MovieModel,
        Interactor<
            String,
            [MovieModel],
            SearchMoviesRepository<
                GetPopularMoviesRemoteDataSource,
                MovieTransformer>
        >
    >
    let detailRoute: ((MovieModel) -> DetailRoute)
    
    public init(detailRoute: @escaping ((MovieModel) -> DetailRoute)) {
        self.detailRoute = detailRoute
    }
    public var body: some View {
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
            destination: self.detailRoute(movie)
        ) {
            content()
        }
    }
}

