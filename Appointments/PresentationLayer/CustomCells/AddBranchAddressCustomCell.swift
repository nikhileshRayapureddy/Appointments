//
//  AddBranchAddressCustomCell.swift
//  Appointments
//
//  Created by Kiran Kumar on 12/08/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class AddBranchAddressCustomCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet var viewBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(indexPath : NSIndexPath, andArray arrBranches: NSMutableArray)
    {
        viewBg.layer.cornerRadius = 5.0
        let branchDetails = arrBranches.objectAtIndex(indexPath.row) as! BranchBO
        lblName.text = branchDetails.strFirmName
        lblCity.text = branchDetails.strCitynm
        lblAddress.text = String(format: "%@,%@,%@", branchDetails.strAddressLine1,branchDetails.strAddressLine2,branchDetails.strCountynm)        
    }
    
}
