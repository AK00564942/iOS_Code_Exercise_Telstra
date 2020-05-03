//
//  DetailsViewModel.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 30/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import Foundation

class DetailsViewModel
{
    var title:String?
    var description:String?
    var imageHref:String?
    // Dependency Injection
  init(details:Rows) {
    self.title = details.title
    self.description = details.description
    self.imageHref = details.imageHref
    }
}
