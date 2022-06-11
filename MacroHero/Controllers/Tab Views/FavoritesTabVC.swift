//
//  AddView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/10/22.
//

import Foundation
import UIKit

class FavoritesTabVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    // MARK: - LAZY OBJECTS
    lazy var mainTitle: UILabel = {
        var label = Utils.createMainTitle(text: "FAVORITES",
                                          textColor: Color.customNavy,
                                          noOfLines: 1)
        
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                  width: screenWidth * 0.93,
                                                  height: screenHeight * 0.04))
        searchBar.barTintColor = Color.customNavy
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = true
        
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(FavoriteMealCell.self,
                           forCellReuseIdentifier: "favMealCell")
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    func setupViews() {
        view.backgroundColor = Color.bgColor
        addSubviews()
        constrainSubviews()
    }
    
    func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    func constrainSubviews() {
        mainTitle.leftToSuperview(offset: screenWidth * 0.09)
        mainTitle.topToSuperview(offset: screenHeight * 0.07)
        
        searchBar.centerXToSuperview()
        searchBar.topToBottom(of: mainTitle, offset: screenHeight * 0.03,
                              isActive: true)
        
        tableView.centerXToSuperview()
        tableView.width(screenWidth * 0.9)
        tableView.topToBottom(of: mainTitle, offset: screenHeight * 0.03)
        tableView.bottomToSuperview()
    }
}

extension FavoritesTabVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
