
//
//  Network Service.swift
//  StarWars
//
//  Created by Mac on 5/11/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
enum NetworkingErrors :Error{
    case badUrl
    case badResponse
    case emptyUrl
    case incorrectFormat(String)
}
class NetworkService {
class func getImage(from url:String,session:URLSession,completion:@escaping(Error?,UIImage?)->()){
    
    if let image = ImageCache.shared.images.object(forKey: url as NSString){
        completion(nil,image)
        return
    }
    guard let ourUrl = URL(string: url)else{
        completion(NetworkingErrors.badUrl,nil)
        return
    }
    let task = session.dataTask(with: ourUrl) { (data, response, error) in
        if let error = error{
            completion(error,nil)
            return
        }
        guard let httpstatus = (response as? HTTPURLResponse)?.statusCode else {return}
        guard 200...205 ~= httpstatus else {
            completion(NetworkingErrors.badResponse,nil)
            return
        }
        guard let data = data else{
            completion(NetworkingErrors.emptyUrl,nil)
            return
        }
        guard let image = UIImage(data: data)
            else{
                completion(NetworkingErrors.incorrectFormat("UIImage"),nil)
                return
        }
        ImageCache.shared.images.setObject(image, forKey: url as NSString)
        completion(nil,image)
    }
    task.resume()
}
    class func getImageNoSession(from url:String,completion:@escaping(Error?,UIImage?)->()){
        
    
        guard let ourUrl = URL(string: url)else{
            completion(NetworkingErrors.badUrl,nil)
            return
        }
         let session:URLSession = .shared
        let task = session.dataTask(with: ourUrl) { (data, response, error) in
            if let error = error{
                completion(error,nil)
                return
            }
            guard let httpstatus = (response as? HTTPURLResponse)?.statusCode else {return}
            guard 200...205 ~= httpstatus else {
                completion(NetworkingErrors.badResponse,nil)
                return
            }
            guard let data = data else{
                completion(NetworkingErrors.emptyUrl,nil)
                return
            }
            guard let image = UIImage(data: data)
                else{
                    completion(NetworkingErrors.incorrectFormat("UIImage"),nil)
                    return
            }
            completion(nil,image)
        }
        task.resume()
    }
class func getNameAtPath(from url:String,completion:@escaping(Error?,StarWarsList?)->()){
    
    guard let ourUrl = URL(string: url)else{
        completion(NetworkingErrors.badUrl,nil)
        return
    }
    let session:URLSession = .shared
    let task = session.dataTask(with: ourUrl) { (data, response, error) in
        if let error = error{
            completion(error,nil)
            return
        }
        guard let httpstatus = (response as? HTTPURLResponse)?.statusCode else {return}
        guard 200...205 ~= httpstatus else {
            completion(NetworkingErrors.badResponse,nil)
            return
        }
        guard let data = data else{
            completion(NetworkingErrors.emptyUrl,nil)
            return
        }
        do{
       //let jsonObj = try JSONSerialization.jsonObject(with: data)as?[String:Any]
       let sw = try JSONDecoder().decode(StarWarsList.self, from: data)
            completion(nil,sw)
        }
        catch{
            print("Error Parsing")
        }
    }
    task.resume()
}
    class func getName(_ completionHandler: @escaping (Error?,StarWarsList?) -> Void) {
        getNameAtPath(from: "https://swapi.co/api/people/?page=1", completion: completionHandler)
    }
    class func getStarship(_ completionHandler: @escaping (Error?,StarWarsList?) -> Void) {
        getNameAtPath(from: "https://swapi.co/api/starships/?page=1", completion: completionHandler)
    }
    class func getPlanet(_ completionHandler: @escaping (Error?,StarWarsList?) -> Void) {
        getNameAtPath(from: "https://swapi.co/api/planets/?page=1", completion: completionHandler)
    }
    class func getVehicle(_ completionHandler: @escaping (Error?,StarWarsList?) -> Void) {
        getNameAtPath(from: "https://swapi.co/api/vehicles/?page=1", completion: completionHandler)
    }
    class func getMoreNames(_ wrapper: StarWarsList?, completionHandler: @escaping (Error?,StarWarsList?) -> Void) {
        guard let nextURL = wrapper?.next else {
            completionHandler(NetworkingErrors.badUrl,nil)
            return
        }
        getNameAtPath(from:nextURL, completion: completionHandler)
    }
    class func getCharacterDetails(from url:String,completion:@escaping(Error?,SwCharacters?)->()){
        
        guard let ourUrl = URL(string: url)else{
            completion(NetworkingErrors.badUrl,nil)
            return
        }
        let session:URLSession = .shared
        let task = session.dataTask(with: ourUrl) { (data, response, error) in
            if let error = error{
                completion(error,nil)
                return
            }
            guard let httpstatus = (response as? HTTPURLResponse)?.statusCode else {return}
            guard 200...205 ~= httpstatus else {
                completion(NetworkingErrors.badResponse,nil)
                return
            }
            guard let data = data else{
                completion(NetworkingErrors.emptyUrl,nil)
                return
            }
            do{
                //let jsonObj = try JSONSerialization.jsonObject(with: data)as?[String:Any]
                let sw = try JSONDecoder().decode(SwCharacters.self, from: data)
                completion(nil,sw)
            }
            catch{
                print("Error Parsing")
            }
        }
        task.resume()
    }
}

