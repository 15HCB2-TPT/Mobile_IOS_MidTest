//
//  Food_TableViewCell.swift
//  QuanLyQuanAn
//
//  Created by Phạm Tú on 4/18/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

class Food_TableViewCell: UITableViewCell {
    @IBOutlet weak var imgHinh: UIImageView!
    @IBOutlet weak var lblTenMonAn: UILabel!
    @IBOutlet weak var lblGia: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
