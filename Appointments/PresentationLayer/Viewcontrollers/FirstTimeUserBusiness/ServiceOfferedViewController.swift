//
//  ServiceOfferedViewController.swift
//  Appointments
//
//  Created by Nikhilesh on 10/08/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class ServiceOfferedViewController: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnViewList: UIButton!
    @IBOutlet weak var scrlVwSevicesOffered: UIScrollView!
    
    @IBOutlet weak var btnTwoMenJob: UIButton!
    @IBOutlet weak var txtFldDuration: UITextField!
    @IBOutlet weak var txtFldPrice: UITextField!
    @IBOutlet weak var btnSelectSkill: UIButton!
    @IBOutlet weak var txtFldDesc: UITextField!
    @IBOutlet weak var txtFldServiceType: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
        self.designNavBar("Services Offered")
        self.designTabBar()
        self.setSelected(5)
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
        scrlVwSevicesOffered.hidden = false
        tableView.hidden = true
        getListOfServices()
    }
    func btnNextClicked(sender : UIButton)
    {
        
    }
    
    func getListOfServices()
    {
        app_delegate.showLoader("Loading...")
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getListServicesOffered()
    }

    func getServicesOffered()
    {
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getServicesOffered()
    }
    @IBAction func btnViewListClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true{
            scrlVwSevicesOffered.hidden = true
            tableView.hidden = false
        }
        else
        {
            scrlVwSevicesOffered.hidden = false
            tableView.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ServiceOfferedViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : AddBranchAddressCustomCell = tableView.dequeueReusableCellWithIdentifier("ADDRESSCELL") as! AddBranchAddressCustomCell
//        cell.configureCell()
        return cell
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func btnTwoMenJobClicked(sender: UIButton) {
        sender.selected = !sender.selected
    }
    @IBAction func btnSelectSkillClicked(sender: UIButton) {
    }
}

extension ServiceOfferedViewController : ParserDelegate
{
    func parsingFinished(object: AnyObject?, withTag tag: NSInteger) {
        if tag == ParsingConstant.getListServicesOffered.rawValue
        {
            getServicesOffered()
        }
        else if tag == ParsingConstant.getServicesOffered.rawValue
        {
            app_delegate.removeloder()
        }
    }
    
    func parsingError(error: String?, withTag tag: NSInteger) {
        
    }
}