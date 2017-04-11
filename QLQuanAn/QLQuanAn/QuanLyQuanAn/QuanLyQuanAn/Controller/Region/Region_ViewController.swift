//
//  Region_ViewController.swift
//  QuanLyQuanAn
//
//  Created by Shin-MacDesk on 4/10/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Region_ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionview: UICollectionView!
    
    let regions = Database.select(entityName: "Region") as! [Region]
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.register(MyCustom_CollectionViewCell.self, forCellWithReuseIdentifier: "collectionviewcell")
        collectionview.delegate = self
        collectionview.dataSource = self
        
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
    // MAR: Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return regions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customcell", for: indexPath) as! MyCustom_CollectionViewCell
        cell.label_nameregion.text = regions[indexPath.row].name!
        cell.image_region.image = UIImage(named: regions[indexPath.row].name!)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "editregion") as! EditRegion_ViewController
        viewController.rg = regions[indexPath.row]
        self.present(viewController, animated: true , completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if (segue.identifier == "editregion") {
//            let viewController = segue.destination as! EditRegion_ViewController
//            // your new view controller should have property that will store passed value
//            viewController.rg.image = regions[index].image!
//            viewController.rg.name = regions[index].name!
//        }
    }

}
