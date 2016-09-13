//
//  BusinessLayerClass.swift
//  BestPrice
//
//  Created by Mery Rani on 1/9/16.
//  Copyright © 2016 martjack. All rights reserved.
//

import Foundation
import UIKit
let app_delegate =  UIApplication.sharedApplication().delegate as! AppDelegate
let ScreenWidth : CGFloat =  UIScreen.mainScreen().bounds.size.width
let ScreenHeight = UIScreen.mainScreen().bounds.height

let NO_INTERNET = "No Internet Access. Check your network and try again."
let SERVER_ERROR = "Server not responding.\nPlease try after some time."
let NoInternet : NSString = "There seems to be some data connectivity issue with your network. Please check connection and try again."
class BusinessLayerClass: BaseBL {
func doUserLoginWithUserName(strUsername : String, strPassword : String){
    
    let dictData = NSMutableDictionary()
    dictData.setValue(strUsername, forKey: "EMail")
    dictData.setValue(strPassword, forKey: "Password")
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.getLogin.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/login/AuthenticateUserPost") as String
        obj.MethodNamee = "POST";
        obj.serviceName = ""
        obj.params = dictData
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
    
    func doSignUp(parameters : NSMutableDictionary){
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.getSignUp.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/Login") as String
        obj.MethodNamee = "POST";
        obj.serviceName = "CreateUser"
        obj.params = parameters
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
    
    func getBusinessTypes(){
        
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.getBusinessTypes.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/masterdata/BusinessType") as String
        obj.MethodNamee = "GET";
        obj.serviceName = ""
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }

    func getBusinessBookingTypes(){
        
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.getBusinessBookingTypes.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/masterdata/BookingType") as String
        obj.MethodNamee = "GET";
        obj.serviceName = ""
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
    
    func addBusinessDetails(dictParams : NSMutableDictionary)
    {
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.addBusiness.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/business/AddBusiness") as String
        obj.MethodNamee = "POST";
        obj.serviceName = ""
        obj.params = dictParams
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
    
    func addResource(dictParams : NSMutableDictionary)
    {
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.addBusiness.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/business/AddResource") as String
        obj.MethodNamee = "POST";
        obj.serviceName = ""
        obj.params = dictParams
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
    
    func getListBranches()
    {
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.addBusiness.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/business/ListBranches?firmId=4") as String
        obj.MethodNamee = "GET";
        obj.serviceName = ""
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
    
    func getListResources()
    {
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.addBusiness.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/business/ListResource?firmId=4") as String
        obj.MethodNamee = "GET";
        obj.serviceName = ""
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
    
    func getListSkills()
    {
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.addBusiness.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/business/ListSkill?firmId=1012") as String
        obj.MethodNamee = "GET";
        obj.serviceName = ""
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
    
    func getListServicesOffered()
    {
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.addBusiness.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/business/ListServiceOffered?firmId=1012") as String
        obj.MethodNamee = "GET";
        obj.serviceName = ""
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
    
    func getBusiness()
    {
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.getBusiness.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/business/GetBusiness?firmId=4") as String
        obj.MethodNamee = "GET";
        obj.serviceName = ""
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    if ((obj.parsedDataDict["Message"]?.isKindOfClass(NSNull)) == false)
                    {
                        self.callBack?.parsingError(x as? String, withTag: obj.tag)
                    }
                    else
                    {
                        self.callBack.parsingError("", withTag: obj.tag)
                    }
                    
                }
            }
        }
    }
    
    func getResourcce()
    {
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.addBusiness.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/business/GetResource?resourceId=8") as String
        obj.MethodNamee = "GET";
        obj.serviceName = ""
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
    
    func getServicesOffered()
    {
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.addBusiness.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/business/GetServiceOffered?serviceId=14") as String
        obj.MethodNamee = "GET";
        obj.serviceName = ""
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
    
    func getSkills()
    {
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.addBusiness.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/business/GetSkill?skillId=2") as String
        obj.MethodNamee = "GET";
        obj.serviceName = ""
        
        
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                self.callBack.parsingError(SERVER_ERROR, withTag: obj.tag)
            }
                
            else{
                if obj.parsedDataDict.valueForKey("Success")?.integerValue == 0
                {
                    self.callBack.parsingFinished(obj.parsedDataDict, withTag:obj.tag)
                }
                else if obj.parsedDataDict.valueForKey("Success")?.integerValue == 2
                {
                    self.callBack.parsingError(obj.parsedDataDict.valueForKey("Message") as? String, withTag:obj.tag)
                }
                else
                {
                    let x = (obj.parsedDataDict.valueForKey("Message") != nil) ? obj.parsedDataDict.valueForKey("Message")  : SERVER_ERROR
                    self.callBack?.parsingError(x as? String, withTag: obj.tag)
                }
            }
        }
    }
}