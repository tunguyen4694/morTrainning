//
//  TabItem.swift
//  TrainningCourse
//
//  Created by MorHN on 24/06/2022.
//

import UIKit

enum TabItem: String, CaseIterable {
    case homes = "home"
    case courses = "courses"
    case searchs = "searchs"
    case messages = "messages"
    case accounts = "accounts"
    
    var viewController: UIViewController {
            switch self {
            case .homes :
                return HomeViewController()
            case .courses :
                return LoginViewController()
            case .searchs :
                return SignUpViewController()
            case .messages :
                return HomeViewController()
            case .accounts :
                return HomeViewController()
            }
        }
    
    var icon: UIImage {
        switch self {
        case .homes :
            return UIImage(systemName: "house.fill")!
        case .courses :
            return UIImage(systemName: "book.closed.fill")!
        case .searchs :
            return UIImage(systemName: "magnifyingglass")!
        case .messages :
            return UIImage(systemName: "message.fill")!
        case .accounts :
            return UIImage(systemName: "person.fill")!
        }
    }
    
    var displayTitle:String {
        return self.rawValue.capitalized(with: nil)
    }
}
