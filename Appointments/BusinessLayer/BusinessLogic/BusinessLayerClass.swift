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
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.getLogin.rawValue
        obj._serviceURL = NSString(format: "http://103.231.43.83:120/api/login/AuthenticateUser?email=admin@appdest.com&password=Admin_321") as String
        obj.MethodNamee = "POST";
        obj.serviceName = ""
        obj.params = [:]
        
        
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


