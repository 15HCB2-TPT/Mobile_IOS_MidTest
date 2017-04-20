//
//  Table_Call_Food.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/17/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Table_Call_Food: UIViewController {
    
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
