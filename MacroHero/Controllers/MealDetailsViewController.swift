//
//  MealDetailsViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/5/22.
//

import UIKit

class MealDetailsViewController: UIViewController {

    // MARK: - PROPERTIES
    var mealData = MealData(image: "defaultMealImage",
                            type: "Breakfast",
                            name: "Poached Egg & Avocado Toast",
                            macros: MacroBreakdown(calories: "394", carbs: "60g",
                                                   protein: "23g", fat: "20g"),
                            ingredients: [
                                "2 eggs", "2 slices whole grain bread", "1/3 avocado", "2 tbsp shaved Parmesan cheese", "Salt and pepper, topping", "Fresh herbs, topping", "Quartered heirloom tomatoes, for serving"
                            ],
                            instructions: ["Bring a pot of water to boil (use enough water to cover the eggs when they lay in the bottom).",
                                "Drop the metal rims (outer rim only) of two mason jar lids into the pot so they are laying flat on the bottom. When the water is boiling, turn off the heat and carefully crack the eggs directly into each rim.",
                                "Cover the pot and poach for 5 minutes (4 for super soft, 4:30 for soft, 5 or more for semi-soft yolks).",
                                "While the eggs are cooking, toast the bread and smash the avocado on each piece of toast.",
                                "When the eggs are done, use a spatula to lift the eggs out of the water. Gently pull the rim off of the eggs (I do this right on the spatula, over the water) and place the poached eggs on top of the toast.",
                                "Sprinkle with Parmesan cheese, salt, pepper, and fresh herbs; serve with the fresh quartered heirloom tomatoes."
                            ])
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    // MARK: - VIEW OBJECTS
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let partialView = createVStack(subviews: [topView, nutritionView, ingredientsView],
                                       spacing: screenHeight * 0.03)
        partialView.translatesAutoresizingMaskIntoConstraints = false
        
        let fullView = createVStack(subviews: [partialView, instructionsView],
                                    spacing: screenHeight * 0.001)
        
        return fullView
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
    
    lazy var nutritionView: UIStackView = {
        let label = createHeader(title: "NUTRITION:")
        
        let macroData = mealData.macros
        let cal = createMacroHStack(macro: "Calories", value: macroData.calories)
        let carbs = createMacroHStack(macro: "Carbs", value: macroData.carbs)
        let protein = createMacroHStack(macro: "Protein", value: macroData.protein)
        let fat = createMacroHStack(macro: "Fat", value: macroData.fat)
        
        let leftVStack = createVStack(subviews: [cal, carbs],
                                      spacing: screenHeight * 0.01)
        
        let rightVStack = createVStack(subviews: [protein, fat],
                                       spacing: screenHeight * 0.01)
        
        let macroHStack = UIStackView(arrangedSubviews: [leftVStack, rightVStack])
        macroHStack.axis = .horizontal
        macroHStack.spacing = screenWidth * 0.1
        
        let fullVStack = createVStack(subviews: [label, macroHStack],
                                      spacing: screenWidth * 0.02)
        
        return fullVStack
    }()
    
    lazy var ingredientsView: UIStackView = {
        let label = createHeader(title: "INGREDIENTS:")
        
        let textView = UILabel()
        textView.numberOfLines = 0
        textView.attributedText = add(stringList: mealData.ingredients)
        
        let VStack = createVStack(subviews: [label, textView],
                                  spacing: screenWidth * 0.02)
        
        return VStack
    }()
    
    lazy var instructionsView: UIStackView = {
        let label = createHeader(title: "INSTRUCTIONS:")
        
        let textView = UILabel()
        textView.numberOfLines = 0
        textView.attributedText = add(stringList: mealData.instructions,
                                      indentation: 25, numberedList: true)
        
        let VStack = createVStack(subviews: [label, textView],
                                  spacing: screenWidth * 0.02)
        
        return VStack
    }()
    
    // MARK: - TAP METHODS
    
    // MARK: - FUNCTIONS
    func createHeader(title: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "KGHAPPY", size: 25)
        label.textColor = UIColor.customNavy
        label.text = title
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }
    
    func createMacroHStack(macro: String, value: String) -> UIStackView {
        let font = UIFont(name: "KGHAPPYSolid", size: 17)
        
        let macroLabel = UILabel()
        macroLabel.text = macro
        macroLabel.textColor = UIColor.customBlue
        macroLabel.font = font
        macroLabel.adjustsFontSizeToFitWidth = true
        macroLabel.width(screenWidth * 0.2)

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = UIColor.customNavy
        valueLabel.font = font
        valueLabel.adjustsFontSizeToFitWidth = true
        
        let macroHStack = UIStackView(arrangedSubviews: [macroLabel, valueLabel])
        macroHStack.axis = .horizontal
        macroHStack.spacing = screenWidth * 0.06
        
        return macroHStack
    }

    func add(stringList: [String],
             font: UIFont = UIFont(name: "KGHAPPYSolid", size: 17)!,
             bullet: String = "\u{2022}",
             indentation: CGFloat = 20,
             lineSpacing: CGFloat = 0,
             paragraphSpacing: CGFloat = 0,
             numberedList: Bool = false) -> NSAttributedString {

        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.customBlue!]
        let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.customBlue!]

        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [
            NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation

        let bulletList = NSMutableAttributedString()
        
        if numberedList {
            for (index, string) in stringList.enumerated() {
                let formattedString = "\(index + 1)" + "." + "\t\(string)\n"
                let attributedString = NSMutableAttributedString(string: formattedString)

                attributedString.addAttributes(
                    [NSAttributedString.Key.paragraphStyle : paragraphStyle],
                    range: NSMakeRange(0, attributedString.length))

                attributedString.addAttributes(
                    textAttributes,
                    range: NSMakeRange(0, attributedString.length))

                let string:NSString = NSString(string: formattedString)
                let rangeForBullet:NSRange = string.range(of: bullet)
                attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
                bulletList.append(attributedString)
            }
        } else {
            for string in stringList {
                let formattedString = "\(bullet)\t\(string)\n"
                let attributedString = NSMutableAttributedString(string: formattedString)

                attributedString.addAttributes(
                    [NSAttributedString.Key.paragraphStyle : paragraphStyle],
                    range: NSMakeRange(0, attributedString.length))

                attributedString.addAttributes(
                    textAttributes,
                    range: NSMakeRange(0, attributedString.length))

                let string:NSString = NSString(string: formattedString)
                let rangeForBullet:NSRange = string.range(of: bullet)
                attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
                bulletList.append(attributedString)
            }
        }
        
        return bulletList
    }
}
