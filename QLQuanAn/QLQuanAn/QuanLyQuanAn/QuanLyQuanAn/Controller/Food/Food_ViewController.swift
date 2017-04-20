//
//  Food_TableViewController.swift
//  QuanLyQuanAn
//
//  Created by Phạm Tú on 4/18/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Food_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var txtTen: UITextField!
    @IBOutlet weak var stcTimNangCao: UIStackView!
    @IBOutlet weak var heightTimNangCao: NSLayoutConstraint!
    @IBOutlet weak var txtLoaiMonAn: UITextField!
    @IBOutlet weak var txtTu: UITextField!
    @IBOutlet weak var txtDen: UITextField!
    @IBOutlet weak var btnTim: UIButton!
    @IBOutlet weak var swtTimNC: UISwitch!
    @IBOutlet weak var tblMonAn: UITableView!
    
    var foods = Database.select(entityName: "Food", predicater: nil, sorter: [NSSortDescriptor(key: "name", ascending: true)]) as! [Food]
    var foodType = Database.select(entityName: "FoodType", predicater: nil, sorter: [NSSortDescriptor(key: "nametype", ascending: true)]) as! [FoodType]
    
    var pckLoaiMonAn: UIPickerView!
    var tempString: String! = ""
    var tempRow: Int! = 0
    
    @IBAction func swtTimNC_ValueChanged(_ sender: Any) {
        if(stcTimNangCao.isHidden == true) {
            heightTimNangCao.constant = 125
        }
        else {
            heightTimNangCao.constant = 0
        }
        stcTimNangCao.isHidden = !stcTimNangCao.isHidden
    }
    
    @IBAction func btnTim_TouchUpInside(_ sender: Any) {
        if(txtTen.text == "")
        {
            if(swtTimNC.isOn) {
                
            }
            else {
                tblMonAn.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        heightTimNangCao.constant = 0
        txtTen.inputAccessoryView = addDoneButton()
        txtTu.inputAccessoryView = addDoneButton()
        txtDen.inputAccessoryView = addDoneButton()
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        let btnHuy = UIBarButtonItem(title: "Huỷ", style: .plain, target: self, action: #selector(Food_ViewController.btnHuy_Touch))
        let btnChon = UIBarButtonItem(title: "Chọn", style: .plain, target: self, action: #selector(Food_ViewController.btnChon_Touch))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        toolBar.setItems([btnHuy,flexSpace,flexSpace,btnChon], animated: true)
        txtLoaiMonAn.inputAccessoryView = toolBar
        
        tblMonAn.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func txtLoaiMonAn_EditingDidBegin(_ sender: Any) {
        pckLoaiMonAn = UIPickerView()
        pckLoaiMonAn.delegate = self
        pckLoaiMonAn.selectRow(tempRow, inComponent: 0, animated: true)
        txtLoaiMonAn.inputView = pckLoaiMonAn
    }
    
    func btnHuy_Touch(sender: UIBarButtonItem) {
        txtLoaiMonAn.resignFirstResponder()
    }
    
    func btnChon_Touch(sender: UIBarButtonItem) {
        txtLoaiMonAn.text = tempString
        txtLoaiMonAn.resignFirstResponder()
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foodType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foodType[row].nametype!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempRow = row
        tempString = foodType[row].nametype
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFood", for: indexPath) as! Food_TableViewCell
        cell.imgHinh.image = UIImage(data: foods[indexPath.row].image! as Data)
        cell.lblTenMonAn.text = foods[indexPath.row].name!
        if(foods[indexPath.row].is_use == true) {
            cell.lblGia.text = "\(foods[indexPath.row].money)"
        }
        else {
            cell.lblGia.text = "\(foods[indexPath.row].money)" + " - Ngừng kinh doanh"
        }
        return cell
    }
 
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
