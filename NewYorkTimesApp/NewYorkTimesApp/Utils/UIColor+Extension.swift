//
//  UIColor+Extension.swift
//  NewYorkTimesTopStories (iOS)
//
//  Created by Mahika on 08/06/2022.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        var characterSet = CharacterSet.whitespacesAndNewlines
        characterSet.formUnion(CharacterSet(charactersIn: "#"))
        let cString = hexString.trimmingCharacters(in: characterSet).uppercased()
        if cString.count != 6 {
            self.init(white: 0.0, alpha: 0.0)
        } else {
            var rgbValue: UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)

            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: CGFloat(1.0))
        }
    }
    
    
    static var grey60: UIColor {
        return UIColor(hexString: "D3D3D3")
    }
}
