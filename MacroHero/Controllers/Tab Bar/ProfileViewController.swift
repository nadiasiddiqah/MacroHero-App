//
//  ProfileViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/10/22.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Profile"
    }
}

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Search"
    }
}

class FavViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Favorites"
    }
}
