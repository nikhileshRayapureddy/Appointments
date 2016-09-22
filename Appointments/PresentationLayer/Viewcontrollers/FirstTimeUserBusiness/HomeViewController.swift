//
//  HomeViewController.swift
//  Appointments
//
//  Created by Nikhilesh on 10/08/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit
class HomeViewController: BaseViewController {
    @IBOutlet weak var btnRegisterBusiness: UIButton!

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnReports: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        let StatusFlag = defaults.valueForKey("StatusFlag") as! NSInteger
        
        if StatusFlag == 1
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("AddBranchViewController") as! AddBranchViewController
            if self.navigationController!.visibleViewController?.isKindOfClass(AddBranchViewController) == true
            {
                return
            }
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else if StatusFlag == 2
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("AddCalenderViewController") as! AddCalenderViewController
            if self.navigationController!.visibleViewController?.isKindOfClass(AddCalenderViewController) == true
            {
                return
            }
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else if StatusFlag == 3
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("AddSkillsViewController") as! AddSkillsViewController
            if self.navigationController!.visibleViewController?.isKindOfClass(AddSkillsViewController) == true
            {
                return
            }
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else if StatusFlag == 4
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("ServiceOfferedViewController") as! ServiceOfferedViewController
            if self.navigationController!.visibleViewController?.isKindOfClass(ServiceOfferedViewController) == true
            {
                return
            }
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else if StatusFlag == 5 || StatusFlag == 6
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("AddResourceViewController") as! AddResourceViewController
            if self.navigationController!.visibleViewController?.isKindOfClass(AddResourceViewController) == true
            {
                return
            }
            self.navigationController?.pushViewController(vc, animated: false)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.designNavBar("Home")
        let btnLogout : UIButton = UIButton(type: UIButtonType.Custom)
        btnLogout.frame =  CGRectMake(0, 0, 70,44)
        btnLogout.setTitle("Logout", forState: UIControlState.Normal)
        btnLogout.setTitle("Logout", forState: UIControlState.Highlighted)
        btnLogout.setTitle("Logout", forState: UIControlState.Selected)
        btnLogout.addTarget(self, action: #selector(self.btnlogoutClicked(_:)), forControlEvents: .TouchUpInside)
        btnLogout.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        let rightBarButtonItems = UIView()
        rightBarButtonItems.frame = CGRectMake(ScreenWidth - 90, 0, 70, 44)
        rightBarButtonItems.addSubview(btnLogout)
        let bItem = UIBarButtonItem(customView:rightBarButtonItems)
        self.navigationItem.rightBarButtonItem = bItem
        
        
        let btnHome : UIButton = UIButton(type: UIButtonType.Custom)
        btnHome.frame =  CGRectMake(0, 0, 50,44)
        btnHome.setTitle("", forState: UIControlState.Normal)
        btnHome.setTitle("", forState: UIControlState.Highlighted)
        btnHome.setTitle("", forState: UIControlState.Selected)
        btnHome.addTarget(self, action: #selector(self.btnHomeClicked(_:)), forControlEvents: .TouchUpInside)
        btnHome.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        let leftBarButtonItems = UIView()
        leftBarButtonItems.frame = CGRectMake(ScreenWidth - 90, 0, 50, 44)
        leftBarButtonItems.addSubview(btnHome)
        let bLeftItem = UIBarButtonItem(customView:leftBarButtonItems)
        self.navigationItem.leftBarButtonItem = bLeftItem

        
    }
    func btnHomeClicked(sender : UIButton)
    {
//        var isVcPresent = false
//        var VC : UIViewController!
//        
//        for vc in (self.navigationController?.viewControllers)!
//        {
//            if vc.isKindOfClass(HomeViewController)
//            {
//                isVcPresent = true
//                VC = vc
//            }
//        }
//        if isVcPresent == true
//        {
//            self.navigationController?.popToViewController(VC, animated: true)
//        }
//        else
//        {
//            let vc : HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
//            self.navigationController!.pushViewController(vc, animated: true)
//            
//        }
    }

    func btnlogoutClicked(sender : UIButton)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(0, forKey: "FIRMID")
        defaults.synchronize()

        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnRegisterBusinessClicked(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddBusinessViewController") as! AddBusinessViewController
        self.navigationController?.pushViewController(vc, animated: false)

    }
    
    @IBAction func btnReportsClicked(sender: UIButton) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
