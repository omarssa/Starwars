//
//  functions.swift
//  StarWars
//
//  Created by Mac on 5/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import UIKit
import CoreData
func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}
func saveFav(_ people :People){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "List", in: context)
    let newUser = NSManagedObject(entity: entity!, insertInto: context)
    newUser.setValue(people.url, forKey: "url")
    newUser.setValue(people.name, forKey: "name")
    do {
        try context.save()
        
    }
    catch {
    print("Failed saving")
}
}
func fetchFav(){
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
let request = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
    request.returnsObjectsAsFaults = false
do {
   let arrayOfObject = try context.fetch(request) as! [List]
    for object in arrayOfObject {
        let p = People(name:object.name!,url:object.url!)
        FavoriteList.shared.list.append(p)
    }
    

} catch {
    print("Failed")
    }
}
func deleteFav(_ people:People){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
    request.returnsObjectsAsFaults = false
    do {
        let arrayOfObject = try context.fetch(request) as! [List]
        for object in arrayOfObject {
            if people.name==object.name!{
                print("Deleted here",people.name ,object.name!)
                context.delete(object)
                try context.save()
            }
        }
        
        
    } catch {
        print("Failed")
    }
}
