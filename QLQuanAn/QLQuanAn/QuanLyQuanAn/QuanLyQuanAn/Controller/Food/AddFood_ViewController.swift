//
//  AddFood_ViewController.swift
//  QuanLyQuanAn
//
//  Created by Phạm Tú on 4/12/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class AddFood_ViewController: UIViewController {
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btnChooseImage: UIButton!
    @IBOutlet weak var txtNameFood: UITextField!
    @IBOutlet weak var txtStyleFood: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
