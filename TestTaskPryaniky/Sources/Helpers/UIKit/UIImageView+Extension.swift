//
//  UIImageView+Extension.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 27.05.2022.
//

import UIKit.UIImageView
import Kingfisher

extension UIImageView {
    func setImage(with url: URL?, id: String) {
        guard let url = url else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: id + "_" + url.absoluteString)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: resource, placeholder: nil, options: [.transition(.fade(0.2))])
    }
}
