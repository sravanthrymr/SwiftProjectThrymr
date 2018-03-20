//
//  JsonConverter.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 20/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import Foundation
class JsonConverter: NSObject
{
    class var sharedInstance: JsonConverter
    {
        struct Static
        {
            static let instance: JsonConverter = JsonConverter()
        }
        return Static.instance
    }
    
    func convertLoginObject(toJson objStruct: structLogin) -> Data
    {
        var maindic = [String:String]()
        maindic["userId"] = objStruct.strUserId
        maindic["password"] = objStruct.strPassword
        
        let encoder = JSONEncoder()
        let data = try! encoder.encode(maindic)
        return data
    }
}
