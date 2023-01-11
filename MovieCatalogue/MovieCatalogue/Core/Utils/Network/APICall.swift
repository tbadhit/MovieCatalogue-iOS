//
//  APICall.swift
//  MovieCatalogue
//
//  Created by Tubagus Adhitya Permana on 02/01/23.
//

import Foundation

struct API {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let key = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
}
protocol Endpoint {
    var url: String { get }
}
enum Endpoints {
    enum Gets: Endpoint {
        case popular
        case search
        public var url: String {
            switch self {
            case .popular: return "\(API.baseURL)movie/popular?api_key=\(API.key)"
            case .search: return "\(API.baseURL)search/movie?api_key=\(API.key)"
            }
        }
    }
}
