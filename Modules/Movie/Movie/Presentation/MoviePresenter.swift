//
//  MoviePresenter.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 11/01/23.
//

import Foundation
import Combine
import Core

public class MoviePresenter<
    MovieUseCase: UseCase,
    FavoriteUseCase: UseCase>: ObservableObject
where
MovieUseCase.Request == Int, MovieUseCase.Response == Bool,
FavoriteUseCase.Request == MovieModel, FavoriteUseCase.Response == Bool {
    private var cancellables: Set<AnyCancellable> = []
    
    private let _movieUseCase: MovieUseCase
    private let _favoriteUseCase: FavoriteUseCase
    
    @Published public var isFavorited: Bool = false
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(movieUseCase: MovieUseCase, favoriteUseCase: FavoriteUseCase) {
        _movieUseCase = movieUseCase
        _favoriteUseCase = favoriteUseCase
    }
    
    public func getMovie(request: MovieUseCase.Request) {
        isLoading = true
        _movieUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { isFavorited in
                self.isFavorited = isFavorited
            })
            .store(in: &cancellables)
    }
    
    public func updateFavoriteMovie(request: FavoriteUseCase.Request) {
        _favoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { isFavorited in
                self.isFavorited = isFavorited
            })
            .store(in: &cancellables)
    }
    
}
