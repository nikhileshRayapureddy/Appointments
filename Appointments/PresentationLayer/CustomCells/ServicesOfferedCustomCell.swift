//
//  ServicesOfferedCustomCell.swift
//  Appointments
//
//  Created by Kiran Kumar on 15/09/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class ServicesOfferedCustomCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(indexPath : NSIndexPath, anddata arrServices : NSMutableArray)
    {
        viewBg.layer.cornerRadius = 5.0
        let service = arrServices.objectAtIndex(indexPath.row) as! ServiceBO
        lblTitle.text = service.strServiceName
        lblDescription.text = service.strDescription
    }

}
