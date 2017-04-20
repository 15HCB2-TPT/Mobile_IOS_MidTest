//
//  SettingController.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/20/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class SettingController: UIViewController {
    
    // MARK: **** Elements ****
    @IBOutlet weak var switchVietnamese: UISwitch!
    @IBOutlet weak var switchEnglish: UISwitch!
    
    // MARK: ****
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: **** Language Change ****
    @IBAction func vietSwitch(_ sender: Any) {
        switchEnglish.isOn = !switchVietnamese.isOn
    }
    
    @IBAction func engSwitch(_ sender: Any) {
        //switchVietnamese.isOn = !switchEnglish.isOn
        if switchEnglish.isOn {
            alert(title: "Thông báo", msg: "Ngôn ngữ chưa sẵn sáng!", btnTitle: "Đã biết")
            switchEnglish.isOn = false
        }
    }
    
    // MARK: **** Seed Data to Test ****
    @IBAction func btnSeedData2Test_Click(_ sender: Any) {
        func conformOK(act: UIAlertAction) {
            SeedData.seedData()
            AppDelegate.restart()
        }
        conform(title: "Xác nhận", msg: "Dữ liệu sẽ reset lại tất cả! Bạn có chắc muốn tiếp tục?", btnOKTitle: "Tiếp", btnCancelTitle: "Dừng", handler: conformOK)
    }
    
}
