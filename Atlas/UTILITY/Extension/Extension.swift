//
//  Extension.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 11/20/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import Foundation
import UIKit

//MARK: - AlertMessageType

enum AlertMessageType: String {
    case error = "Ошибка"
    case none = "Внимание"
}

//MARK:- UITableViewCell
extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

//MARK:- UICollectionViewCell
extension UICollectionViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

//MARK:- UIViewController
extension UIViewController {

    func inNavigation() -> UIViewController {
        self.navigationController?.navigationBar.tintColor = .mainColor
//        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        return UINavigationController(rootViewController: self)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showErrorMessage(_ message: String) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }

    func showAlertWithAction(title: String, message: String, completion: @escaping (()->())) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { (action) in
            completion()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UIView
extension UIView {
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
    func addSubviews(views: [UIView]) -> Void {
        views.forEach({addSubview($0)})
    }
}

//MARK: - UIFont
extension UIFont {
    static func getMullerBoldFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "MullerBold", size: size)!
    }
    static func getMullerRegularFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "MullerRegular", size: size)!
    }
    static func getMullerMediumFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "MullerMedium", size: size)!
    }
    static func getMullerBlackFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "MullerBlack", size: size)!
    }
    
    static func getMontserraBoldFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: size)!
    }
    
    static func getMontserraMediumFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: size)!
    }
    
    static func getMontserraRegularFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }
    
    static func getMontserraSemiBoldFont(on size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-SemiBold", size: size)!
    }
}

//MARK: - UIColor
extension UIColor {
    static let mainColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 1)
    static let mainTitleColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
    static let inputViewColor = #colorLiteral(red: 0.4784313725, green: 0.6941176471, blue: 0.862745098, alpha: 1)
    static let anotherBlue = #colorLiteral(red: 0.631372549, green: 0.7215686275, blue: 0.8117647059, alpha: 1)
    static let whiteBlue = UIColor(red: 0.973, green: 0.98, blue: 0.988, alpha: 1)
}

//MARK: - Image
enum JPEGQuality: CGFloat {
    case lowest  = 0
    case low     = 0.25
    case medium  = 0.5
    case high    = 0.75
    case highest = 1
}

extension UIImage {
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension CATransition {
    
    //New viewController will appear from bottom of screen.
    func segueFromBottom() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromTop
        return self
    }
    //New viewController will appear from top of screen.
    func segueFromTop() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromBottom
        return self
    }
    //New viewController will appear from left side of screen.
    func segueFromLeft() -> CATransition {
        self.duration = 0.4 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
    //New viewController will pop from right side of screen.
    func popFromRight() -> CATransition {
        self.duration = 0.4 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromRight
        return self
    }
    //New viewController will appear from left side of screen.
    func popFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
}
