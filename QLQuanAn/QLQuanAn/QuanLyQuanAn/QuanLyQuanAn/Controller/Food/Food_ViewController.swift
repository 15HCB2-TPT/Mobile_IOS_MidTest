//
//  Food_ViewController.swift
//  QuanLyQuanAn
//
//  Created by Shin-MacDesk on 4/8/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Food_ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var txt_typefood: UITextField!
    
    var picker = UIPickerView()
    var list:[String] = ["ALL","A","B","C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
    }
    
    //create pickerview input for textfield
    func createPickerView(){
        picker.dataSource = list as? UIPickerViewDataSource
        picker.delegate = self as UIPickerViewDelegate
        txt_typefood.text = list[0]
    }
    
    func donepressed(){
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txt_typefood.text = list[row]
        self.view.endEditing(true)
    }
}
