//
//  MealDetailsViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/5/22.
//

import UIKit

class MealDetailsViewController: UIViewController {

    // MARK: - PROPERTIES
    var contentViewSize = CGSize(width: screenWidth,
                                 height: screenHeight + screenHeight * 0.11)
    
    var mealData = MealData(image: "defaultMealImage",
                            type: "Breakfast",
                            name: "Poached Egg & Avocado Toast",
                            macros: MacroBreakdown(calories: "394", carbs: "60g",
                                                   protein: "23g", fat: "20g"))
    
    // MARK: VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - VIEW OBJECTS
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        
        return view
    }()
    
    lazy var topView: UIStackView = {
        let type = createMainTitle(text: mealData.type.uppercased(),
                                   textColor: UIColor.customNavy,
                                   noOfLines: 1)
        type.textAlignment = .center
        
        let name = UILabel()
        name.font = UIFont(name: "KGHAPPYSolid", size: 23)
        name.textColor = UIColor.customNavy
        name.textAlignment = .center
        name.text = mealData.name
        name.numberOfLines = 2
        name.adjustsFontSizeToFitWidth = true
        
        let typeNameStack = createVStack(subviews: [type, name],
                                         spacing: screenHeight * 0.03)
        
        let image = UIImageView(image: UIImage(named: mealData.image))
        image.contentMode = .scaleAspectFill
        image.aspectRatio(1.63)
        
        let fullVStack = createVStack(subviews: [typeNameStack, image],
                                      spacing: screenHeight * 0.02)
        
        return fullVStack
    }()
    
    #warning("complete nutrition view")
    lazy var nutritionView: UIStackView = {
        let nutrition = UILabel()
        nutrition.font = UIFont(name: "KGHAPPY", size: 25)
        nutrition.textColor = UIColor.customNavy
        nutrition.text = "NUTRITION:"
        nutrition.adjustsFontSizeToFitWidth = true
        
        return nutrition
    }()
    
    // MARK: - TAP METHODS
    
    // MARK: - FUNCTIONS
}
