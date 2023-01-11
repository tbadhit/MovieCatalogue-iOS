//
//  SearchMoviesRepository.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 11/01/23.
//

import Core
import Combine

public struct SearchMoviesRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
RemoteDataSource.Request == Any,
RemoteDataSource.Response == [MovieResponse],
Transformer.Request == String,
Transformer.Responses == [MovieResponse],
Transformer.Entity == MovieEntity,
Transformer.Domain == MovieModel,
Transformer.Entities == [MovieEntity],
Transformer.Domains == [MovieModel] {
    
    public typealias Request = String
    public typealias Response = [MovieModel]
    
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
            
            _remoteDataSource = remoteDataSource
            _mapper = mapper
        }
    public func execute(request: String?) -> AnyPublisher<[MovieModel], Error> {
        return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToDomain(response: $0) }
            .eraseToAnyPublisher()
    }
}
