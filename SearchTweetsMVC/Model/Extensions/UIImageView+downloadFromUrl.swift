//
//  AppExtensions.swift
//  Test_Jeebley
//
//  Created by Shibili Areekara on 30/10/18.
//  Copyright © 2018 Shibili Areekara. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /// Load image from url String
    func loadImageFromUrl(urlString: String) {
        guard let url:URL = URL(string: urlString) else { return }
        
        self.loadImageFromUrl(url: url)
    }
    
    /// Load image from Url
    func loadImageFromUrl(url: URL) {
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            
            self.roundedCorners()
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                print("ImageDownload Error : \(error?.localizedDescription ?? "")")
                return
            }
            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: data!) {
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
                    self?.image = imageToCache
                    
                    self?.roundedCorners()
                }
            }
        }).resume()
    }
}

private extension UIView
{
    func roundedCorners(cRadius:CGFloat = 5.0) {
        self.layer.cornerRadius = cRadius
        layer.masksToBounds = true
    }
}
