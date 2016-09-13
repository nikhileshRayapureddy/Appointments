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


class AddBusinessViewController: BaseViewController {

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
    @IBOutlet weak var tableView: UITableView!
    
    var arrBusinessTypes : NSMutableArray! = NSMutableArray()
    var arrBusinessBookingTypes : NSMutableArray! = NSMutableArray()
    var viewSelectOptions = SelectOptionsCustomView()
    var arrSelectedOptions = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrlVw.contentSize = CGSizeMake(scrlVw.frame.size.width, 580)

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false

        // Do any additional setup after loading the view.
        self.designNavBar("Add Business")
        self.designTabBar()
        self.setSelected(1)
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
        getBusinessTypes()
    }
    
    func bindBusinessData(dictBusiness : NSDictionary)
    {
        txtBusinessName.text = dictBusiness.objectForKey("FirmName") as? String
        btnBusinessTypes.setTitle(dictBusiness.objectForKey("BusinessType") as? String, forState: UIControlState.Normal)
        btnBookingType.setTitle(dictBusiness.objectForKey("BookingType") as? String, forState: UIControlState.Normal)
        txtEmail.text = dictBusiness.objectForKey("FirmEmail") as? String
        txtContactNumber.text = dictBusiness.objectForKey("FirmPrimaryPhone") as? String
        txtHouseName.text = dictBusiness.objectForKey("AddressLine1") as? String
    }
    
    func btnNextClicked(sender : UIButton)
    {
        let dictParams = NSMutableDictionary()
        dictParams.setObject("", forKey: "FirmId")
        dictParams.setObject(txtBusinessName.text!, forKey: "FirmName")
        dictParams.setObject("", forKey: "FirmLogo")
        dictParams.setObject(btnBusinessTypes.titleLabel!.text!, forKey: "BusinessType")
        dictParams.setObject(btnBookingType.titleLabel!.text!, forKey: "BookingType")
        dictParams.setObject(txtEmail.text!, forKey: "FirmEmail")
        dictParams.setObject("", forKey: "PostalCode")
        dictParams.setObject(txtContactNumber.text!, forKey: "FirmPrimaryPhone")
        dictParams.setObject(txtHouseName.text!, forKey: "AddressLine1")
        dictParams.setObject(txtStreet.text!, forKey: "AddressLine2")
        dictParams.setObject(txtTown.text!, forKey: "Citynm")
        dictParams.setObject(txtCounty.text!, forKey: "Countynm")
        dictParams.setObject("", forKey: "AllowExtBook")
        dictParams.setObject("", forKey: "EnablePayment")
        dictParams.setObject("1", forKey: "ParentId")
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.addBusinessDetails(dictParams)
    }
    
    @IBAction func btnBusinessTypesClicked(sender: UIButton) {
        
        if let view : SelectOptionsCustomView = NSBundle.mainBundle().loadNibNamed("SelectOptionsCustomView", owner: nil, options: nil)[0] as? SelectOptionsCustomView
        {
            view.frame = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height+64)
            view.isMultipleSelection = false
            view.viewTag = OptionsSelection.BusinessTypes.rawValue
            view.delegate = self
            view.arrTitles = arrBusinessTypes
            view.resizeView()
            viewSelectOptions = view
            self.view.addSubview(view)
        }
        
    }
    @IBAction func btnBookingTypeClicked(sender: UIButton) {
        if let view : SelectOptionsCustomView = NSBundle.mainBundle().loadNibNamed("SelectOptionsCustomView", owner: nil, options: nil)[0] as? SelectOptionsCustomView
        {
            view.frame = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height+64)
            view.isMultipleSelection = false
            view.viewTag = OptionsSelection.BookingTypes.rawValue
            view.delegate = self
            view.arrTitles = arrBusinessBookingTypes
            view.resizeView()
            viewSelectOptions = view
            self.view.addSubview(view)
        }
    }
    @IBAction func btnViewListClicked(sender: UIButton) {
        
        if sender.selected == true
        {
            scrlVw.hidden = false
            tableView.hidden = true

        }
        else
        {
            scrlVw.hidden = true
            tableView.hidden = false
            
        }
        sender.selected = !sender.selected
        
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
            getBusiness()
        }
        else if tag == ParsingConstant.getBusiness.rawValue
        {
            app_delegate.removeloder()

        }
        else if tag == ParsingConstant.addBusiness.rawValue
        {
            
        }
        
        
    }
    func parsingError(error: String?, withTag tag: NSInteger) {
        app_delegate.removeloder()
        self.showAlert(error!, strTitle: "Failed!")
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
        
        if tag == OptionsSelection.BookingTypes.rawValue
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
        }
        else if tag == OptionsSelection.BusinessTypes.rawValue
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