//
//  AddBusinessViewController.swift
//  Appointments
//
//  Created by Nikhilesh on 10/08/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

enum OptionsSelection : Int
{
    case BusinessTypes = 3235
    case BookingTypes
}


class AddBusinessViewController: BaseViewController,UITextFieldDelegate {

    @IBOutlet weak var btnBookingType: UIButton!
    @IBOutlet weak var btnBusinessTypes: UIButton!
    @IBOutlet weak var scrlVw: UIScrollView!
    
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtTown: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtCounty: UITextField!
    @IBOutlet weak var txtHouseName: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtBusinessName: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    var currenttextField : UITextField!
    var arrBusinessTypes : NSMutableArray! = NSMutableArray()
    var arrBusinessBookingTypes : NSMutableArray! = NSMutableArray()
    var viewSelectOptions = SelectOptionsCustomView()
    var arrSelectedOptions = NSMutableArray()
    var isSaved = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrlVw.contentSize = CGSizeMake(scrlVw.frame.size.width, 750)

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
        
        // Do any additional setup after loading the view.
        self.designNavBar("Add Business")
        self.designTabBar()
        self.setSelected(1)
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
        self.getBusinessTypes()
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

    func bindBusinessData(dictBusiness : NSDictionary)
    {
        txtBusinessName.text = dictBusiness.objectForKey("FirmName") as? String
        btnBusinessTypes.setTitle(dictBusiness.objectForKey("BusinessType") as? String, forState: UIControlState.Normal)
        btnBusinessTypes.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnBookingType.setTitle(dictBusiness.objectForKey("BookingType") as? String, forState: UIControlState.Normal)
        btnBookingType.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        txtEmail.text = dictBusiness.objectForKey("FirmEmail") as? String
        txtContactNumber.text = dictBusiness.objectForKey("FirmPrimaryPhone") as? String
        txtHouseName.text = dictBusiness.objectForKey("AddressLine1") as? String
    }
    
    func btnNextClicked(sender : UIButton)
    {
        if isSaved == true
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("AddBranchViewController") as! AddBranchViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else
        {
            self.showAlertWithMessage("Please Add business to continue.")
        }
        
    }
    
    @IBAction func btnBusinessTypesClicked(sender: UIButton) {
        if currenttextField != nil
        {
            currenttextField.resignFirstResponder()
        }
        if let view : SelectOptionsCustomView = NSBundle.mainBundle().loadNibNamed("SelectOptionsCustomView", owner: nil, options: nil)[0] as? SelectOptionsCustomView
        {
            view.frame = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height+64)
            view.isMultipleSelection = false
            view.viewTag = optionSelection.businessType.rawValue
            view.delegate = self
            view.arrTitles = arrBusinessTypes
            view.resizeView()
            viewSelectOptions = view
            self.view.addSubview(view)
        }
        
    }
    @IBAction func btnBookingTypeClicked(sender: UIButton)
    {
        if currenttextField != nil
        {
         currenttextField.resignFirstResponder()
        }
        if let view : SelectOptionsCustomView = NSBundle.mainBundle().loadNibNamed("SelectOptionsCustomView", owner: nil, options: nil)[0] as? SelectOptionsCustomView
        {
            view.frame = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height+64)
            view.isMultipleSelection = false
            view.viewTag = optionSelection.bookingType.rawValue
            view.delegate = self
            view.arrTitles = arrBusinessBookingTypes
            view.resizeView()
            viewSelectOptions = view
            self.view.addSubview(view)
        }
    }
    
    @IBAction func btnSaveClicked(sender: UIButton) {
        let dictParams = NSMutableDictionary()
        let defaults = NSUserDefaults.standardUserDefaults()
        let firmValue = defaults.valueForKey("FIRMID") as! NSInteger
        dictParams.setObject(txtBusinessName.text!, forKey: "FirmName")
        dictParams.setObject("asd", forKey: "FirmLogo")
        dictParams.setObject("2", forKey: "BusinessType")
        dictParams.setObject("2", forKey: "BookingType")
        dictParams.setObject(txtEmail.text!, forKey: "FirmEmail")
        dictParams.setObject("", forKey: "PostalCode")
        dictParams.setObject(txtContactNumber.text!, forKey: "FirmPrimaryPhone")
        dictParams.setObject(txtHouseName.text!, forKey: "AddressLine1")
        dictParams.setObject(txtStreet.text!, forKey: "AddressLine2")
        dictParams.setObject(txtTown.text!, forKey: "Citynm")
        dictParams.setObject(txtCounty.text!, forKey: "Countynm")
        dictParams.setObject("", forKey: "AllowExtBook")
        dictParams.setObject("1", forKey: "EnablePayment")
        dictParams.setObject("UK", forKey: "Country")
        let firmUserValue = defaults.valueForKey("USERID") as! NSInteger

        dictParams.setObject(String (firmUserValue), forKey: "UserId")

        let layer = BusinessLayerClass()
        layer.callBack = self
        if firmValue != 0
        {
            dictParams.setObject(String (firmValue), forKey: "FirmId")
            layer.UpdateBusinessDetails(dictParams)

        }
        else
        {
            dictParams.setObject("", forKey: "ParentId")
            layer.addBusinessDetails(dictParams)

        }

    }
    func getBusinessTypes()
    {
        app_delegate.showLoader("Loading...")
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getBusinessTypes()
    }
    
    func getBusinessBookingTypes()
    {
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getBusinessBookingTypes()
    }
    
    func getBusiness()
    {
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getBusiness()
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        currenttextField = textField
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        currenttextField.resignFirstResponder()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension AddBusinessViewController : ParserDelegate
{
    func parsingFinished(object: AnyObject?, withTag tag: NSInteger) {
        if (tag == ParsingConstant.getBusinessTypes.rawValue)
        {
            let response = object as! NSDictionary
             arrBusinessTypes.addObjectsFromArray(response.objectForKey("Model") as! NSArray as [AnyObject])
            print(arrBusinessTypes.description)
            getBusinessBookingTypes()
        }
        else if tag == ParsingConstant.getBusinessBookingTypes.rawValue
        {
            let response = object as! NSDictionary
            arrBusinessBookingTypes.addObjectsFromArray(response.objectForKey("Model") as! NSArray as [AnyObject])
            print(arrBusinessBookingTypes.description)
            let defaults = NSUserDefaults.standardUserDefaults()
            let firmValue = defaults.valueForKey("FIRMID") as! NSInteger

            if firmValue != 0
            {
                getBusiness()
            }
            else
            {
                app_delegate.removeloder()
            }

        }
        else if tag == ParsingConstant.getBusiness.rawValue
        {
            app_delegate.removeloder()
            parseBusinessData(object!)
        }
        else if tag == ParsingConstant.addBusiness.rawValue
        {
            isSaved = true
            
            dispatch_async(dispatch_get_main_queue(), { 
//                self.showAlertWithMessage("")
            })
        }
        
        
    }
    func parsingError(error: String?, withTag tag: NSInteger) {
        app_delegate.removeloder()
        self.showAlert(error!, strTitle: "Failed!")
    }
    
    func parseBusinessData(object : AnyObject)
    {
        let response = object as! NSDictionary
        
        let dictBusiness = response.objectForKey("Model") as! NSDictionary
        let businessBO = AddBusinessBO()
        let firmId = dictBusiness.objectForKey("FirmId") as? NSNumber
        businessBO.strFirmId = (firmId?.stringValue)!
        
        if businessBO.strFirmId == ""
        {
            isSaved = false
        }
        else
        {
            isSaved = true
        }
        businessBO.strFirmName = (dictBusiness.objectForKey("FirmName") as? String)!
        businessBO.strFirmEmail = (dictBusiness.objectForKey("FirmEmail") as? String)!
        if ((dictBusiness["FirmLogo"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strFirmLogo = (dictBusiness.objectForKey("FirmLogo") as? String)!
        }
        let BusinessType = dictBusiness.objectForKey("BusinessType") as? NSNumber
        businessBO.strBusinessType = (BusinessType?.stringValue)!
        let BookingType = dictBusiness.objectForKey("BookingType") as? NSNumber
        businessBO.strBookingType = (BookingType?.stringValue)!
        if ((dictBusiness["PostalCode"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strPostalCode = (dictBusiness.objectForKey("PostalCode") as? String)!
        }
        businessBO.strFirmPrimaryPhone = (dictBusiness.objectForKey("FirmPrimaryPhone") as? String)!
        businessBO.strAddressLine1 = (dictBusiness.objectForKey("AddressLine1") as? String)!
        businessBO.strAddressLine2 = (dictBusiness.objectForKey("AddressLine2") as? String)!
        businessBO.strCitynm = (dictBusiness.objectForKey("Citynm") as? String)!
        businessBO.strCountynm = (dictBusiness.objectForKey("Countynm") as? String)!
        if ((dictBusiness["AllowExtBook"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strAllowExtBook = (dictBusiness.objectForKey("AllowExtBook") as? String)!
        }
        if ((dictBusiness["EnablePayment"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strEnablePayment = (dictBusiness.objectForKey("EnablePayment") as? String)!
        }
        if ((dictBusiness["ParentId"]?.isKindOfClass(NSNull)) == false)
        {
            let parentId = dictBusiness.objectForKey("ParentId") as? NSNumber
            businessBO.strParentId = (parentId?.stringValue)!
        }
        dispatch_async(dispatch_get_main_queue()) { 
            self.txtBusinessName.text = businessBO.strFirmName
            self.btnBusinessTypes.setTitle(businessBO.strBusinessType, forState: UIControlState.Normal)
            self.btnBusinessTypes.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            self.btnBookingType.setTitle(businessBO.strBookingType, forState: UIControlState.Normal)
            self.btnBookingType.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            self.txtEmail.text = businessBO.strFirmEmail
            self.txtContactNumber.text = businessBO.strFirmPrimaryPhone
            self.txtHouseName.text = businessBO.strAddressLine1
            self.txtCounty.text = businessBO.strCountynm
            self.txtStreet.text = businessBO.strAddressLine2
            self.txtTown.text = businessBO.strCitynm
        }
        
    }
}

extension AddBusinessViewController : SelectOptionsCustomView_Delegate
{
    func removeSelectionOptionsPopup() {
        viewSelectOptions.delegate =  nil
        viewSelectOptions.removeFromSuperview()
    }
    
    func selectedOptions(arrSelected: NSMutableArray, withTag tag: Int) {
        viewSelectOptions.delegate =  nil
        viewSelectOptions.removeFromSuperview()
        
        if tag == optionSelection.bookingType.rawValue
        {
            var title = ""
            for indexPath in arrSelected
            {
                let dict = arrBusinessBookingTypes.objectAtIndex(indexPath.row) as! NSDictionary
                if title.characters.count == 0
                {
                    title = dict.objectForKey("Name") as! String
                }
                else
                {
                    title = String(format: "%@,%@", title,dict.objectForKey("Name") as! String)
                }
            }
            btnBookingType.setTitle(title, forState: UIControlState.Normal)
            btnBookingType.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
        else if tag == optionSelection.businessType.rawValue
        {
            var title = ""
            for indexPath in arrSelected
            {
                let dict = arrBusinessTypes.objectAtIndex(indexPath.row) as! NSDictionary
                if title.characters.count == 0
                {
                    title = dict.objectForKey("Name") as! String
                }
                else
                {
                    title = String(format: "%@,%@", title,dict.objectForKey("Name") as! String)
                }
            }
            btnBusinessTypes.setTitle(title, forState: UIControlState.Normal)
            btnBusinessTypes.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)

        }
    }
    
    func showAlertWithMessage(message: String) {
        showAlert(message, strTitle: "Alert")
    }
}

extension AddBusinessViewController : UITableViewDelegate, UITableViewDataSource
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
        
        let cell : AddBusinessCustomCell = tableView.dequeueReusableCellWithIdentifier("BUSINESSCELL") as! AddBusinessCustomCell
        cell.configureCell()
        return cell
    }

    
}