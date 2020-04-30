//
//  DetailsModel.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 30/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import Foundation

// This model used to data to pass in ViewModel

struct List:Codable
{
    let title:String?
    var rows:[Rows]
}

struct Rows:Codable
{
       let title:String?
       let description:String?
       let imageHref:String?
}
