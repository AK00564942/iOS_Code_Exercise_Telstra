//
//  detailsAPI.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 27/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import Foundation

final class Service {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    private let baseURLString =  "https://dl.dropboxusercontent.com/"
    private let append = "s/2iodh4vg0eortkl/append.json"
    
    static public let shared: Service = Service()
    
    func getFacts(completion: @escaping (List?, Error?) -> Void) {
        let urlString = baseURLString + append
        let session = URLSession.shared
        guard let url = URL(string:urlString)
            else { fatalError() }
        
        session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                return
            }
            let movies = try! JSONDecoder().decode(List.self, from:modifiedDataInUTF8Format)
            completion(movies, nil)
        }.resume()
    }
}


