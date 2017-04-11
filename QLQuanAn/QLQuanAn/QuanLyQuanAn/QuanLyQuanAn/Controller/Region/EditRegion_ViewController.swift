//
//  EditRegion_ViewController.swift
//  QuanLyQuanAn
//
//  Created by Shin-MacDesk on 4/11/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class EditRegion_ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var txt_nameregion: UITextField!
    
    var rg = Region()

    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: rg.name!)
        txt_nameregion.text = rg.name!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveClick(_ sender: Any) {
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
