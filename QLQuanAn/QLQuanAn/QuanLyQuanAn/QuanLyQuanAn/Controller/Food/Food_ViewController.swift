//
//  Food_TableViewController.swift
//  QuanLyQuanAn
//
//  Created by Phạm Tú on 4/18/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Food_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var txtTen: UITextField!
    @IBOutlet weak var stcTimNangCao: UIStackView!
    @IBOutlet weak var heightTimNangCao: NSLayoutConstraint!
    @IBOutlet weak var txtLoaiMonAn: UITextField!
    @IBOutlet weak var txtTu: UITextField!
    @IBOutlet weak var txtDen: UITextField!
    @IBOutlet weak var btnTim: UIButton!
    @IBOutlet weak var swtTimNC: UISwitch!
    @IBOutlet weak var tblMonAn: UITableView!
    
    var foods = Database.select(entityName: "Food") as! [Food]
    
    @IBAction func swtTimNC_ValueChanged(_ sender: Any) {
        if(stcTimNangCao.isHidden == true) {
            heightTimNangCao.constant = 125
        }
        else {
            heightTimNangCao.constant = 0
        }
        stcTimNangCao.isHidden = !stcTimNangCao.isHidden
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        heightTimNangCao.constant = 0
        txtTen.inputAccessoryView = addDoneButton()
        txtTu.inputAccessoryView = addDoneButton()
        txtDen.inputAccessoryView = addDoneButton()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFood", for: indexPath) as! Food_TableViewCell
        do {
            try cell.imgHinh.image = UIImage(data: foods[indexPath.row].image! as Data)
        }
        catch {}
        cell.lblTenMonAn.text = foods[indexPath.row].name!
        cell.lblGia.text = "\(foods[indexPath.row].money)"
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
