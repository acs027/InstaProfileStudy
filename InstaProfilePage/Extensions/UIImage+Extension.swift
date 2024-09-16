//
//  UIImage+Extension.swift
//  InstaProfilePage
//
//  Created by ali cihan on 16.09.2024.
//

import Foundation
import UIKit

extension UIImage {
    func roundedImage(size: CGFloat) -> UIImage {
        let cgSize = CGSize(width: size, height: size)
        
        UIGraphicsBeginImageContextWithOptions(cgSize, false, 0.0)
        
        let rect = CGRect(origin: .zero, size: cgSize)
        
        let path = UIBezierPath(ovalIn: rect)
        
        UIColor.black.setStroke()
        path.lineWidth = 1
        path.stroke()
        
        path.addClip()
        
        self.draw(in: rect)
        
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return roundedImage ?? self
    }
    
    func resized(size: CGFloat) -> UIImage? {
        let cgSize = CGSize(width: size, height: size)
        UIGraphicsBeginImageContextWithOptions(cgSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: cgSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
