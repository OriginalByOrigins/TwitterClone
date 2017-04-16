//
//  Service.swift
//  TwitterClone
//
//  Created by Thai Cao Ngoc on 16/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import TRON
import SwiftyJSON

class Service {
    
    static let sharedInsance = Service()
    
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")
    
    func fetchHomeFeed(completion: @escaping (FetchedData?, Error?) -> ()) {
        
        let request: APIRequest<FetchedData, FetchedError> = tron.request("/twitter/home")
        
        request.perform(withSuccess: { (fetchedData) in
            completion(fetchedData, nil)
        }) { (fetchedError) in
            completion(nil, fetchedError)
        }?.response(completionHandler: { (defaultDataResponse) in
            self.tron.manager.session.invalidateAndCancel()
        })
    }
}

extension Service {
    
    class FetchedData: JSONDecodable {
        
        let users: [User]
        let tweets: [Tweet]
        
        required init(json: JSON) throws {
            
            guard
                let userDictionaries = json["users"].array,
                let tweetDictionaries = json["tweets"].array else {
                    throw NSError(domain: "com.letsbuildthatapp", code: 200, userInfo: [NSLocalizedDescriptionKey: "Invalid parsed data"])
            }
            
            self.users = userDictionaries.map{User(json: $0)}
            self.tweets = tweetDictionaries.map{Tweet(json: $0)}
        }
    }

    class FetchedError: JSONDecodable {
        
        required init(json: JSON) throws {
        }
    }
}
