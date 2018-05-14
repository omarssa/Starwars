//
//  ViewController.swift
//  StarWars
//
//  Created by Mac on 5/9/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImage = UIImageView()
        bgImage.image = #imageLiteral(resourceName: "space")
        bgImage.contentMode = .scaleToFill 
        imageView.image = #imageLiteral(resourceName: "sw")
       
            collectionView.backgroundView = bgImage
        let width = (view.frame.size.width-20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 243)
        self.collectionView.dataSource = self
    self.collectionView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
 
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
private typealias collectionViewDataSource = FavoriteViewController
extension collectionViewDataSource : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavoriteList.shared.list.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath) as? MyCell else {fatalError("No Cell called cell")}
            let namesToShow = FavoriteList.shared.list[indexPath.row]
        if namesToShow.url.range(of: "https://swapi.co/api/vehicles/") != nil
        {cell.setupMyCell(with: MyUrls.getImageUrl(for: namesToShow.name), with: namesToShow.name, with: false,with: #imageLiteral(resourceName: "starwarsvehiclescollection") ,with: namesToShow.url)}
        else if namesToShow.url.range(of: "https://swapi.co/api/planets/") != nil
        {cell.setupMyCell(with: MyUrls.getImageUrl(for: namesToShow.name), with: namesToShow.name, with: false,with: #imageLiteral(resourceName: "swPlanets") ,with: namesToShow.url)}
        else if namesToShow.url.range(of: "https://swapi.co/api/starships/") != nil
        {cell.setupMyCell(with: MyUrls.getImageUrl(for: namesToShow.name), with: namesToShow.name, with: false,with: #imageLiteral(resourceName: "swStarships") ,with: namesToShow.url)}
        else
          {cell.setupMyCell(with: MyUrls.getImageUrl(for: namesToShow.name), with: namesToShow.name, with: false,with: #imageLiteral(resourceName: "sw") ,with: namesToShow.url)}
        return cell
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MyCell else {return}
        cell.unloadCell()
    }
}
private typealias collectionViewDelegate = FavoriteViewController
extension collectionViewDelegate : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let namesToShow = FavoriteList.shared.list[indexPath.row]
        if namesToShow.url.range(of: "https://swapi.co/api/people/") != nil{
            let storyBoard = UIStoryboard(name:"Main",bundle:nil)
            guard let svc =
                storyBoard.instantiateViewController(withIdentifier:  "people") as? PeopleViewController else {return}
            svc.characterUrl = namesToShow.url
            svc.imageUrl = MyUrls.getImageUrl(for: namesToShow.name)
            guard let navigationController = self.navigationController else {return}
            navigationController.show(svc, sender:nil)
        }
        
    }
   
    
}
