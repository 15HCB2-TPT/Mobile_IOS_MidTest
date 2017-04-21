//
//  Report_TableViewController.swift
//  QuanLyQuanAn
//
//  Created by Shin-Mac on 4/16/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Report_TableViewController: UITableViewController,UINavigationControllerDelegate {


    @IBOutlet var table_reporttype: UITableView!
    var sections = Database.select(entityName: "FoodType") as! [FoodType]
    var rl = [ReportItem]()
    var temp=[[ReportItem]]()
    var delegate:ReportDelegate?
    var is_doanhthu:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        processSections()
    }
    
    func processSections(){
        for i in 0 ... sections.count - 1{
            temp.append([ReportItem]())
            for each in rl {
                if  each.foodtype == sections[i]{
                    temp[i].append(each)
                }
            }
        }
        var test = [[ReportItem]]()
        for i in 0 ... temp.count - 1 {
            if temp[i].count > 0 {
                test.append(temp[i])
            }
        }
        temp = test
    }	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return temp.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return temp[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_reporttype", for: indexPath) as! Report_TableViewCell
        cell.name.text = rl[indexPath.row].name
        if is_doanhthu {
            cell.number.text = String(rl[indexPath.row].money)
            cell.unit.text = "USD"
        }else {
            cell.number.text = String(rl[indexPath.row].number)
            cell.unit.text = "phần"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) ->String? {
        return temp[section][0].foodtype.nametype!
    }

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
