//
//  SHttpRequest.swift
//  HumaraShop
//
//  Created by  on 05/11/15.
//  Copyright © 2015 Mery. All rights reserved.
//

import Foundation

@objc protocol HHandlerDelegate
{
    optional func completedWithDictionary (dictTemp : NSDictionary)
    optional func errorOccuredWithError(strError:NSString, strTag:NSString)
}
class HttpRequest
{
    let contentType = "application/x-www-form-urlencoded"
    let methodName = "POST"
    let GETMethod = "GET"
    
    var serviceName: String = ""
    var _serviceURL: String = ""
    var MethodNamee: String = ""
    var ServiceBody: String = ""
    
    var tag: NSInteger
    
    var params: NSDictionary
    var headerDict :NSDictionary
    var parsedDataDict :NSDictionary
    
    
    
    
    init()
    {
        tag = 0
        params = Dictionary<String, String>()
        headerDict = Dictionary<String, String>()
        
        parsedDataDict = Dictionary<String, String>()
        
    }
    
    func ServiceName(serviceURL : String, params:NSDictionary)
    {
        var serviceName: String {
            get {
                return self.serviceName
            }
            set {
                self.serviceName = serviceURL
            }
        }
        var params: NSDictionary {
            get {
                return self.params
            }
            set {
                self.params = params
            }
        }
        
    }
    
    func doGetSOAPResponse ( completion: (result: Bool) -> Void)
    {
        let requestBody:NSData = self.doPrepareSOAPEnvelope().dataUsingEncoding(NSUTF8StringEncoding)!
        var strUrl : NSString = _serviceURL
        if serviceName.characters.count > 0
        {
            strUrl = NSString(format: "%@/%@", strUrl,serviceName)
        }
        var webStringURL : NSString
        
        let request : NSMutableURLRequest = NSMutableURLRequest()
        
        request.HTTPMethod = MethodNamee
        
        webStringURL =    strUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("url = "+(webStringURL as String))

        request.HTTPBody = requestBody
        request.setValue("application/json" as String, forHTTPHeaderField: "Accept")
        let url : NSURL = NSURL(string: webStringURL as String)!
        request.URL = url
     
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error"+(error?.description)!)
                completion (result: false)
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
           
            if self.convertStringToDictionary(dataString as! String) != nil
            {
                self.parsedDataDict = self.convertStringToDictionary(dataString as! String)!
            }
            else
            {
                self.parsedDataDict = [:]
            }
            completion (result: true)
            
            print(dataString)
            
        }
        
        task.resume()
        
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    func doPrepareSOAPEnvelope() ->NSMutableString
    {
        let soapEnvelope :NSMutableString? = NSMutableString()
        let keys : Array = self.params.allKeys
        let allKey : Int = self.params.count
        if allKey > 0
        {
            
            soapEnvelope?.appendFormat("%@=%@", keys.first as! String , self.params.objectForKey(keys.first! )as! String)
            
        }
        if self.params.count > 0
        {
        for i in 0...self.params.count-1 {
            
            let object : AnyObject = self.params.objectForKey(keys[i])!;
            
            if object .isKindOfClass(NSString)
            {
                soapEnvelope?.appendFormat("&%@=%@", (keys[i]) as! String , self.params.objectForKey((keys[i]) )as! String)
            }
            else if object .isKindOfClass(NSMutableArray)
            {
                do {
                    let jsonData2 : NSData = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.PrettyPrinted)
                    let datastring = NSString(data: jsonData2, encoding: UInt())
                    print(datastring)
                    soapEnvelope?.appendFormat("&%@=%@", (keys[i]) as! String , datastring!)
                    
                    // use jsonData
                } catch {
                    // report error
                }
            }
        }
        }
        print(soapEnvelope!);
        
        return soapEnvelope!
    }
}
