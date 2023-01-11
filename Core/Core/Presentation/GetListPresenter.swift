//
//  GetListPresenter.swift
//  Core
//
//  Created by Tubagus Adhitya Permana on 10/01/23.
//

import SwiftUI
import Combine

public class GetListPresenter<
    Request,
    Response,
    Interactor: UseCase
>: ObservableObject where Interactor.Request == Request, Interactor.Response == [Response] {
    private var cancellables: Set<AnyCancellable> = []
    private let _useCase: Interactor
    
    @Published public var list: [Response] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    public func getList(request: Request?) {
        isLoading = true
        _useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                    print("Gagal", error.localizedDescription)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { list in
                print("Data di presnter", list)
                self.list = list
            })
            .store(in: &cancellables)
    }
}
