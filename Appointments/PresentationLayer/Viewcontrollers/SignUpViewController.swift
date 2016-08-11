//
//  SignUpViewController.swift
//  Appointments
//
//  Created by NIKHILESH on 28/07/16.
//  Copyright © 2016 NIKHILESH. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var btnStep1: UIButton!
    @IBOutlet weak var vwStep1: UIView!
    @IBOutlet weak var vwStep2: UIView!
    @IBOutlet weak var btnNext: UIButton!

    @IBOutlet weak var btnStep2: UIButton!
    
    @IBOutlet weak var txtFldFirstName: UITextField!
    @IBOutlet weak var txtFldLastName: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldConfirmEmail: UITextField!
    @IBOutlet weak var txtFldPwd: UITextField!
    @IBOutlet weak var txtFldConfirmPwd: UITextField!
    
    
    @IBOutlet weak var txtFldHouseNum: UITextField!
    @IBOutlet weak var txtFldStreet: UITextField!
    @IBOutlet weak var txtFldTown: UITextField!
    @IBOutlet weak var txtFldCountry: UITextField!
    @IBOutlet weak var txtFldPincode: UITextField!
    
    @IBOutlet weak var lblTandC: UILabel!
   override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnStep2(sender: UIButton) {
        btnStep1.selected = true
        btnStep2.selected = true
        vwStep1.hidden = true
        vwStep2.hidden = false
        lblTandC.hidden = false
    }
    
    @IBAction func btnStep1Clicked(sender: UIButton) {
        vwStep1.hidden = false
        vwStep2.hidden = true
        lblTandC.hidden = true
        btnStep1.selected = false
        btnStep2.selected = false
        btnNext.selected = false
    }

    @IBAction func btnBackClicked(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnNextClicked(sender: UIButton) {
        if sender.selected == true{
            if self.validateStep2Fields() == true{
                self.showCongratsMessage("You are successfully registered.", strTitle: "Congratulations!")
                print("Sign up clicked")
        }

        }
        else
        {
            if self.validateStep1Fields() == true{
            sender.selected = !sender.selected
            print("next clicked")
            self.btnStep2(btnStep2)
            }
        }
    }
    func validateStep1Fields() -> Bool
    {
        if txtFldFirstName.text?.characters.count == 0
        {
            self.showAlertWithMessage("Please enter First Name.", strTitle: "Alert!")
            return false
        }
        else if txtFldLastName.text?.characters.count == 0
        {
            self.showAlertWithMessage("Please enter Last Name.", strTitle: "Alert!")
            return false
        }
        else if txtFldEmail.text?.characters.count == 0
        {
            self.showAlertWithMessage("Please enter Email.", strTitle: "Alert!")
            return false
        }
        else if validateUserEmail(txtFldEmail.text!) == false
        {
            self.showAlertWithMessage("Please enter valid Email.", strTitle: "Alert!")
            return false
       }
        else if txtFldConfirmEmail.text?.characters.count == 0
        {
            self.showAlertWithMessage("Please Confirme Email.", strTitle: "Alert!")
            return false
        }
        else if txtFldConfirmEmail.text != txtFldEmail.text
        {
            self.showAlertWithMessage("Email and Confirm Email doesn't match.", strTitle: "Alert!")
            return false
        }
        else if txtFldPwd.text?.characters.count == 0
        {
            self.showAlertWithMessage("Please enter Password.", strTitle: "Alert!")
            return false
        }
        else if txtFldConfirmPwd.text?.characters.count == 0
        {
            self.showAlertWithMessage("Please Confirme Password.", strTitle: "Alert!")
            return false
        }
        else if txtFldPwd.text != txtFldConfirmPwd.text
        {
            self.showAlertWithMessage("Password and Confirm Password doesn't match.", strTitle: "Alert!")
            return false
        }

        return true
    }
    func validateStep2Fields() -> Bool
    {
        if txtFldHouseNum.text?.characters.count == 0
        {
            self.showAlertWithMessage("Please enter House No/Name.", strTitle: "Alert!")
           return false
        }
        else if txtFldStreet.text?.characters.count == 0
        {
            self.showAlertWithMessage("Please enter Street.", strTitle: "Alert!")
           return false
        }
        else if txtFldTown.text?.characters.count == 0
        {
            self.showAlertWithMessage("Please enter Town.", strTitle: "Alert!")
           return false
        }
        else if txtFldCountry.text?.characters.count == 0
        {
            self.showAlertWithMessage("Please enter Country.", strTitle: "Alert!")
          return false
        }
        else if txtFldPincode.text?.characters.count == 0
        {
            self.showAlertWithMessage("Please enter Pincode.", strTitle: "Alert!")
          return false
        }
        return true
    }
    
    func showAlertWithMessage(message : String, strTitle : String)
    {
        let alertController = UIAlertController(title: strTitle, message: message, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
    }
    func showCongratsMessage(message : String, strTitle : String)
    {
        let alertController = UIAlertController(title: strTitle, message: message, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
    }
    func validateUserEmail(emailAdd : String) -> Bool
    {
        let emailRegex : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest =  NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(emailAdd)
    }
    

   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
