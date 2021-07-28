//
//  ServicesManager.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 27/07/21.
//

import Foundation

class ServicesManager {
    private var connection : ConnectionManager?
    
    static var shared: ServicesManager = {
        let instance = ServicesManager()
        instance.connection = ConnectionManager()
        return instance
    }()
    
    func getMovies (to path: String, whenFinish: @escaping (Bool, [Any]?, Error?) -> Void){
        ConnectionManager.shared.APIRequest(to: path, of: .GET, whenFinish: { (status, data, error) -> Void in
            
            if data != nil {
                if let json : [String: Any] = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    let arrayMovies = self.decodeResponse(json: json, typeContent: .Movie)
                    whenFinish(true, arrayMovies, nil)
                }else{
                    whenFinish(false, nil, error)
                }
            }else{
                whenFinish(false, nil, error)
            }
        })
    }
    
    func getTVShows (to path: String, whenFinish: @escaping (Bool, [Any]?, Error?) -> Void){
        ConnectionManager.shared.APIRequest(to: path, of: .GET, whenFinish: { (status, data, error) -> Void in
            
            if data != nil {
                if let json : [String: Any] = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    let arrayTVShows = self.decodeResponse(json: json, typeContent: .TVShows)
                    whenFinish(true, arrayTVShows, nil)
                }else{
                    whenFinish(false, nil, error)
                }
            }else{
                whenFinish(false, nil, error)
            }
        })
    }
    
    private func decodeResponse(json: [String: Any], typeContent: TypeContent) -> [Any]{
        var arrayContent = [Any]()
        if let contents = json["results"] as? [[String: Any]] {
            do {
                for content in contents {
                    let movieData = try JSONSerialization.data(withJSONObject: content, options: [])
                    let decoder = JSONDecoder()
                    if typeContent == .Movie {
                        let movieObject = try decoder.decode(Movie.self, from: movieData)
                        arrayContent.append(movieObject)
                    }else{
                        let tvObject = try decoder.decode(TV.self, from: movieData)
                        arrayContent.append(tvObject)
                    }
                }
            }catch let errorDecoder {
                
            }
        }else{
            
        }
        return arrayContent
    }
}
