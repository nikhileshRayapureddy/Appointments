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

    @IBOutlet weak var txtBranchName: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtHouseName: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtTown: UITextField!
    @IBOutlet weak var txtCounty: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    var arrBranchesList = NSMutableArray()
    var selectedBranchBO = BranchBO()
    
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
        getListOfBranches()
    }
    
    func getListOfBranches()
    {
        app_delegate.showLoader("Loading...")
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getListBranches()
    }

    func btnNextClicked(sender : UIButton)
    {
        
    }

    @IBAction func btnViewListClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true{
            scrlVwAddBranch.hidden = true
            tableView.hidden = false
            tableView.reloadData()

        }
        else
        {
            scrlVwAddBranch.hidden = false
            tableView.hidden = true
            self.bindDataFromList(BranchBO())
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindDataFromList(branchDetails : BranchBO)
    {
        txtBranchName.text = branchDetails.strFirmName
        txtHouseName.text = branchDetails.strAddressLine1
        txtStreet.text = branchDetails.strAddressLine2
        txtTown.text = branchDetails.strCitynm
        txtCounty.text = branchDetails.strCountynm
        
        selectedBranchBO = branchDetails
    }
    @IBAction func btnSaveClicked(sender: UIButton) {
        
        let dictParams = NSMutableDictionary()
        dictParams.setObject("", forKey: "FirmId")
        dictParams.setObject(txtBranchName.text!, forKey: "FirmName")
        dictParams.setObject("", forKey: "FirmLogo")
//        dictParams.setObject(btnBusinessTypes.titleLabel!.text!, forKey: "BusinessType")
//        dictParams.setObject(btnBookingType.titleLabel!.text!, forKey: "BookingType")
//        dictParams.setObject(txtEmail.text!, forKey: "FirmEmail")
//        dictParams.setObject("", forKey: "PostalCode")
//        dictParams.setObject(txtContactNumber.text!, forKey: "FirmPrimaryPhone")
        dictParams.setObject(txtHouseName.text!, forKey: "AddressLine1")
        dictParams.setObject(txtStreet.text!, forKey: "AddressLine2")
        dictParams.setObject(txtTown.text!, forKey: "Citynm")
        dictParams.setObject(txtCounty.text!, forKey: "Countynm")
        dictParams.setObject("", forKey: "AllowExtBook")
        dictParams.setObject("1", forKey: "EnablePayment")
        dictParams.setObject("1", forKey: "ParentId")
        
        
        if selectedBranchBO.strFirmId.characters.count == 0
        {
            
        }
        else
        {
            dictParams.setObject(selectedBranchBO.strFirmId, forKey: "FirmId")
        }
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.addBusinessDetails(dictParams)
    }
}

extension AddBranchViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBranchesList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : AddBranchAddressCustomCell = tableView.dequeueReusableCellWithIdentifier("ADDRESSCELL") as! AddBranchAddressCustomCell
        cell.configureCell(indexPath, andArray: arrBranchesList)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        btnViewListClicked(btnViewList)
        bindDataFromList(arrBranchesList.objectAtIndex(indexPath.row) as! BranchBO)
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

extension AddBranchViewController : ParserDelegate
{
    func parsingError(error: String?, withTag tag: NSInteger) {
        app_delegate.removeloder()
        self.showAlert(error!, strTitle: "Failed!")

    }
    
    func parsingFinished(object: AnyObject?, withTag tag: NSInteger) {
        if tag == ParsingConstant.getListBranches.rawValue
        {
            app_delegate.removeloder()
            let response = object as! NSDictionary
            let models = response.objectForKey("Model")
            if ((models?.isKindOfClass(NSArray)) == true)
            {
                let modelsArray = models as! NSArray
                for dict in modelsArray
                {
                    let dictModel = dict as! NSDictionary
                    let branchBO = BranchBO()
                    let firmId = dictModel.objectForKey("FirmId") as? NSNumber
                    branchBO.strFirmId = (firmId?.stringValue)!
                    branchBO.strFirmName = (dictModel.objectForKey("FirmName") as? String)!
                    branchBO.strFirmEmail = (dictModel.objectForKey("FirmEmail") as? String)!
                    if ((dictModel["FirmLogo"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strFirmLogo = (dictModel.objectForKey("FirmLogo") as? String)!
                    }
                    branchBO.strBusinessType = (dictModel.objectForKey("BusinessType") as? String)!
                    if ((dictModel["BookingType"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strBookingType = (dictModel.objectForKey("BookingType") as? String)!
                    }
                    if ((dictModel["PostalCode"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strPostalCode = (dictModel.objectForKey("PostalCode") as? String)!
                    }
                    branchBO.strFirmPrimaryPhone = (dictModel.objectForKey("FirmPrimaryPhone") as? String)!
                    branchBO.strAddressLine1 = (dictModel.objectForKey("AddressLine1") as? String)!
                    branchBO.strAddressLine2 = (dictModel.objectForKey("AddressLine2") as? String)!
                    branchBO.strCitynm = (dictModel.objectForKey("Citynm") as? String)!
                    branchBO.strCountynm = (dictModel.objectForKey("Countynm") as? String)!
                    if ((dictModel["AllowExtBook"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strAllowExtBook = (dictModel.objectForKey("AllowExtBook") as? String)!
                    }
                    if ((dictModel["EnablePayment"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strEnablePayment = (dictModel.objectForKey("EnablePayment") as? String)!
                    }
                    if ((dictModel["ParentId"]?.isKindOfClass(NSNull)) == false)
                    {
                        let parentId = dictModel.objectForKey("ParentId") as? NSNumber
                        branchBO.strParentId = (parentId?.stringValue)!
                    }
                    
                    arrBranchesList.addObject(branchBO)
                }
            }
            else
            {
                let dictModel = models as! NSDictionary
                let branchBO = BranchBO()
                let firmId = dictModel.objectForKey("FirmId") as? NSNumber
                branchBO.strFirmId = (firmId?.stringValue)!
                branchBO.strFirmName = (dictModel.objectForKey("FirmName") as? String)!
                branchBO.strFirmEmail = (dictModel.objectForKey("FirmEmail") as? String)!
                if ((dictModel["FirmLogo"]?.isKindOfClass(NSNull)) == false)
                {
                    branchBO.strFirmLogo = (dictModel.objectForKey("FirmLogo") as? String)!
                }
                branchBO.strBusinessType = (dictModel.objectForKey("BusinessType") as? String)!
                if ((dictModel["BookingType"]?.isKindOfClass(NSNull)) == false)
                {
                    branchBO.strBookingType = (dictModel.objectForKey("BookingType") as? String)!
                }
                if ((dictModel["PostalCode"]?.isKindOfClass(NSNull)) == false)
                {
                    branchBO.strPostalCode = (dictModel.objectForKey("PostalCode") as? String)!
                }
                branchBO.strFirmPrimaryPhone = (dictModel.objectForKey("FirmPrimaryPhone") as? String)!
                branchBO.strAddressLine1 = (dictModel.objectForKey("AddressLine1") as? String)!
                branchBO.strAddressLine2 = (dictModel.objectForKey("AddressLine2") as? String)!
                branchBO.strCitynm = (dictModel.objectForKey("Citynm") as? String)!
                branchBO.strCountynm = (dictModel.objectForKey("Countynm") as? String)!
                if ((dictModel["AllowExtBook"]?.isKindOfClass(NSNull)) == false)
                {
                    branchBO.strAllowExtBook = (dictModel.objectForKey("AllowExtBook") as? String)!
                }
                if ((dictModel["EnablePayment"]?.isKindOfClass(NSNull)) == false)
                {
                    branchBO.strEnablePayment = (dictModel.objectForKey("EnablePayment") as? String)!
                }
                if ((dictModel["ParentId"]?.isKindOfClass(NSNull)) == false)
                {
                    let parentId = dictModel.objectForKey("ParentId") as? NSNumber
                    branchBO.strParentId = (parentId?.stringValue)!
                }
                
                arrBranchesList.addObject(branchBO)
            }
        }
    }
}
