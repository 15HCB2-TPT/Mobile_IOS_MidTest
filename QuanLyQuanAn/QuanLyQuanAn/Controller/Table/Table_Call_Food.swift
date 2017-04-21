//
//  Table_Call_Food.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/17/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit
import CoreData

class Table_Call_Food: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: *** Elements ****
    @IBOutlet weak var searchBox: UITextField!
    @IBOutlet weak var tableInfo: UIBarButtonItem!
    @IBOutlet weak var tfInputNum: UITextField!
    @IBOutlet weak var lblTotalMoney: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    
    // MARK: **** Modals ****
    var fetchedResultsController: NSFetchedResultsController<Food>!
    var calledFoods = [Food: Int]()
    var curTable: Table!
    var curOrder: Order!
    var funcAddEdit = true
    
    // MARK: ****
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableView()
        searchBox.inputAccessoryView = addDoneButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func uiPassedData(data: Any?, identity: Int){
        if identity == 1 {
            if let t = data as! Table? {
                tableInfo.title = "Bàn: \(t.name!)"
                lblTotalMoney.title = "Tổng tiền: \(AppData.CurrencyFormatter(value: 0))"
                curTable = t
                curOrder = nil
                funcAddEdit = true
            }
        } else if identity == 2 {
            if let t = data as! (Table, Order)? {
                tableInfo.title = "Bàn: \(t.0.name!)"
                lblTotalMoney.title = "Tổng tiền: \(AppData.CurrencyFormatter(value: t.1.totalmoney))"
                curTable = t.0
                curOrder = t.1
                funcAddEdit = false
            }
        } else if identity == 3 {
            if let t = data as! (String?, Double?, Double?)? {
                if let temp = TempData.load(fromKey: self.title!) as! ([Food: Int], Table?, Order?, Bool)? {
                    calledFoods = temp.0
                    curTable = temp.1
                    curOrder = temp.2
                    funcAddEdit = temp.3
                }
                //
                var predicaters = [NSPredicate]()
                predicaters.append(NSPredicate(format: "is_use == %i", 1))
                if t.0 != nil {
                    predicaters.append(NSPredicate(format: "food_type.nametype == %@", t.0!))
                }
                if t.1 != nil {
                    predicaters.append(NSPredicate(format: "money >= %f", t.1! / (AppData.AppCurrency?.value)!))
                }
                if t.2 != nil {
                    predicaters.append(NSPredicate(format: "money <= %f", t.2! / (AppData.AppCurrency?.value)!))
                }
                let compound = NSCompoundPredicate(andPredicateWithSubpredicates: predicaters)
                fetchedResultsController = Database.selectAndGroupBy(groupByColumn: "food_type.nametype", predicater: compound)
                table.reloadData()
            }
        }
    }
    
    // MARK: **** TableView ****
    func loadTableView(){
        fetchedResultsController = Database.selectAndGroupBy(groupByColumn: "food_type.nametype", predicater: NSPredicate(format: "is_use == %i", 1))
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: "tableCall_cell", for: indexPath) as! Table_Call_Cell
        if let d = fetchedResultsController.sections?[indexPath.section].objects?[indexPath.row] as! Food? {
            cell.name.text = d.name
            cell.price.text = "\(AppData.CurrencyFormatter(value: d.money))"
            cell.imgFood.image = UIImage(data: d.image! as Data)
            cell.controller = self
            cell.data = d
            if calledFoods.keys.contains(d) {
                if calledFoods[d]! > 0 {
                    cell.btnOrder.titleLabel?.text = "(\(calledFoods[d]!)) +"
                }
            }
        }
        return cell
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
    
    // MARK: **** Button ****
    @IBAction func btnBack_Click(_ sender: Any) {
        popData(data: nil)
    }
    
    @IBAction func btnOK_Click(_ sender: Any) {
        func done(_: UIAlertAction){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            var order: Order
            if funcAddEdit {
                order = Database.create()
                order.date = dateFormatter.string(from: Date())
                order.is_paid = false
                order.order_table = curTable
                order.totalmoney = 0
            } else {
                order = curOrder
            }
            for each in calledFoods {
                if each.value > 0 {
                    let detail: DetailsOrder = Database.create()
                    detail.detailsorder_food = each.key
                    detail.detailsorder_order = order
                    detail.money = each.key.money
                    detail.number = Double(each.value)
                    order.totalmoney += detail.money * detail.number
                }
            }
            curTable.is_empty = false
            //
            Database.save()
            //
            popData(data: nil, identity: 1)
        }
        confirm(title: "Nhắc nhỡ", msg: "Bạn có muốn gọi những món này?", btnOKTitle: "Vâng", btnCancelTitle: "Không", handler: done)
    }
    
    @IBAction func btnSearch_Click(_ sender: Any) {
        let predicate1 = NSPredicate(format: "is_use == %i", 1)
        let predicate2 = NSPredicate(format: "name CONTAINS[cd] %@", searchBox.text!)
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        
        fetchedResultsController = Database.selectAndGroupBy(groupByColumn: "food_type.nametype", predicater: compound)
        table.reloadData()
    }
    
    @IBAction func btnSearchAdv_Click(_ sender: Any) {
        TempData.save((calledFoods, curTable, curOrder, funcAddEdit), forKey: self.title!)
        pushData(storyboard: "Main", controller: "tableCallFoodSearchAdvWindow", data: nil)
    }
    
}
