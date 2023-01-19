//
//  GetPopularMoviesDataSource.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 10/01/23.
//

import Foundation
import Core
import Alamofire
import Combine

public struct GetPopularMoviesRemoteDataSource: DataSource {
    public typealias Request = Any
    public typealias Response = [MovieResponse]
    private let _endPoint: String
    public init(endPoint: String) {
        _endPoint = endPoint
    }
    public func execute(request: Any?) -> AnyPublisher<Response, Error> {
        return Future<[MovieResponse], Error> { completion in
            var parameters: [String: Any] = [:]
            if request != nil {
                parameters = [
                    "query": request ?? ""
                ]
            }
            if let url = URL(string: _endPoint) {
                AF.request(url, parameters: parameters)
                    .validate()
                    .responseDecodable(of: MoviesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.movies))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
