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
    
    @IBOutlet weak var switchVND: UISwitch!
    @IBOutlet weak var switchDolarUS: UISwitch!
    
    // MARK: ****
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLan()
        loadCur()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: **** Language Change ****
    func loadLan(){
        
    }
    
    @IBAction func vietSwitch(_ sender: Any) {
        switchEnglish.isOn = !switchVietnamese.isOn
        changeLan(lanID: switchVietnamese.isOn ? 0 : 1)
        switchEnglish.isOn = false
        _ = "".localized(lang: "vi")
    }
    
    @IBAction func engSwitch(_ sender: Any) {
        //switchVietnamese.isOn = !switchEnglish.isOn
        //changeLan(lanID: switchEnglish.isOn ? 1 : 0)
        if switchEnglish.isOn {
            //alert(title: "Thông báo", msg: "Ngôn ngữ chưa sẵn sáng!", btnTitle: "Đã biết")
            //switchEnglish.isOn = false
            _ = "".localized(lang: "en")
            switchVietnamese.isOn=false
            //var temp:UserDefaults =
        }
    }
    
    func changeLan(lanID: Int) {
        
    }
    
    // MARK: **** Currency Change ****
    func loadCur(){
        let def = UserDefaults.standard
        let cur = def.string(forKey: AppConfigs.CURRENCY_KEY)
        switchDolarUS.isOn = cur == nil || cur == "$"
        if switchDolarUS.isOn {
            dorlarUS_Switch(switchDolarUS)
        }
    }
    
    @IBAction func vndSwitch(_ sender: Any) {
        switchDolarUS.isOn = !switchVND.isOn
        changeCurrency(curID: switchVND.isOn ? 0 : 1)
    }
    
    @IBAction func dorlarUS_Switch(_ sender: Any) {
        switchVND.isOn = !switchDolarUS.isOn
        changeCurrency(curID: switchDolarUS.isOn ? 1 : 0)
    }
    
    func changeCurrency(curID: Int) {
        if curID == 0 {
            AppData.AppCurrency = Database.isExistAndGet(predicater: NSPredicate(format: "name == %@", "vnd"))
        } else {
            AppData.AppCurrency = Database.isExistAndGet(predicater: NSPredicate(format: "name == %@", "$"))
        }
        let def = UserDefaults.standard
        def.set(AppData.AppCurrency?.name, forKey: AppConfigs.CURRENCY_KEY)
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
