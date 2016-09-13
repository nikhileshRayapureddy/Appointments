//
//  SelectOptionsCustomView.swift
//  Appointments
//
//  Created by Kiran Kumar on 12/09/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

protocol SelectOptionsCustomView_Delegate {
    func removeSelectionOptionsPopup()
    func selectedOptions(arrSelected : NSMutableArray, withTag tag : Int)
    func showAlertWithMessage(message : String)
}

class SelectOptionsCustomView: UIView {

    var arrTitles = NSMutableArray()
    var arrSelected = NSMutableArray()
    var isMultipleSelection = Bool()
 
    var viewTag = Int()
    var delegate : SelectOptionsCustomView_Delegate!
    @IBOutlet weak var viewPopUpHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnDoneHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewPopUp: UIView!
    
    @IBOutlet weak var btnDone: UIButton!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func btnDoneClicked(sender: UIButton) {
        if arrSelected.count > 0
        {
            if let delegate = self.delegate
            {
                delegate.selectedOptions(arrSelected, withTag: viewTag)
            }
        }
        else
        {
            if let delegate = self.delegate
            {
                delegate.showAlertWithMessage("Please select any Option.")
            }
        }
    }

    @IBAction func btnTransparentBackgroundClicked(sender: UIButton) {
        if let delegate = self.delegate
        {
            delegate.removeSelectionOptionsPopup()
        }
    }
    
    func resizeView()
    {
         tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "OPTIONS")
        if isMultipleSelection == true
        {
            if arrTitles.count >= 5
            {
                
            }
            else
            {
                viewPopUpHeightConstraint.constant = CGFloat(arrTitles.count * 44)  + 50
            }
            btnDone.hidden = false
        }
        else
        {
            if arrTitles.count >= 5
            {
                
            }
            else
            {
                viewPopUpHeightConstraint.constant = CGFloat(arrTitles.count * 44)
            }
            btnDoneHeightConstraint.constant = 0
            btnDone.hidden = true
        }
        tableView.reloadData()
    }
}

extension SelectOptionsCustomView : UITableViewDelegate, UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("OPTIONS")!
        let dict = arrTitles.objectAtIndex(indexPath.row) as! NSDictionary
        cell.textLabel?.text = dict.objectForKey("Name") as? String
        cell.selectionStyle = UITableViewCellSelectionStyle.None
      
        if arrSelected.containsObject(indexPath) == true
        {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if arrSelected.containsObject(indexPath) == true
        {
            arrSelected.removeObject(indexPath)
        }
        else
        {
            arrSelected.addObject(indexPath)
        }
        
        if isMultipleSelection == false
        {
            if let delegate = self.delegate
            {
                delegate.selectedOptions(arrSelected, withTag: viewTag)
            }
        }
        else
        {
            tableView.reloadData()
        }
    }
}