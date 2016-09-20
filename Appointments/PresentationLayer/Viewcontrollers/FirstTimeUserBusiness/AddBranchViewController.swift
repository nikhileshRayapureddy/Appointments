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
    var isSaved = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrlVwAddBranch.contentSize = CGSizeMake(scrlVwAddBranch.frame.size.width, 570)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
        self.designNavBar("Add Branch")
        self.designTabBar()
        self.setSelected(2)
        let btnNext : UIButton = UIButton(type: UIButtonType.Custom)
        btnNext.frame =  CGRectMake(0, 0, 50,44)
        btnNext.setTitle("Next", forState: UIControlState.Normal)
        btnNext.setTitle("Next", forState: UIControlState.Highlighted)
        btnNext.setTitle("Next", forState: UIControlState.Selected)
        btnNext.addTarget(self, action: #selector(self.btnNextClicked(_:)), forControlEvents: .TouchUpInside)
        btnNext.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btnNext.titleLabel?.textAlignment = NSTextAlignment.Right
        let rightBarButtonItems = UIView()
        rightBarButtonItems.frame = CGRectMake(ScreenWidth - 90, 0, 50, 44)
        rightBarButtonItems.addSubview(btnNext)
        let bItem = UIBarButtonItem(customView:rightBarButtonItems)
        self.navigationItem.rightBarButtonItem = bItem

        
        let btnHome : UIButton = UIButton(type: UIButtonType.Custom)
        btnHome.frame =  CGRectMake(0, 0, 50,44)
        btnHome.setTitle("Home", forState: UIControlState.Normal)
        btnHome.setTitle("Home", forState: UIControlState.Highlighted)
        btnHome.setTitle("Home", forState: UIControlState.Selected)
        btnHome.addTarget(self, action: #selector(self.btnHomeClicked(_:)), forControlEvents: .TouchUpInside)
        btnHome.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        let leftBarButtonItems = UIView()
        leftBarButtonItems.frame = CGRectMake(ScreenWidth - 90, 0, 50, 44)
        leftBarButtonItems.addSubview(btnHome)
        let bLeftItem = UIBarButtonItem(customView:leftBarButtonItems)
        self.navigationItem.leftBarButtonItem = bLeftItem
        scrlVwAddBranch.hidden = false
        tableView.hidden = true
    }
    func btnHomeClicked(sender : UIButton)
    {
        var isVcPresent = false
        var VC : UIViewController!
        
        for vc in (self.navigationController?.viewControllers)!
        {
            if vc.isKindOfClass(HomeViewController)
            {
                isVcPresent = true
                VC = vc
            }
        }
        if isVcPresent == true
        {
            self.navigationController?.popToViewController(VC, animated: true)
        }
        else
        {
            let vc : HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            self.navigationController!.pushViewController(vc, animated: true)
            
        }
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddCalenderViewController") as! AddCalenderViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }

    @IBAction func btnViewListClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true{
            scrlVwAddBranch.hidden = true
            tableView.hidden = false
            self.getListOfBranches()
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
        txtLocation.text = branchDetails.strPostalCode
        txtCountry.text = branchDetails.strCountry
        selectedBranchBO = branchDetails
    }
    @IBAction func btnSaveClicked(sender: UIButton) {
        
        let dictParams = NSMutableDictionary()
        dictParams.setObject("", forKey: "FirmId")
        dictParams.setObject(txtBranchName.text!, forKey: "FirmName")
        dictParams.setObject("", forKey: "FirmLogo")
        dictParams.setObject(txtHouseName.text!, forKey: "AddressLine1")
        dictParams.setObject(txtStreet.text!, forKey: "AddressLine2")
        dictParams.setObject(txtTown.text!, forKey: "Citynm")
        dictParams.setObject(txtCounty.text!, forKey: "Countynm")
        dictParams.setObject("", forKey: "AllowExtBook")
        dictParams.setObject("1", forKey: "EnablePayment")
        dictParams.setObject(txtLocation.text!, forKey: "PostalCode")
        dictParams.setObject(txtCountry.text!, forKey: "Country")

        let layer = BusinessLayerClass()
        layer.callBack = self

        if selectedBranchBO.strFirmId.characters.count == 0
        {
            let defaults = NSUserDefaults.standardUserDefaults()
            let firmValue = defaults.valueForKey("FIRMID") as! NSInteger
            dictParams.setObject(String (firmValue), forKey: "ParentId")
            layer.addBusinessDetails(dictParams)

        }
        else
        {
            dictParams.setObject(selectedBranchBO.strFirmId, forKey: "FirmId")
            layer.UpdateBusinessDetails(dictParams)

        }
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
            arrBranchesList.removeAllObjects()
            let response = object as! NSDictionary
            let models = response.objectForKey("Model")
            if ((models?.isKindOfClass(NSArray)) == true)
            {
                let modelsArray = models as! NSArray
                for dict in modelsArray
                {
                    let dictModel = dict as! NSDictionary
                    let branchBO = BranchBO()
                    if ((dictModel["FirmId"]?.isKindOfClass(NSNull)) == false)
                    {
                        let firmId = dictModel.objectForKey("FirmId") as? NSNumber
                        branchBO.strFirmId = (firmId?.stringValue)!
                    }
                    
                    if ((dictModel["FirmName"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strFirmName = (dictModel.objectForKey("FirmName") as? String)!
                    }
                    if ((dictModel["FirmEmail"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strFirmEmail = (dictModel.objectForKey("FirmEmail") as? String)!
                    }

                    if ((dictModel["FirmLogo"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strFirmLogo = (dictModel.objectForKey("FirmLogo") as? String)!
                    }
                    if ((dictModel["BusinessType"]?.isKindOfClass(NSNull)) == false)
                    {
                        let BusinessType = dictModel.objectForKey("BusinessType") as? NSNumber
                        branchBO.strBusinessType = (BusinessType?.stringValue)!
                    }

                    if ((dictModel["BookingType"]?.isKindOfClass(NSNull)) == false)
                    {
                        let BookingType = dictModel.objectForKey("BookingType") as? NSNumber
                        branchBO.strBookingType = (BookingType?.stringValue)!
                    }
                    if ((dictModel["PostalCode"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strPostalCode = (dictModel.objectForKey("PostalCode") as? String)!
                    }
                    if ((dictModel["FirmPrimaryPhone"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strFirmPrimaryPhone = (dictModel.objectForKey("FirmPrimaryPhone") as? String)!
                    }
                    if ((dictModel["AddressLine1"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strAddressLine1 = (dictModel.objectForKey("AddressLine1") as? String)!
                    }
                    if ((dictModel["AddressLine2"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strAddressLine2 = (dictModel.objectForKey("AddressLine2") as? String)!
                    }
                    if ((dictModel["Citynm"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strCitynm = (dictModel.objectForKey("Citynm") as? String)!
                    }
                    if ((dictModel["Countynm"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strCountynm = (dictModel.objectForKey("Countynm") as? String)!
                    }
                    if ((dictModel["Country"]?.isKindOfClass(NSNull)) == false)
                    {
                        branchBO.strCountry = (dictModel.objectForKey("Country") as? String)!
                    }

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
            
            
            tableView.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
        }
        else
        {
            self.performSelectorOnMainThread(#selector(self.bindDataFromList), withObject: BranchBO(), waitUntilDone: true)
        }
    }
}
