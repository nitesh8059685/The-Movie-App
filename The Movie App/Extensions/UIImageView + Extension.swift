//
//  UIImageView + Extension.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 03/07/24.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    func setImage(with urlString: String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
