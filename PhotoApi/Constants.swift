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


//IMGUR
let imgurClientId = "a7d764bf8ec35de"
let imgurClientSecret = "c0b47f6b274edcc43ff34d753c769509145ed5a8"
let imgurAccessToken = "2b255bf3ba1ab80577d83cab990c92bf69f74f51"
let imgurRefreshToken = "a4f65eb75b360480a9250f7d303ac0e00d7b98bb"
let imgurAccountID = "132879915"


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
