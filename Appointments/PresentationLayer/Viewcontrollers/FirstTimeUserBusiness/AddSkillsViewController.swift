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
    @IBOutlet weak var btnAddSkill: UIButton!
    @IBOutlet weak var txtVwDescription: SAMTextView!
    var arrSkillsList = NSMutableArray()
    var arrSkills = NSMutableArray()
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
        scrlVwAddSkills.hidden = false
        tblSkills.hidden = true
        getSkills()
    }
    
    func getListSkills()
    {
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getListSkills()

    }
    
    @IBAction func btnAddSkillClicked(sender: UIButton) {
        
        if let view : SelectOptionsCustomView = NSBundle.mainBundle().loadNibNamed("SelectOptionsCustomView", owner: nil, options: nil)[0] as? SelectOptionsCustomView
        {
            view.frame = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height+64)
            view.isMultipleSelection = false
            view.viewTag = optionSelection.skill.rawValue
            view.delegate = self
            view.arrTitles = arrSkills
            view.resizeView()
            viewSelectOptions = view
            self.view.addSubview(view)
        }
        
    }
    func getSkills()
    {
        app_delegate.showLoader("Loading...")
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getSkills()
        
    }
    func btnNextClicked(sender : UIButton)
    {
        let dictParams = NSMutableDictionary()
        dictParams.setObject((btnAddSkill.titleLabel?.text)!, forKey: "SkillName")
        dictParams.setObject(txtVwDescription.text, forKey: "Notes")
        let defualts = NSUserDefaults.standardUserDefaults()
        let firmValue = defualts.valueForKey("FIRMID") as! NSInteger
        dictParams.setValue(firmValue, forKey: "FirmId")
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
    
    @IBAction func btnViewListClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true{
            scrlVwAddSkills.hidden = true
            tblSkills.hidden = false
            tblSkills.reloadData()
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
        btnAddSkill.setTitle(skill.strSkillName, forState: UIControlState.Normal)
        btnAddSkill.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        txtVwDescription.text = skill.strSkillNotes
        
        selectedSkillBO = skill
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
        bindDataFromList(arrSkills.objectAtIndex(indexPath.row) as! SkillsBO)
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
        else if tag == ParsingConstant.getSkills.rawValue
        {
            getListSkills()
            let response = object as! NSDictionary
            let models = response.objectForKey("Model")
            if models?.isKindOfClass(NSArray) == true
            {
                
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
                
                arrSkills.addObject(skillBO)
            }
        }
    }
}

extension AddSkillsViewController : SelectOptionsCustomView_Delegate
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
            var title = ""
            for indexPath in arrSelected
            {
                let skill = arrSkills.objectAtIndex(indexPath.row) as! SkillsBO
                if title.characters.count == 0
                {
                    title = skill.strSkillName
                }
                else
                {
                    title = String(format: "%@,%@", title,skill.strSkillName)
                }
            }
            btnAddSkill.setTitle(title, forState: UIControlState.Normal)
            btnAddSkill.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
    }
    
    func showAlertWithMessage(message: String) {
        showAlert(message, strTitle: "Alert")
    }
}
