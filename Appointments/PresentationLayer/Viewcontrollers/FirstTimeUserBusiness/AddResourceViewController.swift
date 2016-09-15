//
//  AddResourceViewController.swift
//  Appointments
//
//  Created by Nikhilesh on 10/08/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class AddResourceViewController: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnViewList: UIButton!
    @IBOutlet weak var scrlVwAddAddResource: UIScrollView!
    
    @IBOutlet weak var btnWorkingPattern: UIButton!
    @IBOutlet weak var txtPriority: UITextField!
    @IBOutlet weak var txtFldSkillLevel: UITextField!
    @IBOutlet weak var txtFldContactNumber: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldResourceName: UITextField!
    var arrWorkingPatternList = NSMutableArray()
    var arrSelectedWorkingPatternList = NSMutableArray()
    var viewSelectOptions = SelectOptionsCustomView()
    var selectedReourceBO = ResourceBO()
    
    var arrResourcesList = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.designNavBar("Add Resource")
        self.designTabBar()
        self.setSelected(6)
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
        scrlVwAddAddResource.hidden = false
        tableView.hidden = true
        getAllWorkingPatterns()
    }
    func btnNextClicked(sender : UIButton)
    {
        
    }
    
    func getAllWorkingPatterns()
    {
        app_delegate.showLoader("")
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getAllWorkingPatterns()
    }
    
    func getListResources()
    {
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getListResources()

    }

    @IBAction func btnViewListClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true{
            scrlVwAddAddResource.hidden = true
            tableView.hidden = false
            tableView.reloadData()
        }
        else
        {
            scrlVwAddAddResource.hidden = false
            tableView.hidden = true
            bindDataFromList(ResourceBO())

        }
    }

    @IBAction func btnSaveClicked(sender: UIButton) {
        
        let dictParams = NSMutableDictionary()
        let defualts = NSUserDefaults.standardUserDefaults()
        dictParams.setObject(txtFldResourceName.text!, forKey: "ResourceName")
        dictParams.setObject("", forKey: "Capacity")
        dictParams.setObject(txtFldEmail.text!, forKey: "EMail")
        dictParams.setObject(txtFldSkillLevel.text!, forKey: "SkillLevel")
        
        dictParams.setObject("", forKey: "SkillString")
        let firmValue = defualts.valueForKey("FIRMID") as! NSInteger
        
        dictParams.setObject(String (firmValue), forKey: "FirmId")
        var skillString = ""
        for indexPath in arrSelectedWorkingPatternList
        {
            let dict = arrWorkingPatternList.objectAtIndex(indexPath.row) as! WorkPatternListBO
            if skillString.characters.count == 0
            {
                skillString = dict.strFirmWPId
            }
            else
            {
                skillString = String(format: "%@,%@", skillString,dict.strFirmWPId)
            }
        }
        dictParams.setObject(skillString, forKey: "WPId")
        let layer = BusinessLayerClass()
        layer.callBack = self
        if selectedReourceBO.strFirmId.characters.count == 0
        {
            layer.addResource(dictParams)
        }
        else
        {
            if skillString.characters.count == 0
            {
                dictParams.setObject(selectedReourceBO.strWPId, forKey: "WPId")
            }
            dictParams.setObject(selectedReourceBO.strPriority, forKey: "Priority")
            dictParams.setObject(selectedReourceBO.strResourceType, forKey: "ResourceType")
            dictParams.setObject(selectedReourceBO.strCapacity, forKey: "Capacity")
            dictParams.setObject(selectedReourceBO.strSkillString, forKey: "SkillString")
            dictParams.setObject(selectedReourceBO.strResourceId, forKey: "ResourceId")
            layer.updateResource(dictParams)
        }
        
    }
    
    func bindDataFromList(service : ResourceBO)
    {
        txtFldResourceName.text = service.strResourceName
        txtFldEmail.text = service.strEmail
        txtFldSkillLevel.text = service.strSkillLevel
        txtPriority.text = service.strPriority
        selectedReourceBO = service
        
        if service.strWPId.characters.count == 0
        {
            btnWorkingPattern.setTitle("Working Pattern", forState: UIControlState.Normal)
            btnWorkingPattern.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        }
        else
        {
            let resultPredicate = NSPredicate(format: "strFirmWPId contains[c] %@", service.strWPId)
            let arr = arrWorkingPatternList.filteredArrayUsingPredicate(resultPredicate) as NSArray
            if arr.count > 0
            {
                let workPattern = arr.objectAtIndex(0) as! WorkPatternListBO
                btnWorkingPattern.setTitle(workPattern.strPatternName, forState: UIControlState.Normal)
                btnWorkingPattern.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
            else
            {
                btnWorkingPattern.setTitle("Working Pattern", forState: UIControlState.Normal)
                btnWorkingPattern.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            }
        }
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension AddResourceViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrResourcesList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : ResourcesListCustomCell = tableView.dequeueReusableCellWithIdentifier("RESOURCECELL") as! ResourcesListCustomCell
        cell.configureResourceCell(indexPath, andArray: arrResourcesList)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        btnViewListClicked(btnViewList)
        bindDataFromList(arrResourcesList.objectAtIndex(indexPath.row) as! ResourceBO)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func btnWorkingPatternClicked(sender: UIButton) {
        if let view : SelectOptionsCustomView = NSBundle.mainBundle().loadNibNamed("SelectOptionsCustomView", owner: nil, options: nil)[0] as? SelectOptionsCustomView
        {
            view.frame = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height+64)
            view.isMultipleSelection = false
            view.viewTag = optionSelection.workingPattern.rawValue
            view.delegate = self
            view.arrTitles = arrWorkingPatternList
            view.resizeView()
            viewSelectOptions = view
            self.view.addSubview(view)
        }
    }
}

extension AddResourceViewController : ParserDelegate
{
    func parsingFinished(object: AnyObject?, withTag tag: NSInteger) {
        app_delegate.removeloder()
        
        
        if tag == ParsingConstant.getWorkingPatternList.rawValue
        {
            let response = object as! NSDictionary
            arrWorkingPatternList.removeAllObjects()
            let arrModel = response.valueForKey("Model") as! NSArray
            
            
            for dict in arrModel {
                let workingPatternListBO = WorkPatternListBO()
                let FirmId : NSNumber = dict.valueForKey("FirmId") as! NSNumber
                workingPatternListBO.strFirmId = String(FirmId.integerValue)
                let FirmWPId : NSNumber = dict.valueForKey("FirmWPId") as! NSNumber
                workingPatternListBO.strFirmWPId = String(FirmWPId.integerValue)
                let IsBankHoliday : NSNumber = dict.valueForKey("IsBankHoliday") as! NSNumber
                workingPatternListBO.isIsBankHoliday = Bool(IsBankHoliday.integerValue)
                workingPatternListBO.strPatternName = dict.valueForKey("PatternName") as! String
                let CalanderYear : NSNumber = dict.valueForKey("CalanderYear") as! NSNumber
                workingPatternListBO.strCalanderYear = String(CalanderYear.integerValue)
                arrWorkingPatternList.addObject(workingPatternListBO)
            }
            getListResources()
        }
        else  if tag == ParsingConstant.getListResource.rawValue
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
                    let resource = ResourceBO()
                    
                    let firmId = dictModel.objectForKey("FirmId") as? NSNumber
                    resource.strFirmId = (firmId?.stringValue)!
                    
                    let resourceId = dictModel.objectForKey("ResourceId") as? NSNumber
                    resource.strResourceId = (resourceId?.stringValue)!
                    
                    resource.strResourceName = (dictModel.objectForKey("ResourceName") as? String)!
                   
                    let WPId = dictModel.objectForKey("WPId") as? NSNumber
                    resource.strWPId = (WPId?.stringValue)!
                    
                    resource.strCapacity = (dictModel.objectForKey("Capacity") as? String)!
                    resource.strEmail = (dictModel.objectForKey("EMail") as? String)!

                    let skillLevel = dictModel.objectForKey("SkillLevel") as? NSNumber
                    resource.strSkillLevel = (skillLevel?.stringValue)!
                    
                    let priority = dictModel.objectForKey("Priority") as? NSNumber
                    resource.strPriority = (priority?.stringValue)!

                    let resourceType = dictModel.objectForKey("ResourceType") as? NSNumber
                    resource.strResourceType = (resourceType?.stringValue)!

                    if ((dictModel["SkillString"]?.isKindOfClass(NSNull)) == false)
                    {
                        resource.strSkillString = (dictModel.objectForKey("SkillString") as? String)!
                    }
                    
                    arrResourcesList.addObject(resource)
                }
            }
            else
            {
                let dictModel = models as! NSDictionary
                let resource = ResourceBO()
                
                let firmId = dictModel.objectForKey("FirmId") as? NSNumber
                resource.strFirmId = (firmId?.stringValue)!
                
                let resourceId = dictModel.objectForKey("ResourceId") as? NSNumber
                resource.strResourceId = (resourceId?.stringValue)!
                
                resource.strResourceName = (dictModel.objectForKey("ResourceName") as? String)!
                
                let WPId = dictModel.objectForKey("WPId") as? NSNumber
                resource.strWPId = (WPId?.stringValue)!
                
                resource.strCapacity = (dictModel.objectForKey("Capacity") as? String)!
                resource.strEmail = (dictModel.objectForKey("EMail") as? String)!
                
                let skillLevel = dictModel.objectForKey("SkillLevel") as? NSNumber
                resource.strSkillLevel = (skillLevel?.stringValue)!
                
                let priority = dictModel.objectForKey("Priority") as? NSNumber
                resource.strPriority = (priority?.stringValue)!
                
                let resourceType = dictModel.objectForKey("ResourceType") as? NSNumber
                resource.strResourceType = (resourceType?.stringValue)!
                
                if ((dictModel["SkillString"]?.isKindOfClass(NSNull)) == false)
                {
                    resource.strSkillString = (dictModel.objectForKey("SkillString") as? String)!
                }
                
                arrResourcesList.addObject(resource)
                
            }
        }
    }
    func parsingError(error: String?, withTag tag: NSInteger) {
        app_delegate.removeloder()
        self.showAlert(error!, strTitle: "Failed!")
    }
}
extension AddResourceViewController : SelectOptionsCustomView_Delegate
{
    func removeSelectionOptionsPopup() {
        viewSelectOptions.delegate =  nil
        viewSelectOptions.removeFromSuperview()
    }
    
    func selectedOptions(arrSelected: NSMutableArray, withTag tag: Int) {
        viewSelectOptions.delegate =  nil
        viewSelectOptions.removeFromSuperview()
        
        if tag == optionSelection.workingPattern.rawValue
        {
            arrSelectedWorkingPatternList.addObjectsFromArray(arrSelected as [AnyObject])
            var title = ""
            for indexPath in arrSelected
            {
                let dict = arrWorkingPatternList.objectAtIndex(indexPath.row) as! WorkPatternListBO
                if title.characters.count == 0
                {
                    title = dict.strPatternName
                }
                else
                {
                    title = String(format: "%@,%@", title,dict.strPatternName)
                }
            }
            btnWorkingPattern.setTitle(title, forState: UIControlState.Normal)
            btnWorkingPattern.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
    }
    
    func showAlertWithMessage(message: String) {
        showAlert(message, strTitle: "Alert")
    }
}
