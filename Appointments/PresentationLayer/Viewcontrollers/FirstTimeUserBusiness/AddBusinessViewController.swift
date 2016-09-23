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
    var arrSelectedBusinessTypeOptions = NSMutableArray()
    var arrSelectedBookingTypeOptions = NSMutableArray()
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
        
        
        var businessIds = ""
        for indexPath in arrSelectedBusinessTypeOptions
        {
            let dict = arrBusinessTypes.objectAtIndex(indexPath.row) as! NSDictionary
            if businessIds.characters.count == 0
            {
                let businessIdNumber = dict.objectForKey("Id") as! NSInteger
                businessIds = String(format: "%d", businessIdNumber)
            }
            else
            {
                let businessIdNumber = dict.objectForKey("Id") as! NSInteger
                businessIds = String(format: "%@,%d", businessIds,businessIdNumber)
            }
        }

        
        dictParams.setObject(businessIds, forKey: "BusinessType")
        
        var bookingIds = ""
        for indexPath in arrSelectedBookingTypeOptions
        {
            let dict = arrBusinessBookingTypes.objectAtIndex(indexPath.row) as! NSDictionary
            if bookingIds.characters.count == 0
            {
                let bookingIdNumber = dict.objectForKey("Id") as! NSInteger
                bookingIds = String(format: "%d", bookingIdNumber)
            }
            else
            {
                let bookingIdNumber = dict.objectForKey("Id") as! NSInteger
                bookingIds = String(format: "%@,%d", bookingIds,bookingIdNumber)
            }
        }
        
        
        dictParams.setObject(bookingIds, forKey: "BookingType")
        dictParams.setObject(txtEmail.text!, forKey: "FirmEmail")
        dictParams.setObject("", forKey: "PostalCode")
        dictParams.setObject(txtContactNumber.text!, forKey: "FirmPrimaryPhone")
        dictParams.setObject(txtHouseName.text!, forKey: "AddressLine1")
        dictParams.setObject(txtStreet.text!, forKey: "AddressLine2")
        dictParams.setObject(txtTown.text!, forKey: "Citynm")
        dictParams.setObject(txtCounty.text!, forKey: "Countynm")
        dictParams.setObject("", forKey: "AllowExtBook")
        dictParams.setObject("1", forKey: "EnablePayment")
        dictParams.setObject(txtCountry.text!, forKey: "Country")
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
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == txtContactNumber
        {
            if range.length + range.location > textField.text?.characters.count
            {
                return false
            }
            
            let newLength : Int = (textField.text?.characters.count)! + string.characters.count - range.length
            return newLength <= 10;
        }
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
            let dictResponse = object as! NSDictionary
            let model = dictResponse.objectForKey("Model") as! NSDictionary
            let defaults = NSUserDefaults.standardUserDefaults()
            let firmId = model["ReturnTypeValue"]
            defaults.setValue(firmId?.integerValue, forKey: "FIRMID")
            defaults.synchronize()
            let StatusFlag = defaults.valueForKey("StatusFlag") as! NSInteger
            
            if StatusFlag <= 0
            {
                defaults.setValue(1, forKey: "StatusFlag")
            }
            defaults.synchronize()

            dispatch_async(dispatch_get_main_queue(), {
                
                let alert = UIAlertController(title: "Success!", message: "Business saved successfully.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:
                    { action in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewControllerWithIdentifier("AddBranchViewController") as! AddBranchViewController
                        if self.navigationController!.visibleViewController?.isKindOfClass(AddBranchViewController) == true
                        {
                            return
                        }
                        self.navigationController?.pushViewController(vc, animated: false)

                        
                }))
                self.presentViewController(alert, animated: true, completion: nil)
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
        if ((dictBusiness["FirmId"]?.isKindOfClass(NSNull)) == false)
        {
            let firmId = dictBusiness.objectForKey("FirmId") as? NSNumber
            businessBO.strFirmId = (firmId?.stringValue)!

        }
        
        if businessBO.strFirmId == ""
        {
            isSaved = false
        }
        else
        {
            isSaved = true
        }
        if ((dictBusiness["FirmName"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strFirmName = (dictBusiness.objectForKey("FirmName") as? String)!
        }

        if ((dictBusiness["FirmEmail"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strFirmEmail = (dictBusiness.objectForKey("FirmEmail") as? String)!
        }
        
        if ((dictBusiness["FirmLogo"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strFirmLogo = (dictBusiness.objectForKey("FirmLogo") as? String)!
        }
        if ((dictBusiness["BusinessType"]?.isKindOfClass(NSNull)) == false)
        {
            let BookingType = dictBusiness.objectForKey("BusinessType") as? NSNumber
            var dictSelBookingType = NSDictionary()
            for dict  in arrBusinessTypes
            {
                let dictTemp = dict as? NSDictionary
                let Id = dictTemp!["Id"] as? NSNumber
                if Id == BookingType
                {
                    dictSelBookingType = dictTemp!
                }
            }
            if dictSelBookingType.allKeys.count == 0
            {
                businessBO.strBusinessType = ""
            }
            else
            {
                let title = dictSelBookingType["Name"] as? String
                businessBO.strBusinessType = title!
            }
        }
        
        if ((dictBusiness["BookingType"]?.isKindOfClass(NSNull)) == false)
        {
            let BookingType = dictBusiness.objectForKey("BookingType") as? NSNumber
            var dictSelBookingType = NSDictionary()
            for dict  in arrBusinessBookingTypes
            {
                let dictTemp = dict as? NSDictionary
                let Id = dictTemp!["Id"] as! Int
                if Id == Int(BookingType!)
                {
                    dictSelBookingType = dictTemp!
                }
            }
            if dictSelBookingType.allKeys.count == 0
            {
                businessBO.strBookingType = ""
            }
            else
            {
                let title = dictSelBookingType["Name"] as? String
                businessBO.strBookingType = title!
            }
            
        }
        if ((dictBusiness["PostalCode"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strPostalCode = (dictBusiness.objectForKey("PostalCode") as? String)!
        }
        if ((dictBusiness["FirmPrimaryPhone"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strFirmPrimaryPhone = (dictBusiness.objectForKey("FirmPrimaryPhone") as? String)!
        }
        
        if ((dictBusiness["AddressLine1"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strAddressLine1 = (dictBusiness.objectForKey("AddressLine1") as? String)!
        }
        
        if ((dictBusiness["AddressLine2"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strAddressLine2 = (dictBusiness.objectForKey("AddressLine2") as? String)!
        }
        
        if ((dictBusiness["Citynm"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strCitynm = (dictBusiness.objectForKey("Citynm") as? String)!
        }
        
        if ((dictBusiness["Countynm"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strCountynm = (dictBusiness.objectForKey("Countynm") as? String)!
        }
        if ((dictBusiness["Country"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strCountrynm = (dictBusiness.objectForKey("Country") as? String)!
        }
      
        if ((dictBusiness["AllowExtBook"]?.isKindOfClass(NSNull)) == false)
        {
            businessBO.strAllowExtBook = (dictBusiness.objectForKey("AllowExtBook") as? String)!
        }
        if ((dictBusiness["EnablePayment"]?.isKindOfClass(NSNull)) == false)
        {
            let EnablePayment = dictBusiness.objectForKey("EnablePayment") as? NSNumber
            businessBO.strEnablePayment = (EnablePayment?.stringValue)!
        }
        if ((dictBusiness["ParentId"]?.isKindOfClass(NSNull)) == false)
        {
            let parentId = dictBusiness.objectForKey("ParentId") as? NSNumber
            businessBO.strParentId = (parentId?.stringValue)!
        }
        dispatch_async(dispatch_get_main_queue()) { 
            self.txtBusinessName.text = businessBO.strFirmName
            
            if businessBO.strBusinessType == ""
            {
                self.btnBusinessTypes.setTitle("Type of Business", forState: UIControlState.Normal)
                self.btnBusinessTypes.setTitleColor(UIColor(red: 187.0/255.0, green: 188.0/255.0, blue: 190.0/255.0, alpha: 1.0), forState: .Normal)
            }
            else
            {
                self.btnBusinessTypes.setTitle(businessBO.strBusinessType, forState: UIControlState.Normal)
                self.btnBusinessTypes.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
            if businessBO.strBookingType == ""
            {
                self.btnBookingType.setTitle("Type of Booking", forState: UIControlState.Normal)
                self.btnBookingType.setTitleColor(UIColor(red: 187.0/255.0, green: 188.0/255.0, blue: 190.0/255.0, alpha: 1.0), forState: .Normal)
            }
            else
            {
                self.btnBookingType.setTitle(businessBO.strBookingType, forState: UIControlState.Normal)
                self.btnBookingType.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
            self.txtEmail.text = businessBO.strFirmEmail
            self.txtContactNumber.text = businessBO.strFirmPrimaryPhone
            self.txtHouseName.text = businessBO.strAddressLine1
            self.txtCounty.text = businessBO.strCountynm
            self.txtCountry.text = businessBO.strCountrynm
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
            arrSelectedBookingTypeOptions.removeAllObjects()
            arrSelectedBookingTypeOptions.addObjectsFromArray(arrSelected as [AnyObject])
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
            arrSelectedBusinessTypeOptions.removeAllObjects()
            arrSelectedBusinessTypeOptions.addObjectsFromArray(arrSelected as [AnyObject])
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