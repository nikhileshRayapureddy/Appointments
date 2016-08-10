//
//  ViewController.swift
//  Appointments
//
//  Created by NIKHILESH on 28/07/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        let vc : HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        self.navigationController!.pushViewController(vc, animated: true)

    }
    
    @IBAction func btnSignUpClicked(sender: UIButton) {
        let vc : SignUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SignUpViewController") as! SignUpViewController
        self.navigationController!.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

