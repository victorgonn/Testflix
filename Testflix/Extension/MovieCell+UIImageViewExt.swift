//
//  MovieCell+UIImageViewExt.swift
//  Testflix
//
//  Created by Victor Valfre on 18/04/19.
//  Copyright © 2019 Victor Valfre. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if var imgUrl = NSURL(string: urlString) {
            let request = NSURLRequest(url: imgUrl.absoluteURL!)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
                (response: URLResponse!, data: NSData!, error: NSError!) -> Void in
                self.image = UIImage(data: data.)
            }
        }
    }
}
