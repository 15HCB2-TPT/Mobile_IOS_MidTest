//
//  Table_SearchFoodAdv.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/21/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Table_SearchFoodAdv: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: **** Elements ****
    @IBOutlet weak var tfFoodType: UITextField!
    @IBOutlet weak var tfFrom: UITextField!
    @IBOutlet weak var tfTo: UITextField!
    var picker: UIPickerView!
    
    // MARK: **** Modals ****
    var fts: [FoodType]!
    
    // MARK: ****
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPickerView()
        tfFoodType.inputAccessoryView = addDoneButton()
        tfFrom.inputAccessoryView = addDoneButton()
        tfTo.inputAccessoryView = addDoneButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func uiPassedData(data: Any?, identity: Int) {
        
    }
    
    // MARK: **** FoodType Choose ****
    @IBAction func regionBeginEdit(_ sender: Any) {
        if picker == nil {
            picker = UIPickerView()
            picker.delegate = self
            picker.selectRow(0, inComponent: 0, animated: true)
            tfFoodType.text = fts.first?.nametype
            tfFoodType.inputView = picker
        }
    }
    
    func loadPickerView() {
        fts = Database.select()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fts[row].nametype
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfFoodType.text = fts[row].nametype
    }
    
    // MARK: **** Button ****
    @IBAction func btnCancel_Click(_ sender: Any) {
        popData(data: nil)
    }
    
    @IBAction func btnSearch_Click(_ sender: Any) {
        popData(data: (tfFoodType.text, Double(tfFrom.text!), Double(tfTo.text!)), identity: 3)
    }
        
}
