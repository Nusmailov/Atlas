//
//  AppConstants.swift
//  JTI
//
//  Created by Tuigynbekov Yelzhan on 9/12/19.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import UIKit

class AppConstants {
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let saveMe = "saveMe"

    class API {
        static let baseUrl = "http://37.46.133.192:781/"
        static let authUrl = "signin"
        static let getBanner = "banners"
        static let getMainPopular = "products/main"
    }
}

enum Font {
    static let montserratBold = "Montserrat-Bold"
    static let montserratBlack = "Montserrat-Black"
    static let montserratMedium = "Montserrat-Medium"
    static let montserratRegular = "Montserrat-Regular"
    static let montserratSemiBold = "MontserratSemiBold"
}
