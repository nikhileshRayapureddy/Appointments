//
//  HomeViewController.swift
//  Appointments
//
//  Created by Nikhilesh on 10/08/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit
let ScreenWidth : CGFloat =  UIScreen.mainScreen().bounds.size.width
let ScreenHeight = UIScreen.mainScreen().bounds.height

class HomeViewController: BaseViewController {
    @IBOutlet weak var btnRegisterBusiness: UIButton!

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnReports: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.designNavBar("Home")
        let btnLogout : UIButton = UIButton(type: UIButtonType.Custom)
        btnLogout.frame =  CGRectMake(0, 0, 90,44)
        btnLogout.setTitle("Logout", forState: UIControlState.Normal)
        btnLogout.setTitle("Logout", forState: UIControlState.Highlighted)
        btnLogout.setTitle("Logout", forState: UIControlState.Selected)
        btnLogout.addTarget(self, action: #selector(self.btnlogoutClicked(_:)), forControlEvents: .TouchUpInside)
        btnLogout.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        let rightBarButtonItems = UIView()
        rightBarButtonItems.frame = CGRectMake(ScreenWidth - 90, 0, 90, 44)
        rightBarButtonItems.addSubview(btnLogout)
        let bItem = UIBarButtonItem(customView:rightBarButtonItems)
        self.navigationItem.rightBarButtonItem = bItem

        
    }
    func btnlogoutClicked(sender : UIButton)
    {
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
