//
//  CollectionViewCell.swift
//  StarWars
//
//  Created by Mac on 5/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import CoreData
class MyCell: UICollectionViewCell {
    
 

    @IBOutlet weak var favButton: UIButton!
    @IBOutlet private weak var myImageView:UIImageView!
        @IBOutlet private weak var labelName:UILabel!
var myUrl = ""
var myName = ""
        private var cellSession = URLSession(configuration: .default)
    func setupMyCell (with url:String, with name:String ,with favorite :Bool,with myImage:UIImage,with navigationUrl:String){
       myUrl = navigationUrl
        myName = name
//        let size = myImageView.sizeThatFits(myImage.size)
//        let resizedImage = resizeImage(image: myImage, targetSize: size)
         myImageView.contentMode = .scaleAspectFit
            myImageView.image = myImage
            labelName.text = name
            favButton.setImage(#imageLiteral(resourceName: "heartu"), for: .normal)
            cellSession = URLSession (configuration: .default)
            NetworkService.getImage(from: url,session: cellSession) {
                [weak self](error, image) in
                if let _ = error {
                    
                    return

                }
                guard let image = image else {
                    return }
                
                DispatchQueue.main.async {
                    let size = self?.myImageView.sizeThatFits((image.size))
                    let resizedImage = resizeImage(image: image, targetSize: size!)
                    self?.myImageView.contentMode = .scaleAspectFit
                    self?.myImageView?.image = resizedImage
                    
                }
                
            }
        let p = People(name:(self.myName),url:(self.myUrl))
        let isFavorite = FavoriteList.shared.list.contains {
            $0.name == p.name}
        if isFavorite {
            self.favButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        }
        }

    func unloadCell(){
        cellSession.invalidateAndCancel()
    }
   
  
    @IBAction func favortise(_ sender: UIButton) {
        //favButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        
        let p = People(name:myName,url:myUrl)
        let isFavorite = FavoriteList.shared.list.contains {$0.name == p.name && $0.url == p.url}
        if isFavorite{
            favButton.setImage(#imageLiteral(resourceName: "heartu"), for: .normal)
            FavoriteList.shared.list = FavoriteList.shared.list.filter(){
                $0.name != p.name && $0.url != p.url
            }
          deleteFav(p)
        }
        else {
              favButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
             FavoriteList.shared.list.append(p)
            saveFav(p)
        }
        
       print(FavoriteList.shared.list)
        
    }
    
}
    

