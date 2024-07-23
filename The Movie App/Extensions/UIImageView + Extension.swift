//
//  UIImageView + Extension.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 23/07/24.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    // Method to set an image from a URL string using Kingfisher
    func setImage(with urlString: String) {
        guard let url = URL.init(string: urlString) else {
            return // Return if the URL is invalid
        }
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
