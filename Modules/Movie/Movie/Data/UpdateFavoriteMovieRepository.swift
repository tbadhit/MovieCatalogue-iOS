//
//  UpdateFavoriteMovieRepository.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 11/01/23.
//

import Core
import Combine

public struct UpdateFavoriteMovieRepository<
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
    Transformer.Domains == [MovieModel]
{
    
    public typealias Request = MovieModel
    public typealias Response = Bool
    
    private let _localeDataSource: MovieLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: MovieLocaleDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    public func execute(request: MovieModel?) -> AnyPublisher<Bool, Error> {
        return _localeDataSource.update(entity: _mapper.transformDomainToEntity(model: request!))
    }
}
