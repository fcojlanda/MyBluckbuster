//
//  ServicesManager.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 27/07/21.
//

import Foundation

class ServicesManager {
    private var connection : ConnectionManager?
    private var path : String?
    private var language : String?
    
    static var shared: ServicesManager = {
        let instance = ServicesManager()
        instance.connection = ConnectionManager()
        instance.path = ""
        instance.language = "es-MX"
        return instance
    }()
    
    func getListContent (typeContent: TypeContent, filter: FitlerContent, whenFinish: @escaping (Bool, [Any]?, Error?) -> Void){
        path = "/discover/" + typeContent.description() + "?api_key=APIKEY&language=\(language! + filter.getFilterQuery())"
        
        ConnectionManager.shared.APIRequest(to: path!, of: .GET, whenFinish: { (status, data, error) -> Void in
            
            if data != nil {
                if let json : [String: Any] = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    var arrayContent : [Any]?
                    
                    switch typeContent {
                    case .Movie:
                        arrayContent = self.decodeResponse(json: json, typeContent: .Movie)
                        break
                    case .TVShows:
                        arrayContent = self.decodeResponse(json: json, typeContent: .TVShows)
                        break
                    default:
                        arrayContent = []
                        break
                    }
                    whenFinish(true, arrayContent, nil)
                }else{
                    whenFinish(false, nil, error)
                }
            }else{
                whenFinish(false, nil, error)
            }
        })
    }
    
    func getDetailContent(idContent: Int, typeContent: TypeContent, whenFinish: @escaping (Bool, Any?, Error?) -> Void){
        switch typeContent {
        case .Movie:
            path = "/movie/"
            break
        case .TVShows:
            path = "/tv/"
            break
        default:
            path = "NA"
            break
        }
        path! += "\(idContent)?api_key=APIKEY&language=\(language!)"
        
        ConnectionManager.shared.APIRequest(to: path!, of: .GET, whenFinish: { (status, data, error) -> Void in
            
            if data != nil {
                if let json : [String: Any] = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    let arrayContent = self.decodeResponse(json: json, typeContent: typeContent, isDetailed: true)
                    whenFinish(true, arrayContent.first, nil)
                }else{
                    whenFinish(false, nil, error)
                }
            }else{
                whenFinish(false, nil, error)
            }
        })
    }
    
    private func decodeResponse(json: [String: Any], typeContent: TypeContent, isDetailed: Bool = false) -> [Any]{
        var arrayContent = [Any]()
        if (isDetailed){
            do {
                let contentData = try JSONSerialization.data(withJSONObject: json, options: [])
                let decoder = JSONDecoder()
                switch typeContent {
                case .Movie:
                    let movieObject = try decoder.decode(MovieDetailed.self, from: contentData)
                    arrayContent.append(movieObject)
                    break
                case .TVShows:
                    let tvObject = try decoder.decode(TVDetailed.self, from: contentData)
                    arrayContent.append(tvObject)
                    break
                default:
                    break
                }
            }catch let errorDecoder {
                print(errorDecoder)
            }
        }else{
            if let contents = json["results"] as? [[String: Any]] {
                do {
                    for content in contents {
                        let movieData = try JSONSerialization.data(withJSONObject: content, options: [])
                        let decoder = JSONDecoder()
                        switch typeContent {
                        case .Movie:
                            let movieObject = try decoder.decode(Movie.self, from: movieData)
                            arrayContent.append(movieObject)
                            break
                        case .TVShows:
                            let tvObject = try decoder.decode(TV.self, from: movieData)
                            arrayContent.append(tvObject)
                            break
                        default:
                            break
                        }
                    }
                }catch let errorDecoder {
                    print(errorDecoder)
                }
            }else{
                
            }
        }
        
        return arrayContent
    }
}
