//
//  TVDetailed.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 02/08/21.
//

import Foundation

struct TVDetailed: Codable {
    // First Level JSON
    var backdrop_path : String
    var first_air_date : String
    var homepage : String
    var id : Int
    var in_production : Bool
    var last_air_date : String
    var name : String?
    var number_of_episodes : Int
    var number_of_seasons : Int
    var original_language : String
    var original_name : String
    var overview : String
    var popularity : Double
    var poster_path : String?
    var status : String
    var tagline : String
    var type : String
    var vote_average : Double
    var vote_count : Int
    
    // 'last_episode_to_air' object
    var id_last_episode : Int?
    var air_date_last_episode : String?
    var episode_number_last_episode : Int?
    var name_last_episode : String?
    var overview_last_episode : String?
    var production_code_last_episode : String?
    var season_number_last_episode : Int?
    var still_path_last_episode : Int?
    var vote_average_last_episode : Double?
    var vote_count_last_episode : Int?
    
    // 'next_episode_to_air' object
    var id_next_episode : Int?
    var air_date_next_episode : String?
    var episode_number_next_episode : Int?
    var name_next_episode : String?
    var overview_next_episode : String?
    var production_code_next_episode : String?
    var season_number_next_episode : Int?
    var still_path_next_episode : Int?
    var vote_average_next_episode : Double?
    var vote_count_next_episode : Int?
    
    
    enum CodingKeys: String, CodingKey {
        case backdrop_path,
             first_air_date,
             homepage,
             id,
             in_production,
             last_air_date,
             last_episode_to_air,
             next_episode_to_air,
             name,
             number_of_episodes,
             number_of_seasons,
             original_language,
             original_name,
             overview,
             popularity,
             poster_path,
             status,
             tagline,
             type,
             vote_average,
             vote_count
    }
    
    enum LastEpisodeToAir: CodingKey{
        case id,
             air_date,
             episode_number,
             name,
             overview,
             production_code,
             season_number,
             vote_average,
             vote_count

    }
    
    enum NextEpisodeToAir: CodingKey{
        case id,
             air_date,
             episode_number,
             name,
             overview,
             production_code,
             season_number,
             vote_average,
             vote_count
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // First Level JSON
        backdrop_path = try container.decode(String.self, forKey: .backdrop_path)
        first_air_date = try container.decode(String.self, forKey: .first_air_date)
        homepage = try container.decode(String.self, forKey: .homepage)
        id = try container.decode(Int.self, forKey: .id)
        in_production = try container.decode(Bool.self, forKey: .in_production)
        last_air_date = try container.decode(String.self, forKey: .last_air_date)
        name = try container.decode(String.self, forKey: .name)
        number_of_episodes = try container.decode(Int.self, forKey: .number_of_episodes)
        number_of_seasons = try container.decode(Int.self, forKey: .number_of_seasons)
        original_language = try container.decode(String.self, forKey: .original_language)
        original_name = try container.decode(String.self, forKey: .original_name)
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        poster_path = try container.decode(String.self, forKey: .poster_path)
        status = try container.decode(String.self, forKey: .status)
        tagline = try container.decode(String.self, forKey: .tagline)
        type = try container.decode(String.self, forKey: .type)
        vote_average = try container.decode(Double.self, forKey: .vote_average)
        vote_count = try container.decode(Int.self, forKey: .vote_count)
        
        // 'last_episode_to_air' object
        if let lastEpisodeToAir = try? container.nestedContainer(keyedBy: LastEpisodeToAir.self, forKey: .last_episode_to_air){
            id_last_episode = try lastEpisodeToAir.decode(Int.self, forKey: .id)
            air_date_last_episode = try lastEpisodeToAir.decode(String.self, forKey: .air_date)
            episode_number_last_episode = try lastEpisodeToAir.decode(Int.self, forKey: .episode_number)
            name_last_episode = try lastEpisodeToAir.decode(String.self, forKey: .name)
            overview_last_episode = try lastEpisodeToAir.decode(String.self, forKey: .overview)
            production_code_last_episode = try lastEpisodeToAir.decode(String.self, forKey: .production_code)
            season_number_last_episode = try lastEpisodeToAir.decode(Int.self, forKey: .season_number)
            vote_average_last_episode = try lastEpisodeToAir.decode(Double.self, forKey: .vote_average)
            vote_count_last_episode = try lastEpisodeToAir.decode(Int.self, forKey: .vote_count)
        }
        
        // 'next_episode_to_air' object
        if let nextEpisodeToAir = try? container.nestedContainer(keyedBy: NextEpisodeToAir.self, forKey: .next_episode_to_air){
            id_next_episode = try nextEpisodeToAir.decode(Int.self, forKey: .id)
            air_date_next_episode = try nextEpisodeToAir.decode(String.self, forKey: .air_date)
            episode_number_next_episode = try nextEpisodeToAir.decode(Int.self, forKey: .episode_number)
            name_next_episode = try nextEpisodeToAir.decode(String.self, forKey: .name)
            overview_next_episode = try nextEpisodeToAir.decode(String.self, forKey: .overview)
            production_code_next_episode = try nextEpisodeToAir.decode(String.self, forKey: .production_code)
            season_number_next_episode = try nextEpisodeToAir.decode(Int.self, forKey: .season_number)
            vote_average_next_episode = try nextEpisodeToAir.decode(Double.self, forKey: .vote_average)
            vote_count_next_episode = try nextEpisodeToAir.decode(Int.self, forKey: .vote_count)
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(backdrop_path, forKey: .backdrop_path)
        try container.encode(first_air_date, forKey: .first_air_date)
        try container.encode(homepage, forKey: .homepage)
        try container.encode(id, forKey: .id)
        try container.encode(in_production, forKey: .in_production)
        try container.encode(last_air_date, forKey: .last_air_date)
        try container.encode(name, forKey: .name)
        try container.encode(number_of_episodes, forKey: .number_of_episodes)
        try container.encode(number_of_seasons, forKey: .number_of_seasons)
        try container.encode(original_language, forKey: .original_language)
        try container.encode(original_name, forKey: .original_name)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(poster_path, forKey: .poster_path)
        try container.encode(status, forKey: .status)
        try container.encode(tagline, forKey: .tagline)
        try container.encode(type, forKey: .type)
        try container.encode(vote_average, forKey: .vote_average)
        try container.encode(vote_count, forKey: .vote_count)
        
        var lastEpisodeToAir = container.nestedContainer(keyedBy: LastEpisodeToAir.self, forKey: .last_episode_to_air)
        try lastEpisodeToAir.encode(id_last_episode, forKey: .id)
        try lastEpisodeToAir.encode(air_date_last_episode, forKey: .air_date)
        try lastEpisodeToAir.encode(episode_number_last_episode, forKey: .episode_number)
        try lastEpisodeToAir.encode(name_last_episode, forKey: .name)
        try lastEpisodeToAir.encode(overview_last_episode, forKey: .overview)
        try lastEpisodeToAir.encode(production_code_last_episode, forKey: .production_code)
        try lastEpisodeToAir.encode(season_number_last_episode, forKey: .season_number)
        try lastEpisodeToAir.encode(vote_average_last_episode, forKey: .vote_average)
        try lastEpisodeToAir.encode(vote_count_last_episode, forKey: .vote_count)
        
        var nextEpisodeToAir = container.nestedContainer(keyedBy: NextEpisodeToAir.self, forKey: .next_episode_to_air)
        try nextEpisodeToAir.encode(id_next_episode, forKey: .id)
        try nextEpisodeToAir.encode(air_date_next_episode, forKey: .air_date)
        try nextEpisodeToAir.encode(episode_number_next_episode, forKey: .episode_number)
        try nextEpisodeToAir.encode(name_next_episode, forKey: .name)
        try nextEpisodeToAir.encode(overview_next_episode, forKey: .overview)
        try nextEpisodeToAir.encode(production_code_next_episode, forKey: .production_code)
        try nextEpisodeToAir.encode(season_number_next_episode, forKey: .season_number)
        try nextEpisodeToAir.encode(vote_average_next_episode, forKey: .vote_average)
        try nextEpisodeToAir.encode(vote_count_next_episode, forKey: .vote_count)
    }
}

