//
//  URLS.swift
//  StarWars
//
//  Created by Mac on 5/11/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
class MyUrls {
   class func getPeoplePage(for number:Int)->String
    {
    return "https://swapi.co/api/people/?page="+String(number)
    }
    class func getImageUrl(for name:String)->String
    {
        let nameNoSpecialChar = name.folding(options: .diacriticInsensitive, locale: .current)
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_".characters)
        let readyName = String(nameNoSpecialChar.characters.filter {okayChars.contains($0) })
        return "https://raw.githubusercontent.com/sbassett1/swImages/master/"+readyName+".png"
    }
        
    
    func getVehicleList(for number:String)->String
    {
        return "https://swapi.co/api/vehicles/"+number+"/"
    }
    func getStarshipsList(for number:String)->String
    {
        return "https://swapi.co/api/starships/"+number+"/"
    }
    func getPlanetList(for number:String)->String
    {
        return "https://swapi.co/api/planets/"+number+"/"
    }
}
