//
//  MovieEntity.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 10/01/23.
//

import Foundation
import RealmSwift

public class MovieEntity: Object {
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var language: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var posterPath: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var isFavorite: Bool = false
    public override class func primaryKey() -> String? {
        return "id"
    }
}
