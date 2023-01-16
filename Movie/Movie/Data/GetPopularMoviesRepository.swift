//
//  GetPopularMoviesRepository.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 10/01/23.
//

import Core
import Combine

public struct GetPopularMoviesRepository<
    MovieLocaleDataStore: LocaleDataSource,
    MovieRemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository where
MovieLocaleDataStore.Request == Any,
MovieLocaleDataStore.Response == MovieEntity,
MovieRemoteDataSource.Request == Any,
MovieRemoteDataSource.Response == [MovieResponse],
Transformer.Request == String,
Transformer.Responses == [MovieResponse],
Transformer.Entity == MovieEntity,
Transformer.Domain == MovieModel,
Transformer.Entities == [MovieEntity],
Transformer.Domains == [MovieModel]{
    public typealias Request = Any
    public typealias Response = [MovieModel]
    
    private let _localeDataSource: MovieLocaleDataStore
    private let _remoteDataSource: MovieRemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: MovieLocaleDataStore,
        remoteDataSource: MovieRemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    public func execute(request: Any?) -> AnyPublisher<[MovieModel], Error> {
        return _localeDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[MovieModel], Error> in
                if result.isEmpty {
                    return _remoteDataSource.execute(request: nil)
                        .map { _mapper.transformResponseToEntity(response: $0) }
                        .catch { _ in _localeDataSource.list(request: nil) }
                        .flatMap { _localeDataSource.add(entities: $0) }
                        .filter { $0 }
                        .flatMap { _ in
                            _localeDataSource.list(request: nil)
                                .map { _mapper.transformEntityToDomain(entity: $0) }
                                .eraseToAnyPublisher()
                        }
                        .eraseToAnyPublisher()
                } else {
                    return _localeDataSource.list(request: nil)
                        .map { _mapper.transformEntityToDomain(entity: $0) }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
