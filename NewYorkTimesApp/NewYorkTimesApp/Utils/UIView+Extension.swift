//
//  UIView+Extension.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 08/06/2022.
//

import UIKit

extension UIView {
    func renderShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
