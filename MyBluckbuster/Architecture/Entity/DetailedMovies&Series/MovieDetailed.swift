//
//  MovieDetailed.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 02/08/21.
//

import Foundation

struct MovieDetailed: Codable {
    // First Level JSON
    var adult : Bool
    var backdrop_path : String?
    var budget : Int
    var homepage : String?
    var id : Int
    var imdb_id : String?
    var original_language : String
    var original_title : String
    var overview : String?
    var popularity : Double
    var poster_path : String?
    var release_date : String
    var revenue : Int
    var runtime : Int?
    var status : String
    var tagline : String?
    var title : String
    var video : Bool
    var vote_average : Double
    var vote_count : Int
    
    // 'belongs_to_collection' object
    var id_collection : Int?
    var name_collection : String?
    var poster_path_collection : String?
    var backdrop_path_collection : String?
    
    enum CodingKeys: String, CodingKey {
        case adult,
             backdrop_path,
             belongs_to_collection,
             budget,
             homepage,
             id,
             imdb_id,
             original_language,
             original_title,
             overview,
             popularity,
             poster_path,
             release_date,
             revenue,
             runtime,
             status,
             tagline,
             title,
             video,
             vote_average,
             vote_count
    }
    
    enum BelongsToCollectionKeys: CodingKey{
        case id, name, poster_path, backdrop_path
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // First Level JSON
        adult = try container.decode(Bool.self, forKey: .adult)
        backdrop_path = try container.decode(String.self, forKey: .backdrop_path)
        budget = try container.decode(Int.self, forKey: .budget)
        homepage = try container.decode(String.self, forKey: .homepage)
        id = try container.decode(Int.self, forKey: .id)
        imdb_id = try container.decode(String.self, forKey: .imdb_id)
        original_language = try container.decode(String.self, forKey: .original_language)
        original_title = try container.decode(String.self, forKey: .original_title)
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        poster_path = try container.decode(String.self, forKey: .poster_path)
        release_date = try container.decode(String.self, forKey: .release_date)
        revenue = try container.decode(Int.self, forKey: .revenue)
        runtime = try container.decode(Int.self, forKey: .runtime)
        status = try container.decode(String.self, forKey: .status)
        tagline = try container.decode(String.self, forKey: .tagline)
        title = try container.decode(String.self, forKey: .title)
        video = try container.decode(Bool.self, forKey: .video)
        vote_average = try container.decode(Double.self, forKey: .vote_average)
        vote_count = try container.decode(Int.self, forKey: .vote_count)
        
        // 'belongs_to_collection' object
        if let belongsToCollection = try? container.nestedContainer(keyedBy: BelongsToCollectionKeys.self, forKey: .belongs_to_collection){
            id_collection = try belongsToCollection.decode(Int.self, forKey: .id)
            name_collection = try belongsToCollection.decode(String.self, forKey: .name)
            poster_path_collection = try belongsToCollection.decode(String.self, forKey: .poster_path)
            backdrop_path_collection = try belongsToCollection.decode(String.self, forKey: .backdrop_path)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(adult, forKey: .adult)
        
        var belongsToCollection = container.nestedContainer(keyedBy: BelongsToCollectionKeys.self, forKey: .belongs_to_collection)
        try belongsToCollection.encode(id_collection, forKey: .id)
        try belongsToCollection.encode(name_collection, forKey: .name)
        try belongsToCollection.encode(poster_path_collection, forKey: .poster_path)
        try belongsToCollection.encode(backdrop_path_collection, forKey: .backdrop_path)
    }
}

