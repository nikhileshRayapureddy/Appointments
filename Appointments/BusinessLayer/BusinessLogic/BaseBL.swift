//
//  BaseBL.swift
//  HumaraShop
//
//  Created by MARTJACK on 10/27/15.
//  Copyright (c) 2015 Mery. All rights reserved.
//

import UIKit

import Foundation
//enum ParsingConstant : Int
//{
//    case internetLoss = 1000, letter2,letter3
//
//}


enum ParsingConstant : Int
{
    case getLogin = 1000
    case getSignUp
    case getBusinessTypes
    case getBusinessBookingTypes
    case addBusiness
    case getBusiness
    case getListBranches
    case getListSkills
    case getSkills
    case addSkill
    case updateSkill
    case addWorkingPattern
    case getWorkingPattern
    case getWorkingPatternList

}


protocol ParserDelegate{
    func parsingFinished (object: AnyObject?, withTag tag: NSInteger)
    func parsingError (error: String?, withTag tag: NSInteger)
}

class BaseBL: NSObject {
    
    let NoInternet : String = "There seems to be some data connectivity issue with your network. Please check connection and try again."
    
    var callBack : ParserDelegate!
    
    
}
