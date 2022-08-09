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
        
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                let scanner = Scanner(string: hexString)
                if (hexString.hasPrefix("#")) {
                    scanner.scanLocation = 1
                }
                var color: UInt32 = 0
                scanner.scanHexInt32(&color)
                let mask = 0x000000FF
                let r = Int(color >> 16) & mask
                let g = Int(color >> 8) & mask
                let b = Int(color) & mask
                let red   = CGFloat(r) / 255.0
                let green = CGFloat(g) / 255.0
                let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1.0)
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
