//
//  ImageCache.swift
//  StarWars
//
//  Created by Mac on 5/11/18.
//  Copyright © 2018 Mac. All rights reserved.
//


import UIKit

class ImageCache {
    static let shared = ImageCache()
    var images:NSCache<NSString,UIImage>
    private init(){
        self.images = NSCache<NSString,UIImage>()
    }
    
}
