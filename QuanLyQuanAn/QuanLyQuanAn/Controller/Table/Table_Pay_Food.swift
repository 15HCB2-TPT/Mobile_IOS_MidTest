//
//  Table_Pay_Food.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/20/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit
import CoreData

class Table_Pay_Food: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: **** Elements ****
    @IBOutlet weak var tableInfo: UIBarButtonItem!
    @IBOutlet weak var dateInfo: UIBarButtonItem!
    @IBOutlet weak var sumOrder: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    
    // MARK: **** Modals ****
    var fetchedResultsController: NSFetchedResultsController<DetailsOrder>!
    
    // MARK: ****
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func uiPassedData(data: Any?, identity: Int){
        
    }
    
    // MARK: **** TableView ****
    func loadTableView(segmentIndex: Int){
//        fetchedResultsController = Database.selectAndGroupBy(groupByColumn: "table_region.name", predicater: NSPredicate(format: "is_empty == %i", segmentIndex == 0 ? 1 : 0), sorter: [NSSortDescriptor(key: "table_region.name", ascending: true), NSSortDescriptor(key: "number", ascending: true)])
//        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: "tablePay_cell", for: indexPath) as! Table_Pay_Cell
//        if let d = fetchedResultsController.sections?[indexPath.section].objects?[indexPath.row] as! Table? {
//            cell.name.text = "Mã: \(d.name!)"
//            cell.num.text = "Số chỗ: (\(d.number))"
//            cell.imgView.image = UIImage(data: d.img! as Data)
//            cell.data = d
//            cell.controller = self
//            if d.is_empty {
//                cell.btnPay.isHidden = true
//            }
//            cell.backgroundColor = UIColor(white: indexPath.row % 2 == 0 ? 1 : 0.9, alpha: 1)
//            if d.is_deleted {
//                cell.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
//            }
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if !table.isEditing {
//            pushData(storyboard: "Main", controller: "tableAddEditWindow", data: fetchedResultsController.sections?[indexPath.section].objects?[indexPath.row], identity: 1)
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return fetchedResultsController.sections!.count
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchedResultsController.sections![section].numberOfObjects
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) ->String? {
//        return fetchedResultsController.sections![section].name
        return ""
    }
    
    // MARK: **** Button ****
    @IBAction func btnBack_Click(_ sender: Any) {
        popData(data: nil)
    }
    
    @IBAction func btnPay_Click(_ sender: Any) {
        
    }
    
}
