//
//  EditFood_ViewController.swift
//  QuanLyQuanAn
//
//  Created by Phạm Tú on 4/22/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class EditFood_ViewController: UIViewController, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btnChooseImage: UIButton!
    @IBOutlet weak var txtNameFood: UITextField!
    @IBOutlet weak var txtStyleFood: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var swtSuDung: UISwitch!
    
    var food: Food!
    var foodTypes = Database.select(entityName: "FoodType", predicater: nil, sorter: [NSSortDescriptor(key: "nametype", ascending: true)]) as! [FoodType]
    
    var pckLoaiMonAn: UIPickerView!
    var tempString: String!
    var tempRow: Int!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtNameFood.inputAccessoryView = addDoneButton()
        txtPrice.inputAccessoryView = addDoneButton()
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 44.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        let btnHuy = UIBarButtonItem(title: "Huỷ", style: .plain, target: self, action: #selector(EditFood_ViewController.btnHuy_Touch))
        let btnChon = UIBarButtonItem(title: "Chọn", style: .plain, target: self, action: #selector(EditFood_ViewController.btnChon_Touch))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        toolBar.setItems([btnHuy,flexSpace,flexSpace,btnChon], animated: true)
        txtStyleFood.inputAccessoryView = toolBar
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func uiPassedData(data: Any?, identity: Int) {
        food = data as! Food
        if(food != nil) {
            image.image = UIImage(data: food.image! as Data)
            txtNameFood.text = food.name
            txtStyleFood.text = food.food_type?.nametype
            tempString = txtStyleFood.text
            tempRow = foodTypes.index(of: food.food_type!)
            txtPrice.text = "\(food.money)"
            swtSuDung.setOn(food.is_use, animated: true)
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        let info = notification.userInfo
        let keyboard = (info?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        
        let contentInset = UIEdgeInsetsMake(0, 0, keyboard.height - 44, 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    func keyboardWillHide(_ notification: Notification) {
        let contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @IBAction func txtStyleFood_EditingDidBegin(_ sender: Any) {
        pckLoaiMonAn = UIPickerView()
        pckLoaiMonAn.delegate = self
        
        
        pckLoaiMonAn.selectRow(tempRow, inComponent: 0, animated: true)
        txtStyleFood.inputView = pckLoaiMonAn
    }
    
    func btnHuy_Touch(sender: UIBarButtonItem) {
        txtStyleFood.resignFirstResponder()
    }
    
    func btnChon_Touch(sender: UIBarButtonItem) {
        txtStyleFood.text = tempString
        txtStyleFood.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foodTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foodTypes[row].nametype!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempRow = row
        tempString = foodTypes[row].nametype
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
            self.image.contentMode = .scaleAspectFit
            self.image.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        })
    }
    
    @IBAction func btnChooseImage_TouchUpInside(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func checkName(name: String) -> Bool {
        if(Database.select(entityName: "Food", predicater: NSPredicate(format: "name == %@", txtNameFood.text!), sorter: nil) as! [Food]).count != 1 {
            return false
        }
        return true
    }
    
    @IBAction func btnSave_Touch(_ sender: Any) {
        if (image.image != nil && txtNameFood.text != "" && txtStyleFood.text != "" && txtPrice.text != "") {
            if(checkName(name: txtNameFood.text!) == false) {
                let refreshAlert = UIAlertController(title: "Lỗi", message: "Tên món ăn đã tồn tại.", preferredStyle: UIAlertControllerStyle.alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
                present(refreshAlert, animated: true, completion: nil)
            }
            else{
                food.image = self.image.image?.pngRepresentationData
                food.name = txtNameFood.text
                food.food_type = foodTypes[tempRow]
                food.money = (txtPrice.text?.doubleValue)!
                food.is_use = swtSuDung.isOn
                Database.save()
                pushData(storyboard: "Main", controller: "ListFood", data: nil)
            }
        }
        else {
            let refreshAlert = UIAlertController(title: "Lỗi", message: "Vui lòng nhập đầy đủ thông tin.", preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(refreshAlert, animated: true, completion: nil)
        }
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
