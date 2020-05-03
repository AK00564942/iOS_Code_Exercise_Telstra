//
//  detailsAPI.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 27/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import Foundation

/** fetch URL */
fileprivate let kDataUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
final class Service
{
    static let shared = Service()
    /** Call this function to fetch data from server */
    func fetchDescAPI(completion: @escaping (List) -> Void) {
    let session = URLSession.shared
    let url = URL(string:kDataUrl)!
    let task = session.dataTask(with: url, completionHandler: { data, response, error in
        guard let data = data, error == nil else {return}
        let responseStr = String(decoding: data, as: UTF8.self)
        let bar = responseStr.folding(options: .diacriticInsensitive, locale: .current)
        if let responseData = bar.data(using: String.Encoding.utf8) {
            let responselist = try? JSONDecoder().decode(List.self, from: responseData)
               for row:Rows in responselist!.rows {
                  if let value = row.description
                {
                    print("Sub-Description :" + value)
                }
            }
            if let allData = responselist {
                completion(allData)
            }
        }
    })
    task.resume()
}
    
}

