//
//  CalendarViewController.swift
//  Appointments
//
//  Created by Kiran Kumar on 17/11/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController,CLWeeklyCalendarViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    var calenderView : CLWeeklyCalendarView!
    let CALENDER_VIEW_HEIGHT : CGFloat  = CGFloat(150)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calenderView = CLWeeklyCalendarView(frame:CGRectMake(0, 0, self.view.bounds.size.width, CALENDER_VIEW_HEIGHT))
        calenderView.delegate = self
        calenderView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(calenderView)
        
    }
    func dailyCalendarViewDidSelect(date : NSDate)
    {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func CLCalendarBehaviorAttributes() -> [NSObject : AnyObject]! {
        return [
            CLCalendarWeekStartDay : 2,   //Start from Tuesday every week
            CLCalendarDayTitleTextColor : UIColor.grayColor(),
            CLCalendarSelectedDatePrintColor : UIColor.grayColor(),
            CLCalendarBackgroundImageColor : UIColor.whiteColor(),
        ]
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let startTime = "8:30"
        let endTime = "20:30"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HourCollectionViewCell", forIndexPath: indexPath) as! HourCollectionViewCell
        
        
        let arrStartTime = startTime.componentsSeparatedByString(":")
        let arrEndTime = endTime.componentsSeparatedByString(":")
        
        cell
        if indexPath.row + 1 == Int(arrStartTime[0])
        {
            cell.constVwFillXPos.constant = CGFloat(Int(arrStartTime[1])!)
            cell.constVwFillHeight.constant = CGFloat(60 - Int(arrStartTime[1])!)
        }
        else if indexPath.row + 1 > Int(arrStartTime[0]) && indexPath.row + 1 < Int(arrEndTime[0])
        {
            cell.constVwFillXPos.constant = 0
            cell.constVwFillHeight.constant = CGFloat(60)
        }
        else if indexPath.row + 1 == Int(arrEndTime[0])
        {
            cell.constVwFillXPos.constant = 0
            cell.constVwFillHeight.constant = CGFloat(Int(arrEndTime[1])!)
        }
        else
        {
            cell.constVwFillXPos.constant = 0
            cell.constVwFillHeight.constant = 0
            
        }
        if indexPath.row+1 < 10
        {
            cell.lblHourName.text = String(format:"0%li",indexPath.row+1)
        }
        else
        {
            cell.lblHourName.text = String(format:"%li",indexPath.row+1)
        }
        let myString = cell.lblHourName.text
        let myAttribute = [ NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue ]
        let myAttrString = NSAttributedString(string: myString!, attributes: myAttribute)
        
        // set attributed text on a UILabel
        cell.lblHourName.attributedText = myAttrString
        
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
}