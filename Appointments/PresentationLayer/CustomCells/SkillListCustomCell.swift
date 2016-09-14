//
//  SkillListCustomCell.swift
//  Appointments
//
//  Created by Kiran Kumar on 14/09/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class SkillListCustomCell: UITableViewCell {

    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(indexPath : NSIndexPath,andSkillsArray arrSkills : NSMutableArray)
    {
        let skill = arrSkills.objectAtIndex(indexPath.row) as! SkillsBO
        lblName.text = skill.strSkillName
        lblDesc.text = skill.strSkillNotes
    }
}
