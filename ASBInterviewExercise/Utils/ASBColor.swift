//
//  ASBColor.swift
//  ASBInterviewExercise
//
//  Created by Chao on 31/07/22.
//

import Foundation
import UIKit

enum ASBColor: String {
    case red = "asbRed"
    case green = "asbGreen"
    case black = "asbBlack"

}

extension UIColor {
    static func asbColor(_ asbColor: ASBColor) -> UIColor? {
        return UIColor(named: asbColor.rawValue)
    }
}
