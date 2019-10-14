//
//  API.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-11.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import Foundation

class API {
    static var shared = API()
    enum Endpoint {
        case articles
        var url:URL {
            switch self {
            case .articles: return URL(string: "https://gist.githubusercontent.com/tomasgreen/938b0bc00e1ba2833a1743eb805faaf0/raw/2391658f44dd5a197487451ae29f487ce88e93be/articlesWithComments.json")!
            }
        }
    }
    func getArticles(_ completionHandler: @escaping ([Article]?) -> ()) {
        URLSession.shared.dataTask(with: Endpoint.articles.url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil)
                return
            }
            do {
                //print(String(data: data, encoding: .utf8))
                let response = try JSONDecoder().decode([Article].self, from: data)
                DispatchQueue.main.async {
                    completionHandler(response)
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
            
        }.resume()
    }
}
