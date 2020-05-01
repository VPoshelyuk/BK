//
//  SignUpMnager.swift
//  BK
//
//  Created by Slava Pashaliuk on 4/18/20.
//  Copyright © 2020 Viachaslau Pashaliuk. All rights reserved.
//

import Foundation

protocol SignUpManagerDelegate {
    func didUpdateSignUp(_ SignUpManager: SignUpManager, SignUp: [SignUpModel])
    func didFailWithError(error: Error)
}

struct SignUpManager {
    let SignUpURL = "https://preference-api.herokuapp.com/api/v1/"
    
    
    var delegate: SignUpManagerDelegate?
    
    var count = 0
    
    mutating func fetchSignUp(_ typeNames: Array<String>) {
        count = typeNames.count
        for typeName in typeNames {
            let urlString = "\(SignUpURL)/\(typeName)"
            performRequest(with: urlString, typeName: typeName)
        }
    }
    
    func performRequest(with urlString: String, typeName: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: {
                if $2 != nil {
                    self.delegate?.didFailWithError(error: $2!)
                    return
                }
                
                if let safeData = $0 {
                    if let SignUp = self.parseJSON(safeData, typeName: typeName) {
                        self.delegate?.didUpdateSignUp(self, SignUp: SignUp)
                    }
                }
            })
            task.resume()
        }
    }
    
    func parseJSON(_ signUpData: Data, typeName: String) -> [SignUpModel]? {
        let decoder = JSONDecoder()
        var interest = [SignUpModel]()
        do {
            switch typeName {
            case "movies":
                let decodedData = try decoder.decode(Array<MovieData>.self, from: signUpData)
                for i in decodedData {
                    interest.append(SignUpModel(externalId: i.tmdb_id, title: i.title, poster_path: i.poster_path,backdrop_path: i.backdrop_path, overview: i.overview, release_date: i.release_date, genre_ids: i.genre_ids))
                }
            case "tvshows":
                let decodedData = try decoder.decode(Array<ShowData>.self, from: signUpData)
                for i in decodedData {
                    interest.append(SignUpModel(externalId: i.tmdb_id, title: i.name, poster_path: i.poster_path,backdrop_path: i.backdrop_path, overview: i.overview, release_date: i.first_air_date, genre_ids: i.genre_ids))
                }
//            case "games":
//                let decodedData = try decoder.decode(Array<ShowData>.self, from: signUpData)
//                for i in decodedData {
//                    interest.append(SignUpModel(externalId: i.tmdb_id, title: i.name, poster_path: i.poster_path,backdrop_path: i.backdrop_path, overview: i.overview, release_date: i.first_air_date, genre_ids: i.genre_ids))
//                }
            default:
                print("Error occurred")
            }
            return interest
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
