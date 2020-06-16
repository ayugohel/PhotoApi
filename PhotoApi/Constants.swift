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

extension UIView {
    func addTabBottomBorderWithColor(color: UIColor, origin : CGPoint, width : CGFloat , height : CGFloat, view: UIView? = nil) -> CALayer {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:origin.x, y:self.frame.size.height - height, width:width, height:height)
        if view == nil {
            self.layer.insertSublayer(border, at: 0)
        } else {
            self.layer.insertSublayer(border, below: view!.layer)
        }
        
        return border
    }
}
