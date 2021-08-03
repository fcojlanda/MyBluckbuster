//
//  GeneralTypes.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 27/07/21.
//

import Foundation

enum TypeRequest {
    case GET, POST, PUT
    
    func description()->String {
        switch self {
        case .GET: return "GET"
        case .POST: return "POST"
        case .PUT: return "PUT"
        }
    }
}

enum TypeContent {
    case Movie, TVShows, None
    
    func description()->String{
        switch self {
        case .Movie:
            return "movie"
        case .TVShows:
            return "tv"
        default:
            return "N/A"
        }
    }
    
    static func mapTypeContent(index: Int) -> TypeContent {
        switch index {
        case 0:
            return .Movie
        case 1:
            return .TVShows
        default:
            return .None
        }
    }
}


enum FitlerContent {
    case Popular, Best, Soon, None
    
    func getFilterQuery()->String{
        switch self {
        case .Popular:
            return "&sort_by=popularity.desc"
        case .Best:
            return "&sort_by=vote_count.desc"
        case .Soon:
            return "&sort_by=release_date.desc"
        default:
            return ""
        }
    }
    
    static func mapFilterContent(index: Int) -> FitlerContent {
        switch index {
        case 0:
            return .Popular
        case 1:
            return .Best
        case 2:
            return .Soon
        default:
            return .None
        }
    }
}
