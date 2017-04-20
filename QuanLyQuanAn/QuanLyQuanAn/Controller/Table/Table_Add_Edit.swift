//
//  Table_Add_Edit.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/17/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Table_Add_Edit: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: **** Elements **** 
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var btnAddEdit: UIBarButtonItem!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfNum: UITextField!
    @IBOutlet weak var tfReg: UITextField!
    var imagePicker = UIImagePickerController()
    var pickerRegions: UIPickerView!
    
    // MARK: **** Models ****
    var regions: [Region]!
    var selectedRegion: Region!
    var funcAddEdit: Bool = true
    var updatedTable: Table!
    var pickRegion_tempRow: Int = 0
    
    // MARK: ****
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPickerView()
        tfName.inputAccessoryView = addDoneButton()
        tfNum.inputAccessoryView  = addDoneButton()
        tfReg.inputAccessoryView  = addDoneButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func uiPassedData(data: Any?, identity: Int){
        if identity == 0 {
            navigationTitle.title = "Thêm mới"
            btnAddEdit.title = "Thêm"
            tfReg.text = regions.first?.name
        } else { 
            if let t = data as! Table? {
                tfName.text = t.name
                tfNum.text = "\(t.number)"
                tfReg.text = t.table_region?.name
                //
                navigationTitle.title = "Cập nhật"
                btnAddEdit.title = "Lưu"
                funcAddEdit = false
                updatedTable = t
            }
        }
    }
    
    func checkTableDuplicate(name: String) -> Bool {
        let p = NSPredicate(format: "name == %@", name)
        return Database.isExist(entityName: "Table", predicater: p)
    }
    
    // MARK: **** Region Choose ****
    @IBAction func regionBeginEdit(_ sender: Any) {
        if pickerRegions == nil {
            pickerRegions = UIPickerView()
            pickerRegions.delegate = self
            pickerRegions.selectRow(searchTable(name: tfReg.text!), inComponent: 0, animated: true)
            tfReg.inputView = pickerRegions
        }
    }
    
    func loadPickerView() {
        regions = Database.select()
        selectedRegion = regions.first
    }
    
    func searchTable(name: String) -> Int {
        var index = 0
        for each in regions {
            if each.name == name {
                return index
            }
            index = index + 1
        }
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regions[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRegion = regions[row]
        tfReg.text = selectedRegion.name
    }

    // MARK: **** Button ****
    @IBAction func btnAddEdit_Click(_ sender: Any) {
        //prepare data
        let name = tfName.text!
        let num = Int32(tfNum.text!)
        
        //check duplicate
        if !checkTableDuplicate(name: name) {
            
            //Add or Save
            var t: Table
            if funcAddEdit {
                t = Database.create()
            } else {
                t = updatedTable
            }
            t.name = name
            t.number = num!
            t.is_empty = true
            t.table_region = selectedRegion
            t.img = self.imgView.image?.pngRepresentationData
            Database.save()
            
            //alert
            if funcAddEdit {
                alert(title: "Nhắc nhở", msg: "Đã thêm thành công.", btnTitle: "Hiểu")
            } else {
                alert(title: "Nhắc nhở", msg: "Đã cập nhật thành công", btnTitle: "Hiểu")
            }
            
        } else {
            alert(title: "Nhắc nhở", msg: "Tên bàn đã tồn tại.", btnTitle: "Hiểu")
        }
    }
    
    @IBAction func btnBack_Click(_ sender: Any) {
        popData(data: nil, identity: 0)
    }
    
    // MARK: **** Choose img
    @IBAction func btnImg_Click(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
            self.imgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        })
    }
    
}

