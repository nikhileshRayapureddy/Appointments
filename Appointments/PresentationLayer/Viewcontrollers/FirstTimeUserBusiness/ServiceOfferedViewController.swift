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
    @IBOutlet weak var btnSelectSkill: UIButton!
    @IBOutlet weak var txtServiceType: UITextField!
    @IBOutlet weak var txtServiceDescription: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtDuration: UITextField!
    
    var arrSkillsList = NSMutableArray()
    var arrServicesList = NSMutableArray()
    var viewSelectOptions = SelectOptionsCustomView()
    var arrSelectedSkills = NSMutableArray()
    var selectedServiceBO = ServiceBO()
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
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

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

    func getListSkills()
    {
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getListSkills()
        
    }
    

    @IBAction func btnViewListClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true{
            scrlVwSevicesOffered.hidden = true
            tableView.hidden = false
            self.getListOfServices()
        }
        else
        {
            scrlVwSevicesOffered.hidden = false
            tableView.hidden = true
            bindDataFromList(ServiceBO())
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
    func bindDataFromList(service : ServiceBO)
    {
        txtServiceType.text = service.strServiceName
        txtServiceDescription.text = service.strDescription
        btnSelectSkill.setTitle(service.strSkillString, forState: UIControlState.Normal)
        btnSelectSkill.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        if service.strFirmId.characters.count == 0
        {
            txtPrice.text = ""
            txtDuration.text = ""
            btnTwoMenJob.selected = false
        }
        else
        {
            txtPrice.text = String (format: "%lf", service.Price)
            txtDuration.text = String (format: "%lf", service.Duration)
            btnTwoMenJob.selected = service.isTwoManJob
        }
        selectedServiceBO = service
    }
    @IBAction func btnSaveClicked(sender: UIButton) {
        
        let dictParams = NSMutableDictionary()
        let defualts = NSUserDefaults.standardUserDefaults()
        dictParams.setObject(txtServiceType.text!, forKey: "ServiceName")
        dictParams.setObject(txtServiceDescription.text!, forKey: "Description")
        dictParams.setObject(txtPrice.text!, forKey: "Price")
        dictParams.setObject(txtDuration.text!, forKey: "Duration")
        let firmValue = defualts.valueForKey("FIRMID") as! NSInteger
        
        dictParams.setObject(String (firmValue), forKey: "FirmId")
        if btnTwoMenJob.selected == true
        {
            dictParams.setObject("true", forKey: "TwoManJob")
        }
        else
        {
            dictParams.setObject("false", forKey: "TwoManJob")
        }
        
        var skillString = ""
        for indexPath in arrSelectedSkills
        {
            let dict = arrSkillsList.objectAtIndex(indexPath.row) as! SkillsBO
            if skillString.characters.count == 0
            {
                skillString = dict.strSkillId
            }
            else
            {
                skillString = String(format: "%@,%@", skillString,dict.strSkillId)
            }
        }
        dictParams.setObject(skillString, forKey: "SkillString")
        let layer = BusinessLayerClass()
        layer.callBack = self
        if selectedServiceBO.strFirmId.characters.count == 0
        {
            layer.addService(dictParams)
        }
        else
        {
            layer.updateService(dictParams)
        }
        
    }
}


extension ServiceOfferedViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServicesList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : ServicesOfferedCustomCell = tableView.dequeueReusableCellWithIdentifier("SERVICECELL") as! ServicesOfferedCustomCell
        cell.configureCell(indexPath, anddata: arrServicesList)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        btnViewListClicked(btnViewList)
        bindDataFromList(arrServicesList.objectAtIndex(indexPath.row) as! ServiceBO)
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
        if let view : SelectOptionsCustomView = NSBundle.mainBundle().loadNibNamed("SelectOptionsCustomView", owner: nil, options: nil)[0] as? SelectOptionsCustomView
        {
            view.frame = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height+64)
            view.isMultipleSelection = false
            view.viewTag = optionSelection.skill.rawValue
            view.delegate = self
            view.arrTitles = arrSkillsList
            view.resizeView()
            viewSelectOptions = view
            self.view.addSubview(view)
        }
    }
}

extension ServiceOfferedViewController : ParserDelegate
{
    func parsingFinished(object: AnyObject?, withTag tag: NSInteger) {
        if tag == ParsingConstant.getListServicesOffered.rawValue
        {
            app_delegate.removeloder()
            arrServicesList.removeAllObjects()
            let response = object as! NSDictionary
            let models = response.objectForKey("Model")
            if ((models?.isKindOfClass(NSArray)) == true)
            {
                let modelsArray = models as! NSArray
                for dict in modelsArray
                {
                    let dictModel = dict as! NSDictionary
                    let service = ServiceBO()
                    let firmId = dictModel.objectForKey("FirmId") as? NSNumber
                    service.strFirmId = (firmId?.stringValue)!
                    let serviceId = dictModel.objectForKey("ServiceId") as? NSNumber
                    service.strServiceId = (serviceId?.stringValue)!
                    service.strServiceName = (dictModel.objectForKey("ServiceName") as? String)!
                    service.strDescription = (dictModel.objectForKey("Description") as? String)!
                    service.Price = (dictModel.objectForKey("Price") as? Double)!
                    service.Duration = (dictModel.objectForKey("Duration") as? Int)!
                    service.isTwoManJob = (dictModel.objectForKey("TwoManJob") as? Bool)!
                    if ((dictModel["SkillString"]?.isKindOfClass(NSNull)) == false)
                    {
                        service.strSkillString = (dictModel.objectForKey("SkillString") as? String)!
                    }
                    arrServicesList.addObject(service)
                }
                
            }
            else
            {
                let dictModel = models as! NSDictionary
                let service = ServiceBO()
                let firmId = dictModel.objectForKey("FirmId") as? NSNumber
                service.strFirmId = (firmId?.stringValue)!
                let serviceId = dictModel.objectForKey("ServiceId") as? NSNumber
                service.strServiceId = (serviceId?.stringValue)!
                service.strServiceName = (dictModel.objectForKey("ServiceName") as? String)!
                service.strDescription = (dictModel.objectForKey("Description") as? String)!
                service.Price = (dictModel.objectForKey("Price") as? Double)!
                service.Duration = (dictModel.objectForKey("Duration") as? Int)!
                service.isTwoManJob = (dictModel.objectForKey("TwoManJob") as? Bool)!
                if ((dictModel["SkillString"]?.isKindOfClass(NSNull)) == false)
                {
                    service.strSkillString = (dictModel.objectForKey("SkillString") as? String)!
                }
                arrServicesList.addObject(service)

            }
            tableView.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
            self.getListSkills()
        }
        else if tag == ParsingConstant.getListSkills.rawValue
        {
            let response = object as! NSDictionary
            let models = response.objectForKey("Model")
            if ((models?.isKindOfClass(NSArray)) == true)
            {
                let modelsArray = models as! NSArray
                for dict in modelsArray
                {
                    let dictModel = dict as! NSDictionary
                    let skillBO = SkillsBO()
                    
                    let firmId = dictModel.objectForKey("FirmId") as? NSNumber
                    skillBO.strFirmId = (firmId?.stringValue)!
                    let skillId = dictModel.objectForKey("SkillId") as? NSNumber
                    skillBO.strSkillId = (skillId?.stringValue)!
                    
                    skillBO.strSkillName = (dictModel.objectForKey("SkillName") as? String)!
                    skillBO.strSkillNotes = (dictModel.objectForKey("Notes") as? String)!
                    arrSkillsList.addObject(skillBO)
                }
            }
            else
            {
                let dictModel = models as! NSDictionary
                let skillBO = SkillsBO()
                
                let firmId = dictModel.objectForKey("FirmId") as? NSNumber
                skillBO.strFirmId = (firmId?.stringValue)!
                let skillId = dictModel.objectForKey("SkillId") as? NSNumber
                skillBO.strSkillId = (skillId?.stringValue)!
                
                skillBO.strSkillName = (dictModel.objectForKey("SkillName") as? String)!
                skillBO.strSkillNotes = (dictModel.objectForKey("Notes") as? String)!
                
                arrSkillsList.addObject(skillBO)
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), { 
                self.bindDataFromList(ServiceBO())
            })
        }
    }
    
    func parsingError(error: String?, withTag tag: NSInteger) {
        app_delegate.removeloder()
        self.showAlert(error!, strTitle: "Failed!")
        
    }
}

extension ServiceOfferedViewController : SelectOptionsCustomView_Delegate
{
    func removeSelectionOptionsPopup() {
        viewSelectOptions.delegate =  nil
        viewSelectOptions.removeFromSuperview()
    }
    
    func selectedOptions(arrSelected: NSMutableArray, withTag tag: Int) {
        viewSelectOptions.delegate =  nil
        viewSelectOptions.removeFromSuperview()
        
        if tag == optionSelection.skill.rawValue
        {
            arrSelectedSkills.addObjectsFromArray(arrSelected as [AnyObject])
            var title = ""
            for indexPath in arrSelected
            {
                let dict = arrSkillsList.objectAtIndex(indexPath.row) as! SkillsBO
                if title.characters.count == 0
                {
                    title = dict.strSkillName
                }
                else
                {
                    title = String(format: "%@,%@", title,dict.strSkillName)
                }
            }
            btnSelectSkill.setTitle(title, forState: UIControlState.Normal)
            btnSelectSkill.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
    }
    
    func showAlertWithMessage(message: String) {
        showAlert(message, strTitle: "Alert")
    }
}
