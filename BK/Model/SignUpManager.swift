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
    let SignUpURL = "http://localhost:3000/api/v1/"
    
    
    var delegate: SignUpManagerDelegate?
    
    func fetchSignUp(_ typeName: String) {
        let urlString = "\(SignUpURL)/\(typeName)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: {
                if $2 != nil {
                    self.delegate?.didFailWithError(error: $2!)
                    return
                }
                
                if let safeData = $0 {
                    if let SignUp = self.parseJSON(safeData) {
                        self.delegate?.didUpdateSignUp(self, SignUp: SignUp)
                    }
                }
            })
            task.resume()
        }
    }
    
    func parseJSON(_ signUpData: Data) -> [SignUpModel]? {
        let decoder = JSONDecoder()
        var movies = [SignUpModel]()
        do {
            let decodedData = try decoder.decode(Array<MovieData>.self, from: signUpData)
            for i in decodedData {
                movies.append(SignUpModel(externalId: i.tmdb_id, title: i.title, poster_path: i.poster_path,backdrop_path: i.backdrop_path, overview: i.overview, release_date: i.release_date, genre_ids: i.genre_ids))
            }
            return movies
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
