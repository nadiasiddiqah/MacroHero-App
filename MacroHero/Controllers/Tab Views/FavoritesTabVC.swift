//
//  AddView.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/10/22.
//

import Foundation
import UIKit
import Inject

class FavoritesTabVC: UIViewController {
    
    // MARK: - PROPERTIES
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    var favMeals = [MealInfo]()
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDummyFavMeals()
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(
            title: "FAVORITES",
            type: .tabView
        ))
        
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
        var bar = UISearchBar()
        bar.searchBarStyle = .minimal
        bar.placeholder = "Search"
        bar.searchTextField.clearButtonMode = .always
        
        return bar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(FavMealCell.self,
                           forCellReuseIdentifier: "favMealCell")
        
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    // MARK: - FETCH DATA
    func fetchDummyFavMeals() {
        favMeals = [
            MealInfo(mealOrder: 0, image: "", type: MealType.breakfast.rawValue, name: "Poached Egg & Avocado Toast with Sliced Cherry Tomatoes", macros: Macros(calories: "393", carbs: "60", protein: "23", fat: "20"), ingredients: ["2 eggs", "2 slices whole grain bread", "1/3 avocado", "2 tbsp shaved Parmesan cheese", "Salt and pepper, topping", "Quartered heirloom tomatoes"], instructionsURL: ""),
            MealInfo(mealOrder: 1, image: "", type: MealType.lunch.rawValue, name: "Poached Egg & Avocado Toast", macros: Macros(calories: "393", carbs: "60", protein: "23", fat: "20"), ingredients: ["2 eggs", "2 slices whole grain bread", "1/3 avocado", "2 tbsp shaved Parmesan cheese", "Salt and pepper, topping", "Quartered heirloom tomatoes"], instructionsURL: ""),
            MealInfo(mealOrder: 2, image: "", type: MealType.dinner.rawValue, name: "Poached Egg & Avocado Toast with Sliced Cherry Tomatoes", macros: Macros(calories: "393", carbs: "60", protein: "23", fat: "20"), ingredients: ["2 eggs", "2 slices whole grain bread", "1/3 avocado", "2 tbsp shaved Parmesan cheese", "Salt and pepper, topping", "Quartered heirloom tomatoes"], instructionsURL: "")
        ]
    }
}

extension FavoritesTabVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favMealCell") as! FavMealCell
        
        let meal = favMeals[indexPath.row]
        cell.configure(with: MealCellModel(mealInfo: meal))
        
        // update cell UI
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeal = favMeals[indexPath.row]

        let nextVC = Inject.ViewControllerHost(MealDetailsVC(mealInfo: selectedMeal))
        navigationController?.navigationBar.tintColor = Color.customNavy
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.pushViewController(nextVC, animated: true)
    }

}

extension FavoritesTabVC {
    func setupViews() {
        view.backgroundColor = Color.bgColor
        addSubviews()
        autoLayoutViews()
        constrainSubviews()
    }
    
    func addSubviews() {
        view.addSubview(mainTitle)
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    func autoLayoutViews() {
        let views = [mainTitle, searchBar, tableView]
        
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func constrainSubviews() {
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTitle.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: screenHeight * 0.01),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.94)
        ])
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: screenHeight * 0.01),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
