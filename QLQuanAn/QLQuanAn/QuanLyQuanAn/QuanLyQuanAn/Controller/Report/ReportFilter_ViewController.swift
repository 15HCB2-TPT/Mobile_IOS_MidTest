//
//  ReportFilter_ViewController.swift
//  QuanLyQuanAn
//
//  Created by Shin-MacDesk on 4/13/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class ReportFilter_ViewController: UIViewController {

    @IBAction func reportClicked(_ sender: Any) {
    }
    @IBOutlet weak var report_time: UIView!
    @IBOutlet weak var report_day: UIView!
    @IBOutlet weak var segmented: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
