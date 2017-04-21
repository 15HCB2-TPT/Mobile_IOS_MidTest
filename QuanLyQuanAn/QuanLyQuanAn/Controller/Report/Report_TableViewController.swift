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
    
    // MARK: *** - Table view data source

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
        cell.name.text = temp[indexPath.section][indexPath.row].name
        if is_doanhthu {
            cell.number.text = String(temp[indexPath.section][indexPath.row].money * (AppData.AppCurrency?.value)!)
            cell.unit.text = AppData.AppCurrency?.name
        }else {
            cell.number.text = String(temp[indexPath.section][indexPath.row].number)
            cell.unit.text = "phần"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) ->String? {
        return temp[section][0].foodtype.nametype!
    }
}
