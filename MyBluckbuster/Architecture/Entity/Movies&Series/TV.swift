//
//  TV.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 21/07/21.
//

import Foundation

struct TV: Codable {
    var poster_path : String?
    var popularity : Double
    var id : Int
    var backdrop_path : String?
    var vote_average : Double
    var overview : String
    var first_air_date : String?
    var origin_country : [String]
    var genre_ids : [Int]
    var original_language : String
    var vote_count : Int
    var name : String
    var original_name : String
}
