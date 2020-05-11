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
            Service.shared.getFacts { (list,error) in
                guard let dataReceived = list, let title = list?.title else {
                    // do nothing
                    return
                }
                self.title = title
                self.items = dataReceived.rows
            }
        }
    }
}
