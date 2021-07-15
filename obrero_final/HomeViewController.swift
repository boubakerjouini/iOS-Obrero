//
//  HomeViewController.swift
//  obrero_final
//
//  Created by boubakerjouini on 18/6/2021.
//

import UIKit
import SwiftyJSON
import Alamofire

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let itemLabels = ["Piscine", "Plombier", "Coiffeur", "Chauffage", "Mecanicien", "Climatisation"]
    
    let itemImages: [UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!,
        UIImage(named: "image5")!,
        UIImage(named: "image6")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
            let width = (self.view.frame.size.width - 80) / 2
            let height = self.view.frame.size.height / 5
            return CGSize(width: width, height: height)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
      
        
        cell.itemLabel.text = itemLabels[indexPath.item]
        cell.itemIcon.image = itemImages[indexPath.item]
        
        cell.contentView.layer.cornerRadius = 2.0
   
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        cell.backgroundColor = UIColor.white
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 1.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
    
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        let catName = itemLabels[indexPath.row]
        performSegue(withIdentifier: "toPrest", sender: catName)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        let catName = sender as! String
        let destination = segue.destination as! ListPrestViewController
        destination.catNameTitle = catName
    }
    
 
}



