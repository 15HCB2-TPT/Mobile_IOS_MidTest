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
        let lan = L102Language.currentAppleLanguage()
        if lan == "vi" {
            switchVietnamese.isOn = true
            switchEnglish.isOn = !switchVietnamese.isOn
        }
        else{
            switchVietnamese.isOn = false
            switchEnglish.isOn = !switchVietnamese.isOn
        }
}
    
    @IBAction func vietSwitch(_ sender: Any) {
        switchEnglish.isOn = !switchVietnamese.isOn
        changeLan(lanID: switchVietnamese.isOn ? 0 : 1)
    }
    
    @IBAction func engSwitch(_ sender: Any) {
        switchVietnamese.isOn = !switchEnglish.isOn
        changeLan(lanID: switchEnglish.isOn ? 1 : 0)
    }
    
    func changeLan(lanID: Int) {
        if lanID == 0 {
            func done(_: UIAlertAction){
                L102Language.setAppleLAnguageTo(lang: "vi")
                alert(title: "Notice", msg: "Changing Language Completed!. Please restart application!", btnTitle: "Ok")
            }
            confirm(title: "Notice", msg: "Are you sure change language this app?", btnOKTitle: "Yes", btnCancelTitle: "No", handler: done)
        } else {
            func done(_: UIAlertAction){
                L102Language.setAppleLAnguageTo(lang: "en")
                alert(title: "Thông báo", msg: "Đổi ngôn ngữ thành công. Xin hãy khởi động lại ứng dụng!", btnTitle: "Đã biết")
            }
            confirm(title: "Thông báo", msg: "Bạn có muốn thay đổi ngôn ngữ?", btnOKTitle: "Vâng", btnCancelTitle: "Không", handler: done)
        }
    }
    
    // MARK: **** Currency Change ****
    func loadCur(){
        let def = UserDefaults.standard
        let cur = def.string(forKey: AppConfigs.CURRENCY_KEY)
        switchDolarUS.isOn = cur == nil || cur == "$"
        if switchDolarUS.isOn {
            dorlarUS_Switch(switchDolarUS)
        } else /*if switchVND.isOn*/ {
            vndSwitch(switchVND)
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
        } else /*if curID == 1*/ {
            AppData.AppCurrency = Database.isExistAndGet(predicater: NSPredicate(format: "name == %@", "$"))
        }
        let def = UserDefaults.standard
        def.set(AppData.AppCurrency?.name, forKey: AppConfigs.CURRENCY_KEY)
    }
    
    // MARK: **** Seed Data to Test ****
    @IBAction func btnSeedData2Test_Click(_ sender: Any) {
        func confirmOK(act: UIAlertAction) {
            SeedData.seedData()
            AppDelegate.restart()
            loadLan()
            loadCur()
        }
        confirm(title: "Xác nhận", msg: "Dữ liệu sẽ reset lại tất cả! Bạn có chắc muốn tiếp tục?", btnOKTitle: "Tiếp", btnCancelTitle: "Dừng", handler: confirmOK)
    }
    
}
