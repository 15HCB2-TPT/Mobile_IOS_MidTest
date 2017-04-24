
import UIKit

class OrderFood_Cell: UITableViewCell{
    
    // MARK: **** Elements ****
    @IBOutlet weak var tableName: UILabel!
    @IBOutlet weak var tableNum: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnCall: UIButton!
    
    // MARK: **** Modals ****
    var data: Table!
    var controller: OrderFood!
    
    // MARK: **** Handlers ****
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnCall_Click(_ sender: Any) {
        if let order = Database.isExistAndGet(entityName: "Order", predicater: NSPredicate(format: "order_table.name == %@ AND is_paid == %i", data.name!, 0)) as! Order? {
            func done(_: UIAlertAction){
                let detail: DetailsOrder = Database.create()
                detail.detailsorder_food = controller.curFood
                detail.detailsorder_order = order
                detail.money = controller.curFood.money
                detail.number = Double(controller.tfNum.text!)!
                order.totalmoney += detail.money * detail.number
                controller.alert(title: "Thông báo", msg: "Đã thêm món thành công!", btnTitle: "Đã biết")
            }
            controller.confirm(title: "Thông báo", msg: "Bạn có muốn gọi thêm món cho bàn này?", btnOKTitle: "Vâng", btnCancelTitle: "Không", handler: done)
        }
    }
    
}
