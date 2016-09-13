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
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var vwDatePicker: UIView!
    var currenttextFiled : UITextField!
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
        scrlVwAddCalender.hidden = false
        tableView.hidden = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrlVwAddCalender.contentSize = CGSizeMake(scrlVwAddCalender.frame.size.width, 720)
        
    }

    func btnNextClicked(sender : UIButton)
    {
        
    }
    
    @IBAction func btnViewListClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true{
            scrlVwAddCalender.hidden = true
            tableView.hidden = false
        }
        else
        {
            scrlVwAddCalender.hidden = false
            tableView.hidden = true
        }
    }
    func designWorkingHourLabelWithDay(day:String,startTime:String,endTime:String,fltWidth:CGFloat) -> UILabel
    {
        let lblReturn = UILabel()
        lblReturn.backgroundColor = UIColor.clearColor()
        lblReturn.layer.borderColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 232.0/255.0, alpha: 1.0).CGColor
        lblReturn.layer.borderWidth = 0.5
        lblReturn.font = UIFont(name: "Helvetica", size: 9)
        let strTemp = " " + day + ":" + startTime + " to " + endTime
        let text : NSMutableAttributedString = NSMutableAttributedString(string: strTemp)
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, day.characters.count+2))
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 183.0/255.0, green: 183.0/255.0, blue: 183.0/255.0, alpha: 1.0), range: NSMakeRange(day.characters.count+2,strTemp.characters.count - day.characters.count-2))
        lblReturn.attributedText = text
        let attributes = [NSFontAttributeName : UIFont.systemFontOfSize(9)]
        let rect = strTemp.boundingRectWithSize(CGSizeMake(fltWidth, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        lblReturn.frame = CGRectMake(0, 0, rect.width-8, ceil(rect.height))

        
        return lblReturn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension AddCalenderViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : AddCalenderCustomCell = tableView.dequeueReusableCellWithIdentifier("CALENDERCELL") as! AddCalenderCustomCell
        cell.configureCell()
        cell.vwLblTimeBg.addSubview(self.designWorkingHourLabelWithDay("MON", startTime: "10:00", endTime: "05:00",fltWidth:cell.vwLblTimeBg.frame.size.width))
        return cell
    }
    
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        currenttextFiled.text = strDate
    }
    
    @IBAction func btnDoneClicked(sender: UIButton) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        currenttextFiled.text = strDate
        constVwDatePickerHeight.constant = -250;
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        currenttextFiled = textField
        if textField.tag == 150
        {
            return true
        }
        else
        {
            constVwDatePickerHeight.constant = 0;
            return false
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        currenttextFiled.resignFirstResponder()
        return true
    }
}

