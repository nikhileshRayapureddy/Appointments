//
//  ViewController.swift
//  Appointments
//
//  Created by NIKHILESH on 28/07/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class ViewController: BaseViewController,ParserDelegate {

    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPwd: UITextField!
    
    @IBOutlet weak var btnForgotPwd: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.hidden = true

 }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true

    }
    @IBAction func btnForgotPwdClicked(sender: UIButton) {
    }
    @IBAction func btnLoginClicked(sender: UIButton) {
//        self.navigateToHome()
        callLoginService()
    }
    
    @IBAction func btnSignUpClicked(sender: UIButton) {
        let vc : SignUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SignUpViewController") as! SignUpViewController
        self.navigationController!.pushViewController(vc, animated: true)
    }
    func callLoginService()
    {
        app_delegate.showLoader("Loading...")
        let layer = BusinessLayerClass()
        layer.callBack = self
        layer.doUserLoginWithUserName(txtFldEmail.text!, strPassword: txtFldPwd.text!)

    }
    func parsingFinished(object: AnyObject?, withTag tag: NSInteger) {
        app_delegate.removeloder()
        
        let dictResponse = object as! NSDictionary
        let model = dictResponse.objectForKey("Model") as! NSDictionary
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(model.objectForKey("UserId"), forKey: "USERID")
        let firmId = model.objectForKey("FirmId") as? NSNumber
        defaults.setValue((firmId?.stringValue)!, forKey: "FIRMID")
        defaults.synchronize()
        
        self.performSelectorOnMainThread(#selector(self.navigateToHome), withObject: nil, waitUntilDone: true)
        
    }
    func parsingError(error: String?, withTag tag: NSInteger) {
        app_delegate.removeloder()
        self.showAlert(error!, strTitle: "Failed!")
    }
    
    func navigateToHome()
    {
        let vc : HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        self.navigationController!.pushViewController(vc, animated: true)
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

