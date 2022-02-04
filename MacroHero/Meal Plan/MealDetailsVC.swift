//
//  MealDetailsViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/5/22.
//

import UIKit
import Combine

class MealDetailsVC: UIViewController {

    // MARK: - PROPERTIES
    private var viewModel: MealDetailsVM
    private var cancellables = Set<AnyCancellable>()
    
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    // MARK: - Initializers
    init(viewModel: MealDetailsVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        let partialView = Utils.createVStack(subviews: [topView, nutritionView, ingredientsView],
                                             spacing: Utils.screenHeight * 0.03)
        partialView.translatesAutoresizingMaskIntoConstraints = false

        let fullView = Utils.createVStack(subviews: [partialView, instructionsView],
                                          spacing: Utils.screenHeight * 0.001)

        return fullView
    }()

    lazy var topView: UIStackView = {
        var titleLabelStack = UIStackView()
        var imageView = UIImageView()
        
        if let type = viewModel.mealInfo.type,
           let name = viewModel.mealInfo.name,
           let image = viewModel.mealInfo.image {
            let title = Utils.createMainTitle(text: type.uppercased(),
                                        textColor: UIColor.customNavy,
                                        noOfLines: 1)
            title.textAlignment = .center
            
            let label = UILabel()
            label.font = UIFont(name: "KGHAPPYSolid", size: 23)
            label.textColor = UIColor.customNavy
            label.textAlignment = .center
            label.text = name
            label.numberOfLines = 0
            label.lineBreakStrategy = []
            label.adjustsFontSizeToFitWidth = true
            
            titleLabelStack = Utils.createVStack(subviews: [title, label],
                                           spacing: screenHeight * 0.03)
            
            imageView.kf.setImage(with: URL(string: image))
            imageView.contentMode = .scaleToFill
            imageView.aspectRatio(1.63)
        }
        
        let fullVStack = Utils.createVStack(subviews: [titleLabelStack, imageView],
                                      spacing: screenHeight * 0.02)
        
        return fullVStack
    }()

    lazy var nutritionView: UIStackView = {
        let label = createHeader(title: "NUTRITION:")
        
        var cal = UIStackView()
        var carbs = UIStackView()
        var protein = UIStackView()
        var fat = UIStackView()
        
        if let macroData = viewModel.mealInfo.macros {
            cal = createMacroHStack(macro: "Calories", value: macroData.calories)
            carbs = createMacroHStack(macro: "Carbs", value: "\(macroData.carbs)g")
            protein = createMacroHStack(macro: "Protein", value: "\(macroData.protein)g")
            fat = createMacroHStack(macro: "Fat", value: "\(macroData.fat)g")
        }
        
        let leftVStack = Utils.createVStack(subviews: [cal, carbs],
                                            spacing: screenHeight * 0.01)
        
        let rightVStack = Utils.createVStack(subviews: [protein, fat],
                                             spacing: screenHeight * 0.01)
        
        let macroHStack = UIStackView(arrangedSubviews: [leftVStack, rightVStack])
        macroHStack.axis = .horizontal
        macroHStack.spacing = screenWidth * 0.05
        
        let fullVStack = Utils.createVStack(subviews: [label, macroHStack],
                                            spacing: screenWidth * 0.02)
        
        return fullVStack
    }()

    lazy var ingredientsView: UIStackView = {
        let label = createHeader(title: "INGREDIENTS:")
        let textView = UILabel()
        
        if let ingredients = viewModel.mealInfo.ingredients {
            textView.numberOfLines = 0
            textView.attributedText = add(stringList: ingredients)
        }

        let VStack = Utils.createVStack(subviews: [label, textView],
                                  spacing: screenWidth * 0.02)

        return VStack
    }()

    lazy var instructionsView: UIStackView = {
        let label = createHeader(title: "INSTRUCTIONS:")
        let textView = UILabel()
        textView.numberOfLines = 0
        
        if let instructions = viewModel.mealInfo.instructions {
            textView.attributedText = add(stringList: instructions,
                                          indentation: 25, numberedList: true)
        }

        let VStack = Utils.createVStack(subviews: [label, textView],
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
//        macroLabel.width(screenWidth * 0.2)

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = UIColor.customNavy
        valueLabel.font = font
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.textAlignment = .right

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

extension MealDetailsVC {
    func setupViews() {
        view.backgroundColor = UIColor(named: "bgColor")
        addSubviews()
        constrainSubviews()
        Utils.setNavigationBar(navController: navigationController, navItem: navigationItem,
                         leftBarButtonItem: UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                            style: .done, target: self,
                                                            action: #selector(goBack)))
    }

    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    fileprivate func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    fileprivate func constrainSubviews() {
        scrollView.edgesToSuperview()

        contentView.topToSuperview(offset: screenHeight * 0.04)
        contentView.centerXToSuperview()
        contentView.bottomToSuperview()
        contentView.width(screenWidth * 0.8)
    }

}
