//
//  Starwarslist.swift
//  StarWars
//
//  Created by Mac on 5/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
struct StarWarsList:Codable
{
    var next : String?
    var results : [People]?
    var count : Int
    
    enum CodingKeys:String,CodingKey
    {
        case results
        case next
        case count
    }
  
}
struct People :Codable {
    var name : String
    var url : String
}
struct SwCharacters:Codable
{
    var name : String
    var height : String
    var mass : String
    var hairColor :String
    var skinColor: String
    var eyeColor : String
    var birthYear : String
    var gender:String
    var homeworld:String
    var films:[String]
    var species:[String]
    var vehicles:[String]
    var starships:[String]
    
    enum CodingKeys:String,CodingKey
    {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        case homeworld
        case films
        case species
        case vehicles
        case starships
    }
}
