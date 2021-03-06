//
//  TabItem.swift
//  TrainningCourse
//
//  Created by MorHN on 24/06/2022.
//

import UIKit

// Model item TabBar
enum TabItem: String, CaseIterable {
    // Item Title
    case homes = "Home"
    case courses = "Course"
    case searchs = "Search"
    case messages = "Message"
    case accounts = "Account"
    
    // Push VC
    var viewController: UIViewController {
        switch self {
        case .homes :
            return UIStoryboard(name: "HomeVC", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
        case .courses :
            return (UIStoryboard(name: "CourseVC", bundle: nil).instantiateInitialViewController() as? CourseViewController)!
        case .searchs :
            return (UIStoryboard(name: "SearchVC", bundle: nil).instantiateInitialViewController() as? SearchViewController)!
        case .messages :
            return (UIStoryboard(name: "MessageVC", bundle: nil).instantiateInitialViewController() as? MessageViewController)!
        case .accounts :
            return (UIStoryboard(name: "AccountVC", bundle: nil).instantiateInitialViewController() as? AccountViewController)!
        }
    }
    
    // Item Image
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
    
    // Pass Item Title
    var displayTitle:String {
        return self.rawValue.capitalized(with: nil)
    }
}
