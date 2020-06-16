//
//  Constants.swift
//  GasBuddy PhotoApp
//
//  Created by Ayushi on 2020-06-13.
//  Copyright © 2020 Ayushi. All rights reserved.
//

import Foundation
import UIKit


// STORYBOARD
let StoryBoard = UIStoryboard(name:"Main", bundle: nil)

//UNSPLASH
let unsplashAccessKey = "X8YyBV-VoqaxgmfVMS_SnH9WjVWkzw1Uv8s4xoO8PK0"
let unsplashSecret = "bwuU7GxGca2kU09Itfya9ZNVDIlZEomI5zEsnvhCY6A"

//PIXABAY
let API_KEY = "17047499-78489e68511c44866fa7873e6"


// Enum for API
enum ApiType: String, CaseIterable {
    
    case apiFirst = "PIXABAY"
    case apiSecond = "UNSPLASH"
    
    var apiEndPoint: String {
        switch self {
        case .apiFirst:
            return "PIXABAY"
        default:
            return "UNSPLASH"
        }
    }
}

extension UIColor {
    
    convenience init(_ hexString: String, alpha: Double = 1.0) {
           let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
           var int = UInt64()
           Scanner(string: hex).scanHexInt64(&int)

           let r, g, b: UInt64
           switch hex.count {
           case 3: // RGB (12-bit)
               (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
           case 6: // RGB (24-bit)
               (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
           default:
               (r, g, b) = (1, 1, 0)
           }

           self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(255 * alpha) / 255)
       }
}
