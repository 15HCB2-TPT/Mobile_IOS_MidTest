//
//  ReportFilter_ViewController.swift
//  QuanLyQuanAn
//
//  Created by Shin-MacDesk on 4/13/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

protocol ReportDelegate:class{
    func trandata()
}

class ReportFilter_ViewController: UIViewController {

    var rl = [ReportItem]()

    @IBOutlet weak var report_time: UIView!
    @IBOutlet weak var report_day: UIView!
    @IBOutlet weak var segmented: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        SeedReport()
        // Do any additional setup after loading the view.
    }

    @IBAction func selectedChange(_ sender: Any) {
        let segm = sender as! UISegmentedControl
        switch segm.selectedSegmentIndex {
        case 0:
            report_day.isHidden = false
            report_time.isHidden = true
        case 1:
            report_day.isHidden = true
            report_time.isHidden = false
        default:
            return
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func SeedReport(){
        var r = ReportItem()
        r.name = "a"
        r.number = 1
        rl.append(r)
        r = ReportItem()
        r.name = "b"
        r.number = 2
        rl.append(r)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navi_report" {
            let navi = segue.destination as? UINavigationController
            let des = navi?.topViewController as! Report_TableViewController
            des.rl = rl
        }
    }
    
    @IBAction func reportClicked(_ sender: Any) {
        
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
