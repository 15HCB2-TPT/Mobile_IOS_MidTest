//
//  Report_TableViewCell.swift
//  QuanLyQuanAn
//
//  Created by Shin-Mac on 4/16/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Report_TableViewCell: UITableViewCell {

    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
