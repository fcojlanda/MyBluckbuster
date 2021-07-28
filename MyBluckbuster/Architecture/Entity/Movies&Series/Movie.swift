//
//  Movie.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 21/07/21.
//

import Foundation

struct Movie: Codable {
    var poster_path : String
    var overview : String
    var genre_ids : [Int]
    var id : Int
    var original_language : String
    var backdrop_path : String
    var popularity : Double
    var vote_count : Int
    var vote_average : Double
    var adult : Bool?
    var release_date : String?
    var original_title : String?
    var title : String?
    var video : Bool?
}
