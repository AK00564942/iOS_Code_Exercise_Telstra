//
//  DetailsViewModel.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 30/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsViewModelDelegate: class {
    func serverDataUpdated()
}

final class DetailsViewModel {
    public weak var delegate: DetailsViewModelDelegate?
    
    var title:String = ""
    var items: [Rows] = [] {
        didSet {
            delegate?.serverDataUpdated()
        }
    }
    var cache:NSCache<NSString, UIImage> = NSCache()
    
    func getDataFromServer() {
        DispatchQueue.main.async {
            Service.shared.fetchDataForServer{ (data) in
                guard let dataReceived = data, let title = data?.title else {
                    // do nothing
                    return
                }
                self.title = title
                self.items = dataReceived.rows
            }
        }
    }
    
    func obtainImageWithPath(imagePath: String, completionHandler: @escaping (UIImage?) -> Void)
    {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            Service.shared.obtainImageDataWithPath(imagePath: imagePath, completionHandler: {(data) in
                guard let imageData = data else {
                    return
                }
                if let image = UIImage(data: imageData) {
                    self.cache.setObject(image, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
            })
        }
      }
   }
