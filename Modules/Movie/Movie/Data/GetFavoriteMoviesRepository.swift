//
//  GetFavoriteMoviesRepositoy.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 11/01/23.
//

import Core
import Combine

public struct GetFavoriteMoviesRepository<
    MovieLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    MovieLocaleDataSource.Request == Int,
    MovieLocaleDataSource.Response == MovieEntity,
    Transformer.Request == String,
    Transformer.Responses == [MovieResponse],
    Transformer.Entity == MovieEntity,
    Transformer.Domain == MovieModel,
    Transformer.Entities == [MovieEntity],
    Transformer.Domains == [MovieModel]{
    
    public typealias Request = Int
    public typealias Response = [MovieModel]
    
    private let _localeDataSource: MovieLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: MovieLocaleDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: Int?) -> AnyPublisher<[MovieModel], Error> {
        return _localeDataSource.list(request: request)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}
