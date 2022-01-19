//
//  ProfileView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/10/22.
//

import Foundation
import UIKit

class ProfileView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Profile"
    }
}

class SearchView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Search"
    }
}

class FavView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Favorites"
    }
}

// Add in allergies
// Food intolerances + food preferences
// Groceries tab - add to groceries, buy from instacart?
