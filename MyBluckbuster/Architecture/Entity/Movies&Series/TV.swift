//
//  TV.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 21/07/21.
//

import Foundation

struct TV: Codable {
    var poster_path : String
    var overview : String
    var genre_ids : [Int]
    var id : Int
    var original_language : String
    var backdrop_path : String
    var popularity : Double
    var vote_count : Int
    var vote_average : Double    
    var first_air_date : String = ""
    var name : String = ""
    var origin_country : String = ""
    var original_name : String = ""
    
}
