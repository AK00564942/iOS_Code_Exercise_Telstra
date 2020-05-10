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
    
    func fetchDataForServer( completionHandler: @escaping (List?) -> Void) {
        let urlString = baseURLString + append
        guard let url = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: urlRequest.url!) { data, response, error in
            var dataReceived:List?
            
            defer {
                self.dataTask = nil
                completionHandler(dataReceived)
            }
            
            if let error = error {
                print("[API] Request failed with error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("[API] equest returned an invalid response")
                return
            }
            
            guard response.statusCode == 200 else {
                print("[API] Request returned an unsupported status code: \(response.statusCode)")
                return
            }
            
            let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                return
            }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(List.self, from: modifiedDataInUTF8Format)
                dataReceived = model
            } catch {
                print("[API] Decoding failed with error: \(error)")
            }
        }
        dataTask?.resume()
    }
    
    func obtainImageDataWithPath(imagePath: String, completionHandler: @escaping (Data?) -> Void) {
            let url: URL! = URL(string: imagePath)
        let task = defaultSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completionHandler(data)
        }
        task.resume()
    }
}

  
