//
//  PeopleViewController.swift
//  StarWars
//
//  Created by Mac on 5/12/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var skinColorLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var cImageView: UIImageView!
    var imageUrl: String = ""
    var characterUrl :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImage = UIImageView()
        bgImage.image = #imageLiteral(resourceName: "space")
        bgImage.contentMode = .scaleToFill
        NetworkService.getImageNoSession(from: imageUrl) {
            [weak self] (error,data) in
            
        
            if let _ = error {
                
                return
                
            }
            guard let image = data else {
                return }
            
            DispatchQueue.main.async {
                self?.cImageView.contentMode = .scaleAspectFit
                self?.cImageView?.image = image
                
            }
            
        }
        NetworkService.getCharacterDetails(from: characterUrl) {
            [weak self] (error,data) in
            if let _ = error {
                
                return
                
            }
            guard let s = data else {
                return }
            
            DispatchQueue.main.async {
  
                self?.nameLabel.text=s.name
                self?.heightLabel.text=s.height
                self?.massLabel.text=s.mass
                self?.skinColorLabel.text=s.skinColor
                self?.eyeColorLabel.text=s.eyeColor
                self?.birthYearLabel.text=s.birthYear
                self?.genderLabel.text=s.gender
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
