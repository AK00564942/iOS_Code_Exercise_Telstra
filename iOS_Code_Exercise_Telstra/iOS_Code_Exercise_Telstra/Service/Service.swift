//
//  detailsAPI.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 27/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import Foundation

final class Service
{
    static let shared = Service()
    func fetchDescAPI(completion: @escaping (Bool, List) -> Void) {
    let session = URLSession.shared
    let url = URL(string:"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
    let task = session.dataTask(with: url, completionHandler: { data, response, error in
        let str = String(decoding: data!, as: UTF8.self)
        let bar = str.folding(options: .diacriticInsensitive, locale: .current)
        if let data1 = bar.data(using: String.Encoding.utf8) {
            let list = try? JSONDecoder().decode(List.self, from: data1)
            print("Main Title " + list!.title!)
               for row:Rows in list!.rows {
                  if let value = row.description
                {
                    print("Sub-Description :" + value)
                }
            }
            if let allData = list {
                completion(true, allData)
            }
        }
    })
    task.resume()
}
}

