//
//  AddBranchViewController.swift
//  Appointments
//
//  Created by Nikhilesh on 10/08/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class AddBranchViewController: BaseViewController {

    @IBOutlet weak var tblBranch: UITableView!
    @IBOutlet weak var scrlVwAddBranch: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnViewList: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
        self.designNavBar("Add Branch")
        self.designTabBar()
        self.setSelected(2)
        let btnNext : UIButton = UIButton(type: UIButtonType.Custom)
        btnNext.frame =  CGRectMake(0, 0, 90,44)
        btnNext.setTitle("Next", forState: UIControlState.Normal)
        btnNext.setTitle("Next", forState: UIControlState.Highlighted)
        btnNext.setTitle("Next", forState: UIControlState.Selected)
        btnNext.addTarget(self, action: #selector(self.btnNextClicked(_:)), forControlEvents: .TouchUpInside)
        btnNext.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        let rightBarButtonItems = UIView()
        rightBarButtonItems.frame = CGRectMake(ScreenWidth - 90, 0, 90, 44)
        rightBarButtonItems.addSubview(btnNext)
        let bItem = UIBarButtonItem(customView:rightBarButtonItems)
        self.navigationItem.rightBarButtonItem = bItem
        scrlVwAddBranch.hidden = false
        tableView.hidden = true
    }
    func btnNextClicked(sender : UIButton)
    {
        
    }

    @IBAction func btnViewListClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true{
            scrlVwAddBranch.hidden = true
            tableView.hidden = false
        }
        else
        {
            scrlVwAddBranch.hidden = false
            tableView.hidden = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AddBranchViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : AddBranchAddressCustomCell = tableView.dequeueReusableCellWithIdentifier("ADDRESSCELL") as! AddBranchAddressCustomCell
        cell.configureCell()
        return cell
    }
    
}

extension AddBranchViewController : UITextFieldDelegate
{
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
