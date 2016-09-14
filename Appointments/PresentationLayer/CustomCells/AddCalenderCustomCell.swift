//
//  AddCalenderCustomCell.swift
//  Appointments
//
//  Created by NIKHILESH on 04/09/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class AddCalenderCustomCell: UITableViewCell {
    @IBOutlet var viewBg: UIView!
    @IBOutlet var vwLblTimeBg: UIView!
    @IBOutlet weak var lblPatternName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell()
    {
        viewBg.layer.cornerRadius = 5.0
    }

}
