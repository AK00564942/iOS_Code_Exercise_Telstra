//
//  detailsAPI.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 27/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import Foundation

final class detailsAPI
{
    static let shared = detailsAPI()
    
    func fetchDescAPI() {
        let session = URLSession.shared
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            //print(response?.mimeType!)
            let str = String(decoding: data!, as: UTF8.self)
            //print(str)
            
            let jsonData = str.data(using: .utf8)!
            let json = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            print(json)
            
            
        })
        task.resume()
    }
        
struct desc:Codable
{
       let title:[subdesc]
}

struct subdesc:Codable
{
       let subtitle:String?
       let description:String?
       let imageHref:String?
}

}
