//
//  AddSkillsViewController.swift
//  Appointments
//
//  Created by Nikhilesh on 10/08/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class AddSkillsViewController: BaseViewController {
    @IBOutlet weak var btnViewList: UIButton!
    @IBOutlet weak var tblSkills: UITableView!
    @IBOutlet weak var scrlVwAddSkills: UIScrollView!
    var viewSelectOptions = SelectOptionsCustomView()
    var selectedSkillBO = SkillsBO()
    @IBOutlet weak var txtVwDescription: SAMTextView!
    @IBOutlet weak var txtSkillName: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    var arrSkillsList = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        txtVwDescription.placeholder = "Description"
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
        self.designNavBar("Add Skills")
        self.designTabBar()
        self.setSelected(4)
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
        scrlVwAddSkills.hidden = false
        tblSkills.hidden = true
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

    func getListSkills()
    {
        app_delegate.showLoader("Loading...")
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getListSkills()

    }

    func btnNextClicked(sender : UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ServiceOfferedViewController") as! ServiceOfferedViewController
        if self.navigationController!.visibleViewController?.isKindOfClass(ServiceOfferedViewController) == true
        {
            return
        }
        self.navigationController?.pushViewController(vc, animated: false)

    }
    
    @IBAction func btnViewListClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true{
            scrlVwAddSkills.hidden = true
            tblSkills.hidden = false
            getListSkills()
        }
        else
        {
            scrlVwAddSkills.hidden = false
            tblSkills.hidden = true
            self.bindDataFromList(SkillsBO())
        }
    }

    func bindDataFromList(skill : SkillsBO)
    {
        txtSkillName.text = skill.strSkillName
        txtVwDescription.text = skill.strSkillNotes
        
        selectedSkillBO = skill
    }

    @IBAction func btnSaveClicked(sender: UIButton) {
        self.view.endEditing(true)
        let dictParams = NSMutableDictionary()
        dictParams.setObject(txtSkillName.text!, forKey: "SkillName")
        dictParams.setObject(txtVwDescription.text, forKey: "Notes")
        let defualts = NSUserDefaults.standardUserDefaults()
        let firmValue = defualts.valueForKey("FIRMID") as! NSInteger
        dictParams.setValue(String(firmValue), forKey: "FirmId")
        let layer = BusinessLayerClass()
        layer.callBack = self
        
        if selectedSkillBO.strSkillId.characters.count == 0
        {
            layer.addSkill(dictParams)
        }
        else
        {
            dictParams.setObject(selectedSkillBO.strSkillId, forKey: "SkillId")
            layer.updateSkill(dictParams)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension AddSkillsViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSkillsList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : SkillListCustomCell = tableView.dequeueReusableCellWithIdentifier("SKILLLIST") as! SkillListCustomCell
        cell.configureCell(indexPath, andSkillsArray: arrSkillsList)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        btnViewListClicked(btnViewList)
        bindDataFromList(arrSkillsList.objectAtIndex(indexPath.row) as! SkillsBO)
    }
    
}

extension AddSkillsViewController : UITextFieldDelegate
{
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddSkillsViewController : ParserDelegate
{
    func parsingError(error: String?, withTag tag: NSInteger) {
        app_delegate.removeloder()
        self.showAlert(error!, strTitle: "Failed!")
        
    }
    
    func parsingFinished(object: AnyObject?, withTag tag: NSInteger) {
        app_delegate.removeloder()

        if tag == ParsingConstant.getListSkills.rawValue
        {
            arrSkillsList.removeAllObjects()
            let response = object as! NSDictionary
            let models = response.objectForKey("Model")
            if ((models?.isKindOfClass(NSArray)) == true)
            {
                let modelsArray = models as! NSArray
                for dict in modelsArray
                {
                    let dictModel = dict as! NSDictionary
                    let skillBO = SkillsBO()
                    if ((dictModel["FirmId"]?.isKindOfClass(NSNull)) == false)
                    {
                        let firmId = dictModel.objectForKey("FirmId") as? NSNumber
                        skillBO.strFirmId = (firmId?.stringValue)!
                    }
                    
                    if ((dictModel["SkillId"]?.isKindOfClass(NSNull)) == false)
                    {
                        let skillId = dictModel.objectForKey("SkillId") as? NSNumber
                        skillBO.strSkillId = (skillId?.stringValue)!
                    }
                    
                    if ((dictModel["SkillName"]?.isKindOfClass(NSNull)) == false)
                    {
                        skillBO.strSkillName = (dictModel.objectForKey("SkillName") as? String)!
                    }
                    
                    if ((dictModel["Notes"]?.isKindOfClass(NSNull)) == false)
                    {
                        skillBO.strSkillNotes = (dictModel.objectForKey("Notes") as? String)!
                    }
                    arrSkillsList.addObject(skillBO)
                }
            }
            else
            {
                let dictModel = models as! NSDictionary
                let skillBO = SkillsBO()
                
                if ((dictModel["FirmId"]?.isKindOfClass(NSNull)) == false)
                {
                    let firmId = dictModel.objectForKey("FirmId") as? NSNumber
                    skillBO.strFirmId = (firmId?.stringValue)!
                }
                
                if ((dictModel["SkillId"]?.isKindOfClass(NSNull)) == false)
                {
                    let skillId = dictModel.objectForKey("SkillId") as? NSNumber
                    skillBO.strSkillId = (skillId?.stringValue)!
                }
                
                if ((dictModel["SkillName"]?.isKindOfClass(NSNull)) == false)
                {
                    skillBO.strSkillName = (dictModel.objectForKey("SkillName") as? String)!
                }
                
                if ((dictModel["Notes"]?.isKindOfClass(NSNull)) == false)
                {
                    skillBO.strSkillNotes = (dictModel.objectForKey("Notes") as? String)!
                }
                
                arrSkillsList.addObject(skillBO)
            }
            tblSkills.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), { 
                self.txtSkillName.text = ""
                self.txtVwDescription.text = ""
                let defaults = NSUserDefaults.standardUserDefaults()
                let StatusFlag = defaults.valueForKey("StatusFlag") as! NSInteger
                
                if StatusFlag <= 3
                {
                    defaults.setValue(4, forKey: "StatusFlag")
                }
                defaults.synchronize()
                self.selectedSkillBO = SkillsBO()
                
                    let alert = UIAlertController(title: "Success!", message: "Skill saved Successfully.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:
                        { action in
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewControllerWithIdentifier("ServiceOfferedViewController") as! ServiceOfferedViewController
                            if self.navigationController!.visibleViewController?.isKindOfClass(ServiceOfferedViewController) == true
                            {
                                return
                            }
                            self.navigationController?.pushViewController(vc, animated: false)
                            
                            
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)

            })
        }
    }
}