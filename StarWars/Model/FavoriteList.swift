//
//  Favoritelist.swift
//  StarWars
//
//  Created by Mac on 5/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
class FavoriteList {
    static let shared = FavoriteList()
    var list : [People]
    private init(){
        self.list = [People]()
    }
    
}
