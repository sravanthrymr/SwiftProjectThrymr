//
//  Services.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 20/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import Foundation

typealias ComplitionHandler = (_ response: Any, _ error: Error?, _ isSuccess: Bool) -> Void
class Services: NSObject
{
    // MARK: ***** Shared Instatnce
    class var sharedInstatnce: Services
    {
        struct  Static
        {
            static let instance : Services = Services()
        }
        return Static.instance
    }
    // MARK: ***** get URL for Method

    func getURLforMethod(_ MethodName: apiMethodName ) -> String
    {
        
        var url: String
        switch MethodName
        {
        case .login:
            url = "login"
        case .landingPage:
            url = "c/landing-page-response";
        default:
            url = "NoValue"
        }
        return url
    }
  
    // MARK: ***** Header methods
    func getHeaders(_ methodName: apiMethodName, with request: NSMutableURLRequest) -> NSMutableURLRequest
    {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(X_API_KEY, forHTTPHeaderField: "X-API-KEY")
//        [request setHTTPMethod:@"GET"];
      //  [request addValue:UserDefaults_getobject(AUTHENTICATION_KEY) forHTTPHeaderField:@"Authorization"];

        switch methodName
        {
        case .login:
            request.httpMethod = "POST"
        case .landingPage:
            request.httpMethod = "GET"
        default:
            request.httpMethod = "POST"
        }
        return request
    }

    // MARK: ***** Service_CallWithData
    func Service_CallWithData(withParameters dicParameters : Any?,  withMethodName methodName:apiMethodName, complitionHandler : @escaping ComplitionHandler)
    {
        let jsonData : Data? = convertRequest(withApiMethodName: methodName, withObject: dicParameters)

        let urlString = "\(BaseUrl)\(getURLforMethod(methodName))"
        
        let url = URL.init(string: urlString)!
        
        var  request = NSMutableURLRequest.init(url: url)
        if jsonData != nil
        {
            request.httpBody = jsonData
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            request.addValue("\(String(describing: jsonString.count))", forHTTPHeaderField: "Content-Length")
        }
        request = getHeaders(methodName, with: request)
        request.timeoutInterval = 60

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let sessionTask : URLSessionTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            let  httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 500
            {
                complitionHandler("Error occured while connecting to server.", error, false)
                return
            }
            if (error != nil) || response == nil
            {
                complitionHandler("Error occured while connecting to server.", error, false)
            }
            else
            {
                let dicResponse : NSDictionary = ((try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as? NSDictionary)!
                let statusCode = dicResponse.value(forKey: "status") as! Int
                if statusCode == SESSION_EXPIRED || statusCode == INVALID_TOKEN
                {
                    UserDefaults.standard.set("NO", forKey: IS_LOGIN)
                    UserDefaults.standard.set(nil, forKey: AUTHENTICATION_KEY)
                    complitionHandler("Your session has expired. Please login to continue...", error, false)
                }
                if statusCode == ACCOUNT_NOTFOUND && methodName == .logout
                {
                    complitionHandler(dicResponse, error, true);
                }
                else if statusCode == ACCOUNT_BLOCKED
                {
                    UserDefaults.standard.set("NO", forKey: IS_LOGIN)
                    UserDefaults.standard.set(nil, forKey: AUTHENTICATION_KEY)

                    let strMessageToReturn = dicResponse.value(forKey: "message") as Any?
                    if strMessageToReturn is String
                    {
                        complitionHandler(dicResponse.value(forKey: "message") as! String, error, false)
                    }
                    else
                    {
                        complitionHandler("Your Account Blocked, Please contact Patanjali Admin..", error, false)
                    }
                }
                complitionHandler(dicResponse, error, true);
            }
            dispatchGroup.leave()
        }
        sessionTask.resume()
    }

    // MARK: ***** Convert Request
    func convertRequest(withApiMethodName methodName:apiMethodName, withObject object:Any?) -> Data?
    {
        let objJsonConverter = JsonConverter.sharedInstance
        switch methodName
        {
        case .login:
            return objJsonConverter.convertLoginObject(toJson: object as! structLogin)
        default:
            return nil
        }
    }
}
