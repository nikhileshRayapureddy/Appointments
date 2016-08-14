//
//  AddBranchAddressCustomCell.swift
//  Appointments
//
//  Created by Kiran Kumar on 12/08/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class AddBranchAddressCustomCell: UITableViewCell {

    @IBOutlet var viewBg: UIView!
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
