//
//  UIImage+Extension.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import UIKit
import SwiftUI

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    func jpeg(_ jpegQuality: JPEGQuality) -> UIImage {
        if let data = jpegData(compressionQuality: jpegQuality.rawValue) {
            return UIImage(data: data)!
        }
        return self
    }
}
