//
//  ViewController.swift
//  StarWars
//
//  Created by Mac on 5/9/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class VViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var speople = [People]()
    var pages=1
    var nextPage :String? = "Initail"
    var isLoading = false
    var wrapper :StarWarsList?
    var index :Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImage = UIImageView()
        bgImage.image = #imageLiteral(resourceName: "space")
        bgImage.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "sw")
        if (index==0)
        {
            collectionView.backgroundView = bgImage}
        let width = (view.frame.size.width-20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 243)
        loadFirstNames()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadFirstNames() {
        isLoading = true
        NetworkService.getVehicle{ error,result in
            if let _ = error {
                // TODO: improved error handling
                self.isLoading = false
            }
            let wrapper = result
            self.addNamesFromWrapper(wrapper)
            self.isLoading = false
            DispatchQueue.main.sync {
                self.collectionView?.reloadData()
            }
            
        }
    }
    
    func loadMoreNames() {
        self.isLoading = true
        let people = self.speople
        let wrapper = self.wrapper
        let totalNamesCount = wrapper?.count
        if (people.count < totalNamesCount!){
            // there are more species out there!
            NetworkService.getMoreNames(wrapper) {(error,result) in
                if let _ = error  {
                    return
                    
                }
                let moreWrapper = result
                self.addNamesFromWrapper(moreWrapper)
                self.isLoading = false
                DispatchQueue.main.sync {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    func addNamesFromWrapper(_ wrapper: StarWarsList?) {
        self.wrapper = wrapper!
        if self.speople.count == 0 {
            self.speople = (self.wrapper?.results!)!
        } else if self.wrapper != nil && self.wrapper?.results != nil {
            self.speople = self.speople + self.wrapper!.results!
        }
    }
    //    class func changeCase(to number :Int)
    //    {
    //        index = number
    //    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
private typealias collectionViewDataSource = VViewController
extension collectionViewDataSource : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return speople.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath) as? MyCell else {fatalError("No Cell called cell")}
        
        if  speople.count >= indexPath.row {
            let namesToShow = speople[indexPath.row]
            
            cell.setupMyCell(with: MyUrls.getImageUrl(for: namesToShow.name), with: namesToShow.name, with: false,with :#imageLiteral(resourceName: "starwarsvehiclescollection") ,with: namesToShow.url)
            // See if we need to load more species
            let rowsToLoadFromBottom = 5;
            let rowsLoaded = speople.count
            if (!self.isLoading && (indexPath.row >= (rowsLoaded - rowsToLoadFromBottom))) {
                let totalRows = self.wrapper?.count ?? 0
                let remainingNamesToLoad = totalRows - rowsLoaded;
                if (remainingNamesToLoad > 0) {
                    self.loadMoreNames()
                }
            }
        }
        
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
private typealias collectionViewDelegate = VViewController
extension collectionViewDelegate : UICollectionViewDelegate{
    
}
