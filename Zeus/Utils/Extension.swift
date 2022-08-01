//
//  Extension.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init?(hex: String) {
            let r, g, b, a: CGFloat

            if hex.hasPrefix("#") {
                let start = hex.index(hex.startIndex, offsetBy: 1)
                let hexColor = String(hex[start...])

                if hexColor.count == 8 {
                    let scanner = Scanner(string: hexColor)
                    var hexNumber: UInt64 = 0

                    if scanner.scanHexInt64(&hexNumber) {
                        r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                        g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                        b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                        a = CGFloat(hexNumber & 0x000000ff) / 255

                        self.init(red: r, green: g, blue: b, alpha: a)
                        return
                    }
                }
            }

            return nil
        }
}

extension UIViewController {
    
    public func showAlert(title: String, message: String, btnOKString: String = "Aceptar"){
        
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: btnOKString, style: UIAlertAction.Style.default, handler: nil))
            self.navigationController?.present(alert, animated: true, completion: nil)
            
        }
}

extension UIImage
{
    func scaleAndCrop(withAspect: Bool, to: Int) -> UIImage?
    {
        // Scale down the image to avoid wasting unnnecesary storage and network capacity
        let size = CGSize(width: to, height: to)
        let scale = max(size.width/self.size.width, size.height/self.size.height)
        let width = self.size.width * scale
        let height = self.size.height * scale
        let x = (size.width - width) / CGFloat(2)
        let y = (size.height - height) / CGFloat(2)
        let scaledRect = CGRect(x: x, y: y, width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: scaledRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}
