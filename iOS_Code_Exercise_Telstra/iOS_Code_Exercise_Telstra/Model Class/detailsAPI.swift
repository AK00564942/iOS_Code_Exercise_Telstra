//
//  detailsAPI.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 27/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import Foundation


final class AmiiboAPI {
    

   static let shared = AmiiboAPI()
    
    func fetchAmiiboList(onCompletion: @escaping ([Amiibo]) -> ()) {
    let urlString =  "http://www.amiiboapi.com/api/amiibo"
    let url = URL(string:urlString)!
    let task = URLSession.shared.dataTask(with:url) {(data,resp,error) in
    guard let data = data else {
    print("data was nil")
    return
    }
        guard let amiiboList = try?JSONDecoder().decode(Desc.self,from:data) else {
            print("Could not decode json")
            return
    }
        onCompletion(amiiboList.amiibo)
  }
        task.resume()
}
}
struct Desc: Codable
{
    let amiibo : [Amiibo]
}
        
struct Amiibo: Codable
{
    let gameSeries:String?
    let image:String?
    let name:String?
}

