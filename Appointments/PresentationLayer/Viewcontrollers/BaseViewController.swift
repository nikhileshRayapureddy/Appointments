//
//  BaseViewController.swift
//  Appointments
//
//  Created by Nikhilesh on 10/08/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit
let TAG_BOTTOM_BAR:Int = 1800
let TAG_BOTTOM_BAR_LABEL:Int = 2800

class BaseViewController: UIViewController {
    let arrSelImages : NSArray = ["AddBuss_sel","AddBranch_sel","AddCal_sel","AddSkills_sel","ServOffr_sel","AddResource_sel"]
    let arrUnSelImages : NSArray = ["AddBuss_unSel","AddBranch_unSel","AddCal_unSel","AddSkills_unSel","ServOffr_unSel","AddResource_unSel"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func designNavBar(title:String)
    {
        self.navigationController?.navigationBar.hidden = false
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 0, green: 160.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = UIColor.init(colorLiteralRed: 0, green: 160.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIView())
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())

        if title.characters.count > 0
        {
            let btnTitle : UIButton = UIButton(type: UIButtonType.Custom)
            
            btnTitle.frame =  CGRectMake(0, 0, 300,24)
            btnTitle.setTitle(title, forState: UIControlState.Normal)
            btnTitle.setTitle(title, forState: UIControlState.Highlighted)
            btnTitle.setTitle(title, forState: UIControlState.Selected)
            btnTitle.titleLabel?.textAlignment = NSTextAlignment.Center
            btnTitle.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            btnTitle.backgroundColor = UIColor.whiteColor()
            self.navigationItem.titleView = btnTitle
        }
    }
    func designTabBar()
    {
        var vwBase = self.view.viewWithTag(1875)
        
        if vwBase==nil
        {
            
            if self.navigationController?.navigationBar.hidden == true
            {
                vwBase = UIView(frame:CGRectMake(0, 0, ScreenWidth, 55))
            }
            else
            {
                vwBase = UIView(frame:CGRectMake(0, 0, ScreenWidth, 55))
            }
            vwBase!.backgroundColor = UIColor(red: 46.0/255.0, green: 56.0/255.0, blue: 66.0/255.0, alpha: 1.0)
            vwBase!.tag = 1875
            self.view.addSubview(vwBase!)
            
            let scrlTab = UIScrollView (frame:CGRectMake(0, 0, vwBase!.frame.size.width, vwBase!.frame.size.height))
            scrlTab.backgroundColor = UIColor.clearColor()
            scrlTab.scrollEnabled = true
            vwBase!.addSubview(scrlTab)
            
            var x : CGFloat = 0.0
            let width : CGFloat = (self.view.frame.size.width  ) / CGFloat(arrSelImages.count)
            for  i in 0..<arrSelImages.count
            {
                let btnTab = UIButton(type:UIButtonType.Custom)
                btnTab.frame = CGRectMake(x, 0,width, vwBase!.frame.size.height)
                btnTab.addTarget(self, action: #selector(BaseViewController.btnTabClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                btnTab.backgroundColor = UIColor.clearColor()
                btnTab.setImage(UIImage(named: arrUnSelImages[i] as! String), forState: UIControlState.Normal)
                btnTab.setImage(UIImage(named: arrSelImages[i] as! String), forState: UIControlState.Selected)
                btnTab.tag = TAG_BOTTOM_BAR+i;
                scrlTab.addSubview(btnTab)
                x += width
            }
            
            let imgSel = UIImageView(frame: CGRectMake(0, 53, width, 2))
            imgSel.backgroundColor = UIColor .whiteColor()
            imgSel.tag = 1876
            scrlTab.addSubview(imgSel)
            
        }
    }
    func setTabButtonSelected(indx : Int)
    {
        let vwBase = self.view.viewWithTag(1875)! as UIView
        
        for  i in 0..<arrSelImages.count
        {
            let btn : UIButton = vwBase.viewWithTag(TAG_BOTTOM_BAR+i) as! UIButton
            btn.backgroundColor = UIColor.clearColor()
            btn.selected = false
            
        }
        let btn : UIButton = vwBase.viewWithTag ( TAG_BOTTOM_BAR + indx - 1) as! UIButton
        btn.backgroundColor =  UIColor.whiteColor()
        btn.selected = true

        
    }
    func btnTabClicked (sender:UIButton)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        let StatusFlag = defaults.valueForKey("StatusFlag") as! NSInteger
        
        if sender.tag - TAG_BOTTOM_BAR <= StatusFlag
        {
            
            let vwBase = self.view.viewWithTag(1875)! as UIView
            
            for  i in 0..<arrSelImages.count
            {
                let btn : UIButton = vwBase.viewWithTag(TAG_BOTTOM_BAR+i) as! UIButton
                btn.selected = false
            }
            sender.selected = true;
            let imgSel = self.view.viewWithTag(1876)! as! UIImageView
            imgSel.frame = CGRectMake(sender.frame.origin.x, 53, sender.frame.size.width, 2)
        }
        
        if sender.tag == TAG_BOTTOM_BAR
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("AddBusinessViewController") as! AddBusinessViewController
            if self.navigationController!.visibleViewController?.isKindOfClass(AddBusinessViewController) == true
            {
                return
            }
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else if sender.tag == TAG_BOTTOM_BAR + 1
        {
            if StatusFlag >= 1
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("AddBranchViewController") as! AddBranchViewController
                if self.navigationController!.visibleViewController?.isKindOfClass(AddBranchViewController) == true
                {
                    return
                }
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        else if sender.tag == TAG_BOTTOM_BAR + 2
        {
            if StatusFlag >= 2
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("AddCalenderViewController") as! AddCalenderViewController
                if self.navigationController!.visibleViewController?.isKindOfClass(AddCalenderViewController) == true
                {
                    return
                }
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        else if sender.tag == TAG_BOTTOM_BAR + 3
        {
            if StatusFlag >= 3
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("AddSkillsViewController") as! AddSkillsViewController
                if self.navigationController!.visibleViewController?.isKindOfClass(AddSkillsViewController) == true
                {
                    return
                }
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        else if sender.tag == TAG_BOTTOM_BAR + 4
        {
            if StatusFlag >= 4
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("ServiceOfferedViewController") as! ServiceOfferedViewController
                if self.navigationController!.visibleViewController?.isKindOfClass(ServiceOfferedViewController) == true
                {
                    return
                }
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        else if sender.tag == TAG_BOTTOM_BAR + 5
        {
            if StatusFlag >= 5
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("AddResourceViewController") as! AddResourceViewController
                if self.navigationController!.visibleViewController?.isKindOfClass(AddResourceViewController) == true
                {
                    return
                }
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        
    }
    func setSelected(Vc : Int)
    {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let StatusFlag = defaults.valueForKey("StatusFlag") as! NSInteger
        
        if Vc <= StatusFlag+1
        {
            let vwBase = self.view.viewWithTag(1875)
            if vwBase != nil{
                
                let sender = vwBase!.viewWithTag(TAG_BOTTOM_BAR + Vc - 1) as! UIButton
                let vwBase = self.view.viewWithTag(1875)! as UIView
                
                for  i in 0..<arrSelImages.count
                {
                    let btn : UIButton = vwBase.viewWithTag(TAG_BOTTOM_BAR+i) as! UIButton
                    btn.selected = false
                }
                sender.selected = true;
                let imgSel = self.view.viewWithTag(1876)! as! UIImageView
                imgSel.frame = CGRectMake(sender.frame.origin.x, 53, sender.frame.size.width, 2)
                
                
            }
        }
    }
    
    //MARK:- Show Alert
    func  showAlert (message :String, strTitle : String)
    {
        if NSThread.currentThread() != NSThread.mainThread()
        {
            dispatch_async(dispatch_get_main_queue(),{
                self.showAlert(message, strTitle: strTitle)
            })
        }
        else
        {
            let alert = UIAlertController(title: strTitle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }


}
