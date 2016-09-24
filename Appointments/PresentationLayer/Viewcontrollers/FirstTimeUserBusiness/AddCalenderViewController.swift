//
//  AddCalenderViewController.swift
//  Appointments
//
//  Created by Nikhilesh on 10/08/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class AddCalenderViewController: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnViewList: UIButton!
    @IBOutlet weak var scrlVwAddCalender: UIScrollView!
    @IBOutlet weak var constVwDatePickerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var txtFldYear: UITextField!
    @IBOutlet weak var txtFldPatternName: UITextField!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var vwDatePicker: UIView!
    var currenttextFiled : UITextField!
    var MinDate : NSDate!
    @IBOutlet weak var txtFldMonFrom: UITextField!
    @IBOutlet weak var txtFldMonTo: UITextField!
    
    @IBOutlet weak var txtFldTueFrom: UITextField!
    @IBOutlet weak var txtFldTueTo: UITextField!
    
    @IBOutlet weak var txtFldWedFrom: UITextField!
    @IBOutlet weak var txtFldWedTo: UITextField!
    
    @IBOutlet weak var txtFldThurFrom: UITextField!
    @IBOutlet weak var txtFldThurTo: UITextField!
    
    @IBOutlet weak var txtFldFriFrom: UITextField!
    @IBOutlet weak var txtFldFriTo: UITextField!
    
    @IBOutlet weak var txtFldSatFrom: UITextField!
    @IBOutlet weak var txtFldSatTo: UITextField!
    
    @IBOutlet weak var txtFldSunFrom: UITextField!
    @IBOutlet weak var txtFldSunTo: UITextField!
    
    @IBOutlet weak var btnBankHoliday: UIButton!
    
    @IBOutlet weak var btnSave: UIButton!
    var arrWorkingPatternList = [WorkPatternListBO]()
    var arrWorkingPattern = [WorkPatternBO]()
    
    var selectedBO = WorkPatternListBO()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
        self.designNavBar("Add Calender")
        self.designTabBar()
        self.setSelected(3)
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
        scrlVwAddCalender.hidden = false
        tableView.hidden = true
        datePicker.datePickerMode = UIDatePickerMode.Time
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrlVwAddCalender.contentSize = CGSizeMake(scrlVwAddCalender.frame.size.width, 780)
        
    }
    func getAllWorkingPatterns()
    {
        app_delegate.showLoader("")
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.getAllWorkingPatterns()
    }

    func btnNextClicked(sender : UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddSkillsViewController") as! AddSkillsViewController
        self.navigationController?.pushViewController(vc, animated: false)

    }
    func addWorkingPattern()
    {
        app_delegate.showLoader("")
       let dictParams = NSMutableDictionary()
        let defaults = NSUserDefaults.standardUserDefaults()
        let firmValue = defaults.valueForKey("FIRMID") as! NSInteger
        dictParams.setObject(String (firmValue), forKey: "FirmId")
        dictParams.setObject(txtFldPatternName.text!, forKey: "PatternName")
        var isUpdate = false
        if selectedBO.strFirmWPId != ""
        {
            isUpdate = true
            dictParams.setObject(selectedBO.strFirmWPId, forKey: "FirmWPId")
        }
        var strXML = "<Patterns>\n"
        for i in 1...7 {
            let DayId : Int = Int(i)
            let txtFrom : UITextField = scrlVwAddCalender.viewWithTag(10*i) as! UITextField
            let txtTo : UITextField = scrlVwAddCalender.viewWithTag((10*i)+1) as! UITextField
            strXML =  strXML + "<Pattern><Day_id>" + String(DayId) + "</Day_id><From_Time>" + txtFrom.text! + "</From_Time><To_Time>" + txtTo.text! + "</To_Time></Pattern>"
        }
        strXML =  strXML + "</Patterns>"
        dictParams.setObject(strXML, forKey: "PatternsXML")
        let txtYear : UITextField = scrlVwAddCalender.viewWithTag(151) as! UITextField
        dictParams.setObject(txtYear.text!, forKey: "CalanderYear")
        if btnBankHoliday.selected == true
        {
            dictParams.setObject("true", forKey: "IsBankHoliday")
        }
        else
        {
            dictParams.setObject("false", forKey: "IsBankHoliday")
        }
        
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.addOrUpdateWorkPattern(dictParams, isUpdate: isUpdate)
    }
    @IBAction func btnViewListClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true{
            scrlVwAddCalender.hidden = true
            tableView.hidden = false
            self.getAllWorkingPatterns()
        }
        else
        {
            scrlVwAddCalender.hidden = false
            tableView.hidden = true
            for i in 1...7 {
                let txtFrom : UITextField = self.scrlVwAddCalender.viewWithTag(10*i) as! UITextField
                let txtTo : UITextField = self.scrlVwAddCalender.viewWithTag((10*i)+1) as! UITextField
                txtFrom.text = ""
                txtTo.text = ""
            }
            self.txtFldPatternName.text = ""
            self.btnBankHoliday.selected = false
            self.txtFldYear.text = ""
            selectedBO = WorkPatternListBO()
        }
    }
    func designWorkingHourLabelWithDay(day:String,startTime:String,endTime:String,frame:CGRect) -> UILabel
    {
        let lblReturn = UILabel()
        lblReturn.backgroundColor = UIColor.clearColor()
        lblReturn.layer.borderColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 232.0/255.0, alpha: 1.0).CGColor
        lblReturn.layer.borderWidth = 0.5
        lblReturn.font = UIFont(name: "Helvetica", size: 9)
        let strTemp = " " + day + " : " + startTime + " to " + endTime
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center

        let text : NSMutableAttributedString = NSMutableAttributedString(string: strTemp)
        text.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, day.characters.count+2))

        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, day.characters.count+2))
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 183.0/255.0, green: 183.0/255.0, blue: 183.0/255.0, alpha: 1.0), range: NSMakeRange(day.characters.count+2,strTemp.characters.count - day.characters.count-2))
        lblReturn.attributedText = text
        let attributes = [NSFontAttributeName : UIFont.systemFontOfSize(9)]
        let rect = strTemp.boundingRectWithSize(CGSizeMake(frame.size.width, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        var yPos = frame.origin.y
        var xPos = frame.origin.x
        if frame.origin.x+rect.width+5 > frame.size.width
        {
            yPos += 17
            xPos = 0
        }
            lblReturn.frame = CGRectMake(xPos, yPos, rect.width, 12)
        if startTime == "" && endTime == ""
        {
            lblReturn.frame = CGRectMake(xPos, yPos, 0, 0)
        }

        
        return lblReturn
    }

    @IBAction func btnBankHolidayClicked(sender: UIButton) {
        sender.selected = !sender.selected
        
    }
    @IBAction func btnSaveClicked(sender: UIButton) {
        self.view.endEditing(true)
        self.addWorkingPattern()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension AddCalenderViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWorkingPatternList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 120
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : AddCalenderCustomCell = tableView.dequeueReusableCellWithIdentifier("CALENDERCELL") as! AddCalenderCustomCell
        cell.configureCell()
        let BO : WorkPatternListBO = arrWorkingPatternList[indexPath.row]
        cell.lblPatternName.text = BO.strPatternName
        
        var xPos = CGFloat(0)
        var yPos = CGFloat(0)
        for view in cell.vwLblTimeBg.subviews
        {
            view.removeFromSuperview()
        }
        if BO.arrPatterns.count > 0
        {
            for i in 0...(BO.arrPatterns.count-1)
            {
                let workPatternBO = BO.arrPatterns[i]
                var strDay = ""
                if workPatternBO.strDayId == "1"
                {
                    strDay = "MON"
                }
                else if workPatternBO.strDayId == "2"
                {
                    strDay = "TUE"
                }
                else if workPatternBO.strDayId == "3"
                {
                    strDay = "WED"
                }
                else if workPatternBO.strDayId == "4"
                {
                    strDay = "THU"
                }
                else if workPatternBO.strDayId == "5"
                {
                    strDay = "FRI"
                }
                else if workPatternBO.strDayId == "6"
                {
                    strDay = "SAT"
                }
                else if workPatternBO.strDayId == "7"
                {
                    strDay = "SUN"
                }
                if strDay != ""
                {
                let lbl : UILabel = self.designWorkingHourLabelWithDay(strDay, startTime: workPatternBO.strFromTime, endTime: workPatternBO.strToTime,frame: CGRectMake(xPos, yPos, cell.vwLblTimeBg.frame.size.width, 12))
                xPos = lbl.frame.origin.x + lbl.frame.size.width + 5
                yPos = lbl.frame.origin.y
                cell.vwLblTimeBg.addSubview(lbl)
                }
            }
        }
            

        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.btnViewListClicked(self.btnViewList)
        selectedBO = arrWorkingPatternList[indexPath.row]

        if self.selectedBO.arrPatterns.count > 0
        {
            self.bindDataForWorkingPattern()
        }
        else
        {
            for i in 1...7 {
                let txtFrom : UITextField = self.scrlVwAddCalender.viewWithTag(10*i) as! UITextField
                let txtTo : UITextField = self.scrlVwAddCalender.viewWithTag((10*i)+1) as! UITextField
                txtFrom.text = ""
                txtTo.text = ""
            }
            
        }
        self.btnBankHoliday.selected = self.selectedBO.isIsBankHoliday
        self.txtFldPatternName.text = self.selectedBO.strPatternName
        self.txtFldYear.text = self.selectedBO.strCalanderYear

    }
    
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        if currenttextFiled.tag % 10 == 0
        {
            MinDate = datePicker.date
        }
        else
        {
            MinDate = nil
        }
        currenttextFiled.text = strDate
    }
    
    @IBAction func btnDoneClicked(sender: UIButton) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        if currenttextFiled.tag % 10 == 0
        {
            MinDate = datePicker.date
        }
        else
        {
            MinDate = nil
        }
        currenttextFiled.text = strDate
        constVwDatePickerHeight.constant = -250;
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.tag == 151 || textField == txtFldPatternName
        {
            currenttextFiled = textField
            return true
        }
        else
        {
            if currenttextFiled != nil
            {
            currenttextFiled.resignFirstResponder()
            }
            datePicker.minimumDate = MinDate
            constVwDatePickerHeight.constant = 0;
            currenttextFiled = textField
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let strDate = dateFormatter.stringFromDate(datePicker.date)
            if currenttextFiled.tag % 10 == 0
            {
                MinDate = datePicker.date
            }
            else
            {
                MinDate = nil
            }
            currenttextFiled.text = strDate
            return false
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        currenttextFiled.resignFirstResponder()
        return true
    }
}
extension AddCalenderViewController : ParserDelegate
{
    func parsingFinished(object: AnyObject?, withTag tag: NSInteger) {
        app_delegate.removeloder()
        if tag == ParsingConstant.getWorkingPatternList.rawValue
        {
            let response = object as! NSDictionary
            print(response)
            
            arrWorkingPatternList.removeAll()
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
                let arrModel = dict.valueForKey("Patterns") as! NSArray
                for dict in arrModel {
                    let workingPatternBO = WorkPatternBO()
                    let DayId : NSNumber = dict.valueForKey("DayId") as! NSNumber
                    workingPatternBO.strDayId = String(DayId.integerValue)
                    let FirmWPId : NSNumber = dict.valueForKey("FirmWPId") as! NSNumber
                    workingPatternBO.strFirmWPId = String(FirmWPId.integerValue)
                    let WPId : NSNumber = dict.valueForKey("WPId") as! NSNumber
                    workingPatternBO.strWPId = String(WPId.integerValue)
                    workingPatternBO.strFromTime = dict.valueForKey("FromTime") as! String
                    workingPatternBO.strToTime = dict.valueForKey("ToTime") as! String
                    workingPatternListBO.arrPatterns.append(workingPatternBO)
                }

                arrWorkingPatternList.append(workingPatternListBO)
            }
            self.tableView.performSelectorOnMainThread(#selector(UITableView.reloadData), withObject: nil, waitUntilDone: true)
            
        }
        else if tag == ParsingConstant.addWorkingPattern.rawValue
        {
            let defaults = NSUserDefaults.standardUserDefaults()
            let StatusFlag = defaults.valueForKey("StatusFlag") as! NSInteger
            
            if StatusFlag <= 2
            {
                defaults.setValue(3, forKey: "StatusFlag")
            }
            defaults.synchronize()
            selectedBO = WorkPatternListBO()

            dispatch_async(dispatch_get_main_queue()) {
                for i in 1...7 {
                    let txtFrom : UITextField = self.scrlVwAddCalender.viewWithTag(10*i) as! UITextField
                    let txtTo : UITextField = self.scrlVwAddCalender.viewWithTag((10*i)+1) as! UITextField
                    txtFrom.text = ""
                    txtTo.text = ""
                }
                self.txtFldPatternName.text = ""
                self.btnBankHoliday.selected = false
                self.txtFldYear.text = ""
                
                let alert = UIAlertController(title: "Success!", message: "Working Pattern saved Successfully.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:
                    { action in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewControllerWithIdentifier("AddSkillsViewController") as! AddSkillsViewController
                        if self.navigationController!.visibleViewController?.isKindOfClass(AddSkillsViewController) == true
                        {
                            return
                        }
                        self.navigationController?.pushViewController(vc, animated: false)
                        
                        
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }

        }
        
        
    }
    func parsingError(error: String?, withTag tag: NSInteger) {
        app_delegate.removeloder()
        self.showAlert(error!, strTitle: "Failed!")
    }
    func bindDataForWorkingPattern()
    {
        for i in 0...6 {
            var tempBo = WorkPatternBO()
            if i < self.selectedBO.arrPatterns.count
            {
                tempBo = self.selectedBO.arrPatterns[i] as WorkPatternBO
            }
            if Int(tempBo.strDayId) == i+1
            {
                let txtFrom : UITextField = scrlVwAddCalender.viewWithTag(10*(i+1)) as! UITextField
                let txtTo : UITextField = scrlVwAddCalender.viewWithTag((10*(i+1))+1) as! UITextField
                txtFrom.text = tempBo.strFromTime
                txtTo.text = tempBo.strToTime

            }
            else
            {
                let txtFrom : UITextField = scrlVwAddCalender.viewWithTag(10*(i+1)) as! UITextField
                let txtTo : UITextField = scrlVwAddCalender.viewWithTag((10*(i+1))+1) as! UITextField
                txtFrom.text = ""
                txtTo.text = ""
                
            }
        }

    }
}

