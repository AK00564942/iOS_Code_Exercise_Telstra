//
//  CustomImageView.swift
//  iOS_Code_Exercise_Telstra
//
//  Created by ANUJ KUMAR on 28/04/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import UIKit

 //MARK:- UIImageView Chache

let imageCache = NSCache<AnyObject,AnyObject>()

class CustomImageView:UIImageView
{
    var task:URLSessionDataTask!
    
    func loadImage(from url:URL)  {
        
   /*- UIImage Scrolling */
        
         image =  nil
        if let task = task
        {
          task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey:url.absoluteString as AnyObject) as? UIImage
        {
            self.image = imageFromCache
        }
        let task = URLSession.shared.dataTask(with:url) { (data,response,error) in
            guard let data = data, let newImage = UIImage(data:data) else {
            print("Could not load image from url:\(url)")
            return
        }
            imageCache.setObject(newImage, forKey:url.absoluteString as AnyObject)
            DispatchQueue.main.async {
            self.image = newImage
            }
    }
        task.resume()
}
}
