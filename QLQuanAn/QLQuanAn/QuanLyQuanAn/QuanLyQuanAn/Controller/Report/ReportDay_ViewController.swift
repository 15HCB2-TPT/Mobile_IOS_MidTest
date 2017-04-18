//
//  ReportDay_ViewController.swift
//  QuanLyQuanAn
//
//  Created by Shin-Mac on 4/17/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

protocol DateDelegate:class {
    func trandate(dateX: Date,dateY: Date)
}
class ReportDay_ViewController: UIViewController {

    @IBOutlet weak var date_day: UIDatePicker!
    var reportdelegate:ReportDelegate?
    
    @IBAction func datePickerChanged(_ sender: Any) {
        reportdelegate?.trandata(dateday: date_day.date)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
