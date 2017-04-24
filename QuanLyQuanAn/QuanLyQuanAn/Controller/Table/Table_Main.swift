//
//  Table_Main.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/17/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit
import CoreData

class Table_Main: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: **** Elements ****
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    // MARK: **** Modals ****
    var fetchedResultsController: NSFetchedResultsController<Table>!
    
    // MARK: ****
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableView(segmentIndex: segment.selectedSegmentIndex)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func uiPassedData(data: Any?, identity: Int){
        //loadTableView(segmentIndex: segment.selectedSegmentIndex)
        if identity == 1 {
            alert(title: "Thông báo", msg: "Đã lập hóa đơn thành công!", btnTitle: "Đã biết")
        } else if identity == 2 {
            if let t = data as! Order? {
                alert(title: "Thông báo", msg: "Đã thanh toán thành công hoá đơn cho bàn (\((t.order_table?.name!)!))", btnTitle: "Đã biết")
            }
        }
    }
    
    // MARK: **** TableView ****
    func loadTableView(segmentIndex: Int){
        fetchedResultsController = Database.selectAndGroupBy(groupByColumn: "table_region.name", predicater: NSPredicate(format: "is_empty == %i", segmentIndex == 0 ? 1 : 0), sorter: [NSSortDescriptor(key: "number", ascending: true)])
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Table_Cell = self.table.dequeueReusableCell(withIdentifier: "table_cell", for: indexPath) as! Table_Cell
        if let d = fetchedResultsController.sections?[indexPath.section].objects?[indexPath.row] as! Table? {
            cell.name.text = "Mã: \(d.name!)"
            cell.num.text = "Số chỗ: (\(d.number))"
            cell.imgView.image = UIImage(data: d.img! as Data)
            cell.data = d
            cell.controller = self
            if d.is_empty {
                cell.btnPay.isHidden = true
            } else {
                cell.btnPay.isHidden = false
            }
            cell.backgroundColor = UIColor(white: indexPath.row % 2 == 0 ? 1 : 0.9, alpha: 1)
            if d.is_deleted {
                cell.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !table.isEditing {
            pushData(storyboard: "Main", controller: "tableAddEditWindow", data: fetchedResultsController.sections?[indexPath.section].objects?[indexPath.row], identity: 1)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) ->String? {
        return fetchedResultsController.sections![section].name
    }
    
    // MARK: **** Segmented Control ****
    @IBAction func changeSegment(_ sender: Any) {
        loadTableView(segmentIndex: segment.selectedSegmentIndex)
    }
    
    // MARK: **** Button ****
    @IBAction func btnAdd_Click(_ sender: Any) {
        pushData(storyboard: "Main", controller: "tableAddEditWindow", data: nil, identity: 0)
    }
    
}
