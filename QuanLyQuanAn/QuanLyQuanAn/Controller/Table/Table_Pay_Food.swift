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
    var curOrder: Order!
    
    // MARK: ****
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func uiPassedData(data: Any?, identity: Int){
        if let t = data as! Order? {
            curOrder = t
            tableInfo.title = "Bàn: \((t.order_table?.name!)!)"
            dateInfo.title = "Ngày: \(t.date!)"
            sumOrder.title = "Tổng tiền: \(AppData.CurrencyFormatter(value: t.totalmoney))"
            loadTableView()
        }
    }
    
    // MARK: **** TableView ****
    func loadTableView(){
        let predicate1 = NSPredicate(format: "detailsorder_order.is_paid == %i", 0)
        let predicate2 = NSPredicate(format: "detailsorder_order.order_table.name = %@", (curOrder.order_table?.name)!)
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        
        fetchedResultsController = Database.selectAndGroupBy(groupByColumn: "detailsorder_food.food_type.nametype", predicater: compound)
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: "tablePay_cell", for: indexPath) as! Table_Pay_Cell
        if let d = fetchedResultsController.sections?[indexPath.section].objects?[indexPath.row] as! DetailsOrder? {
            cell.imgFood.image = UIImage(data: d.detailsorder_food?.image as! Data)
            cell.name.text = d.detailsorder_food?.name
            cell.moneyDetails.text = "\(AppData.CurrencyFormatter(value: (d.detailsorder_food?.money)!)) * (\(d.number)) = \(AppData.CurrencyFormatter(value: (d.detailsorder_food?.money)! * d.number))"
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if fetchedResultsController == nil {
            return 0
        }
        return fetchedResultsController.sections!.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchedResultsController == nil {
            return 0
        }
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) ->String? {
        if fetchedResultsController == nil {
            return ""
        }
        return fetchedResultsController.sections![section].name
    }
    
    // MARK: **** Button ****
    @IBAction func btnBack_Click(_ sender: Any) {
        popData(data: nil)
    }
    
    @IBAction func btnPay_Click(_ sender: Any) {
        func done(_: UIAlertAction){
            curOrder.is_paid = true
            curOrder.order_table?.is_empty = true
            Database.save()
            //
            popData(data: curOrder, identity: 2)
        }
        confirm(title: "Nhắc nhỡ", msg: "Bạn muốn thanh toán hoá đơn cho bàn (\((curOrder.order_table?.name!)!))?", btnOKTitle: "Vâng", btnCancelTitle: "Không", handler: done)
    }
    
}
