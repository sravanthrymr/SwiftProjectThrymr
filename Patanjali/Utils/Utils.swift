//
//  Utils.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 20/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import Foundation

extension NSObject
{
    func safeObjectForKey(key : String) -> Any?
    {
        if self.value(forKey: key) is NSNull
        {
            return nil
        }
        else
        {
            return self.value(forKey: key)
        }
    }
}
