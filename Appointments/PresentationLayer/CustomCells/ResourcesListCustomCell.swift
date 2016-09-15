//
//  ResourcesListCustomCell.swift
//  Appointments
//
//  Created by Kiran Kumar on 15/09/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class ResourcesListCustomCell: UITableViewCell {
    @IBOutlet weak var lblWPID: UILabel!
    @IBOutlet weak var lblResourceType: UILabel!
    @IBOutlet weak var lblResourceName: UILabel!
    @IBOutlet weak var viewBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureResourceCell(indexPath : NSIndexPath, andArray arrBranches: NSMutableArray)
    {
        viewBg.layer.cornerRadius = 5.0
        let branchDetails = arrBranches.objectAtIndex(indexPath.row) as! ResourceBO
        lblResourceName.text = branchDetails.strResourceName
        lblResourceType.text = ""// branchDetails.strResourceType
        lblWPID.text = "" //String(format: "%@", branchDetails.strWPId)
    }
    

}
