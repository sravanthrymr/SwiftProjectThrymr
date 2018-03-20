//
//  AsyncImageView.swift
//  Patanjali
//
//  Created by SRAVANKUMAR V on 20/03/18.
//  Copyright © 2018 SRAVANKUMAR V. All rights reserved.
//

import UIKit
class AsyncImageView: UIImageView
{
    func loadImage(urlString: String)
    {
        let urlStr :String = urlString;
        if !urlStr.isEmpty
        {
            let CACHE_SEC : TimeInterval = 5 * 60;
            
            let request = URLRequest(url: URL(string: urlStr)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: CACHE_SEC)
            let conf =  URLSessionConfiguration.default;
            let session = URLSession(configuration: conf, delegate: nil, delegateQueue: OperationQueue.main);
            
            let task = session.dataTask(with: request as URLRequest!){ data, response, error in
                
                if (error == nil)
                {
                    let image = UIImage(data:data!)
                    self.image = image;
                }
                else
                {
                    print("AsyncImageView:Error \(String(describing: error?.localizedDescription))");
                }
            }
            task.resume()
        }
    }
}


