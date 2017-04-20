//
//  Table_Pay_Food.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/20/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Table_Pay_Food: UIViewController {
    
    // MARK: ****
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func uiPassedData(data: Any?, identity: Int){
        
    }
    
    // MARK: **** Button ****
    @IBAction func btnBack_Click(_ sender: Any) {
        popData(data: nil, identity: 0)
    }
    
}
