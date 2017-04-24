
import UIKit
import CoreData

class OrderFood: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: **** Elements ****
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var tfNum: UITextField!
    @IBOutlet weak var btnTru: UIButton!
    @IBOutlet weak var btnCong: UIButton!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    
    @IBAction func btnBack_TouchUpInside(_ sender: Any) {
        pushData(storyboard: "Main", controller: "ListFood", data: nil)
    }
    
    @IBAction func btnTru_TouchUpInside(_ sender: Any) {
        if(curQty > 1) {
            curQty -= 1
            tfNum.text = "\(curQty)"
        }
    }
    
    @IBAction func btnCong_TouchUpInside(_ sender: Any) {
        curQty += 1
        tfNum.text = "\(curQty)"
    }
    
    // MARK: **** Modals ****
    var fetchedResultsController: NSFetchedResultsController<Table>!
    var curQty = 1
    var curFood: Food!
    
    // MARK: ****
    override func viewDidLoad() {
        super.viewDidLoad()
        tfNum.text = "\(curQty)"
        loadTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func uiPassedData(data: Any?, identity: Int){
        //loadTableView()
        if let d = data as! Food? {
            curFood = d
        }
    }
    
    // MARK: **** TableView ****
    func loadTableView(){
        fetchedResultsController = Database.selectAndGroupBy(groupByColumn: "table_region.name", predicater: NSPredicate(format: "is_empty == %i", 0), sorter: [NSSortDescriptor(key: "number", ascending: true)])
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderFood_Cell = self.table.dequeueReusableCell(withIdentifier: "table_cell", for: indexPath) as! OrderFood_Cell
        if let d = fetchedResultsController.sections?[indexPath.section].objects?[indexPath.row] as! Table? {
            cell.tableName.text = "Mã: \(d.name!)"
            cell.tableNum.text = "Số chỗ: (\(d.number))"
            cell.imgView.image = UIImage(data: d.img! as Data)
            cell.data = d
            cell.controller = self
            cell.backgroundColor = UIColor(white: indexPath.row % 2 == 0 ? 1 : 0.9, alpha: 1)
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
    
}
