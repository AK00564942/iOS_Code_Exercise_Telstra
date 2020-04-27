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
        let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        let url = URL(string:urlString)!
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with:request) {(data,resp,error) in
        guard let data = data else {
            print("data was nil")
            return
         }
            guard let ListItem = try? JSONDecoder().decode(desc.self, from:data) else {
                print("could not decode json")
                return
            }
            print(ListItem.title)
        }
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
