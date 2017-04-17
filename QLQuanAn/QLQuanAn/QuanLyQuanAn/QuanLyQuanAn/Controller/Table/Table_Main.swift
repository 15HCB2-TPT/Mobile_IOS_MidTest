//
//  Table_Main.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/17/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Table_Main: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: **** Elements ****
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    @IBOutlet weak var segment: UISegmentedControl!
    
    // MARK: **** Models ****
    var tables: [Table]!
    
    // MARK: **** Storyboard Delegates ****
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableView(segmentIndex: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: **** TableView ****
    func loadTableView(segmentIndex: Int){
        var predicate: NSPredicate
        if segmentIndex == 0 {
            predicate = NSPredicate(format: "is_empty = true")
        } else {
            predicate = NSPredicate(format: "is_empty = false")
        }
        tables = Database.select(predicater: predicate)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Table_Cell = self.table.dequeueReusableCell(withIdentifier: "table_cell") as! Table_Cell
        let d = tables[indexPath.row]
        //cell.tableImg = UIImage(
        cell.tableInfo.text = "Mã: \(d.name!) (\(d.number))"
        cell.areaInfo.text = "Khu vực: \(d.table_region?.name! ?? "")"
        cell.data = d
        cell.controller = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !table.isEditing {
            presentData(storyboard: "Main", controller: "tableAddEditWindow", data: tables[indexPath.row], identity: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            //remove Db
            Database.delete(object: tables[indexPath.row])
            Database.save()
            //remove UI
            tables.remove(at: indexPath.row)
            table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: **** Segmented Control ****
    @IBAction func changeSegment(_ sender: Any) {
        loadTableView(segmentIndex: segment.selectedSegmentIndex)
    }
    
    // MARK: **** Button ****
    @IBAction func btnAdd_Click(_ sender: Any) {
        presentData(storyboard: "Main", controller: "tableAddEditWindow", data: nil, identity: 0)
    }
    
    @IBAction func btnEdit_Click(_ sender: Any) {
        table.setEditing(!table.isEditing, animated: true)
        if table.isEditing {
            self.isEditing = true
            btnEdit.title = "Dừng"
        } else {
            self.isEditing = false
            btnEdit.title = "Sửa"
        }
    }
    
}
