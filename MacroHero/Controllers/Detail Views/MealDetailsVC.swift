//
//  MealDetailsViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 1/5/22.
//

import UIKit
import AlamofireImage
import Charts

class MealDetailsVC: UIViewController, ChartViewDelegate {
    
    // MARK: - PROPERTIES
    var screenHeight = Utils.screenHeight
    var screenWidth = Utils.screenWidth
    
    private var mealInfo: MealInfo
    var isFavorite = false
    
    var yValues = [ChartDataEntry]()
    var carbsPercent = Double()
    var proteinPercent = Double()
    var fatPercent = Double()
    
    // MARK: - Initializers
    init(mealInfo: MealInfo) {
        self.mealInfo = mealInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChartData()
        setupViews()
    }
    
    // MARK: - LAZY PROPERTIES
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    lazy var iv: UIImageView = {
        let iv = UIImageView()
        if let image = mealInfo.image, let url = URL(string: image), image != "defaultMealImage" {
            let filter = AspectScaledToFillSizeFilter(size: iv.frame.size)
            iv.af.setImage(withURL: url, filter: filter)
        } else {
            iv.image = Image.defaultMealImage
        }
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    lazy var starButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "star")
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapStarButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var titleBlock: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = Color.customYellow
        bgView.layer.cornerRadius = 20
        bgView.addShadowEffect(type: .normalButton)
        
        let typeLabel = MainLabel()
        if let type = mealInfo.type {
            typeLabel.configure(with: MainLabelModel(
                title: type.uppercased(),
                type: .tabView,
                textColor: Color.customOrange))
        }
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.text = mealInfo.name
        nameLabel.font = Font.solid_17
        nameLabel.textColor = Color.customNavy
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakStrategy = []
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [typeLabel, nameLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        bgView.addSubview(stack)
        bgView.addSubview(starButton)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: bgView.topAnchor, constant: screenHeight * 0.02),
            stack.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: screenHeight * 0.02),
            stack.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: screenHeight * -0.02),
            stack.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: screenHeight * -0.025)
        ])
        
        NSLayoutConstraint.activate([
            starButton.topAnchor.constraint(equalTo: bgView.topAnchor, constant: screenHeight * 0.022),
            starButton.rightAnchor.constraint(equalTo: stack.rightAnchor),
            starButton.heightAnchor.constraint(equalTo: typeLabel.heightAnchor, multiplier: 0.75),
            starButton.widthAnchor.constraint(equalTo: starButton.heightAnchor, multiplier: 1.1)
        ])
        
        return bgView
    }()
    
    lazy var pieChartView: PieChartView = {
        var chart = PieChartView()
        chart.holeRadiusPercent = 0.7
        chart.legend.enabled = false
        if let calories = mealInfo.macros?.calories {
            chart.centerAttributedText = createCenterAttributedText(
                calories: calories
            )
        }
        chart.holeColor = .clear
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    lazy var nutritionBlock: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = Color.customYellow
        bgView.layer.cornerRadius = 20
        bgView.addShadowEffect(type: .normalButton)

        let label = MainLabel()
        label.configure(with: MainLabelModel(
            title: "NUTRITION", type: .tabView))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        var carbView = VerticalMacroView()
        var proteinView = VerticalMacroView()
        var fatView = VerticalMacroView()

        if let macros = mealInfo.macros {
            carbView.configure(with: VerticalMacroModel(
                percent: "\(Int(carbsPercent))%", grams: "\(macros.carbs)g",
                label: "Carbs", percentColor: .systemGreen,
                bgColor: UIColor.clear, gramsFont: Font.solid_20))
            carbView.translatesAutoresizingMaskIntoConstraints = false

            proteinView.configure(with: VerticalMacroModel(
                percent: "\(Int(proteinPercent))%", grams: "\(macros.protein)g",
                label: "Protein", percentColor: .systemYellow,
                bgColor: UIColor.clear, gramsFont: Font.solid_20))
            proteinView.translatesAutoresizingMaskIntoConstraints = false

            fatView.configure(with: VerticalMacroModel(
                percent: "\(Int(fatPercent))%", grams: "\(macros.fat)g",
                label: "Fat", percentColor: .systemRed,
                bgColor: UIColor.clear, gramsFont: Font.solid_20))
            fatView.translatesAutoresizingMaskIntoConstraints = false
        }

        let macroStack = UIStackView(arrangedSubviews: [carbView, proteinView, fatView])
        macroStack.axis = .horizontal
        macroStack.distribution = .fillEqually
        macroStack.translatesAutoresizingMaskIntoConstraints = false
        
        let chartMacroStack = UIStackView(arrangedSubviews: [pieChartView, macroStack])
        chartMacroStack.axis = .horizontal
        chartMacroStack.distribution = .fill
        chartMacroStack.translatesAutoresizingMaskIntoConstraints = false
        
        bgView.addSubview(label)
        bgView.addSubview(chartMacroStack)
        
        NSLayoutConstraint.activate([
            macroStack.leftAnchor.constraint(equalTo: pieChartView.rightAnchor, constant: screenHeight * -0.015)
        ])
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: bgView.topAnchor, constant: screenHeight * 0.02),
            label.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: screenHeight * 0.02),
            label.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: screenHeight * -0.02),
        ])
        
        NSLayoutConstraint.activate([
            pieChartView.widthAnchor.constraint(equalTo: bgView.widthAnchor,
                                                multiplier: 0.3),
            pieChartView.heightAnchor.constraint(equalTo: pieChartView.widthAnchor,
                                                multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            chartMacroStack.topAnchor.constraint(equalTo: label.bottomAnchor),
            chartMacroStack.leftAnchor.constraint(equalTo: bgView.leftAnchor),
            chartMacroStack.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: screenHeight * -0.01),
            chartMacroStack.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: screenHeight * -0.02),
        ])
        
        return bgView
    }()

    lazy var ingredientBlock: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = Color.customYellow
        bgView.layer.cornerRadius = 20
        bgView.addShadowEffect(type: .normalButton)
        
        return bgView
    }()

    lazy var instructionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("INSTRUCTIONS", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = Font.solid_25
        button.setBackgroundImage(Image.ctaButton, for: .normal)
        button.addTarget(self, action: #selector(didTapInstructions), for: .touchUpInside)
        button.addShadowEffect(type: .ctaButton)
        
        return button
    }()

    lazy var contentView: UIView = {
        let view = UIView()
//        let view = Utils.createVStack(subviews: [topView, nutritionView, ingredientsView], spacing: Utils.screenHeight * 0.03)
//        view.translatesAutoresizingMaskIntoConstraints = false

//        let fullView = Utils.createVStack(subviews: [partialView, instructionsView],
//                                          spacing: Utils.screenHeight * 0.001)

        return view
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapStarButton() {
        isFavorite.toggle()
        
        let image = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        starButton.setBackgroundImage(image?.withTintColor(.systemYellow), for: .normal)
    }
    
    @objc func didTapInstructions() {
        print("instructions")
    }
    
//    lazy var ingredientsView: UIStackView = {
//        let label = createHeader(title: "INGREDIENTS:")
//        let textView = UILabel()
//
//        if let ingredients = mealInfo.ingredients {
//            textView.numberOfLines = 0
//            textView.attributedText = add(stringList: ingredients)
//        }
//
//        let VStack = Utils.createVStack(subviews: [label, textView],
//                                        spacing: screenWidth * 0.02)
//
//        return VStack
//    }()
    
    // MARK: - HELPER FUNCTIONS
    func setChartData() {
        convertGramsToPercentageValue()
        
        let dataSet = PieChartDataSet(entries: yValues)
        dataSet.colors = [.systemGreen, .systemYellow, .systemRed]
        dataSet.drawValuesEnabled = false
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
    }
    
    func convertGramsToPercentageValue() {
        guard let macros = mealInfo.macros,
              let calories = Double(macros.calories),
              let carbs = Double(macros.carbs),
              let protein = Double(macros.protein),
              let fat = Double(macros.fat) else { return }
        
        carbsPercent = round(((carbs * 4) / calories) * 100)
        proteinPercent = round(((protein * 4) / calories) * 100)
        fatPercent = round(((fat * 9) / calories) * 100)
        
        yValues = [ChartDataEntry(x: 1.0, y: carbsPercent),
                   ChartDataEntry(x: 2.0, y: proteinPercent),
                   ChartDataEntry(x: 3.0, y: fatPercent)]
    }
    
    func createCenterAttributedText(
        calories: String
    ) -> NSMutableAttributedString {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        
        let twoLines = [
            NSAttributedString(
                string: calories + "\n",
                attributes: [
                    .font: Font.solid_17!,
                    .foregroundColor: Color.customNavy!,
                    .paragraphStyle: centeredParagraphStyle,
                ]
            ),
            NSAttributedString(
                string: "cal",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 15,
                                             weight: .regular),
                    .paragraphStyle: centeredParagraphStyle
                ]
            )
        ]
        
        let string = NSMutableAttributedString()
        twoLines.forEach { string.append($0) }
        return string
    }
    
    func add(stringList: [String],
             font: UIFont = Font.solid_15!,
             bullet: String = "\u{2022}",
             indentation: CGFloat = 20,
             lineSpacing: CGFloat = 0,
             paragraphSpacing: CGFloat = 0,
             numberedList: Bool = false) -> NSAttributedString {
        
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: Color.customBlue!]
        let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: Color.customBlue!]
        
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
        view.backgroundColor = Color.bgColor
        addBackButton()
        addSubviews()
        autoLayoutViews()
        constrainSubviews()
    }

    fileprivate func addBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.backButton,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(goBack))
    }
    
    @objc func goBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    fileprivate func addSubviews() {
        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
        scrollView.addSubview(iv)
        scrollView.addSubview(titleBlock)
        scrollView.addSubview(nutritionBlock)
//        scrollView.addSubview(pieChartView)
//        scrollView.addSubview(instructionsButton)
    }
    
    fileprivate func autoLayoutViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleBlock.translatesAutoresizingMaskIntoConstraints = false
        iv.translatesAutoresizingMaskIntoConstraints = false
        instructionsButton.translatesAutoresizingMaskIntoConstraints = false
        nutritionBlock.translatesAutoresizingMaskIntoConstraints = false
//        pieChartView.translatesAutoresizingMaskIntoConstraints = false
    }

    fileprivate func constrainSubviews() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
//        NSLayoutConstraint.activate([
//            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
//        ])
        
        NSLayoutConstraint.activate([
            iv.topAnchor.constraint(equalTo: scrollView.topAnchor),
            iv.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            iv.heightAnchor.constraint(equalTo: iv.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            titleBlock.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleBlock.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.92),
            titleBlock.topAnchor.constraint(equalTo: iv.bottomAnchor, constant: screenHeight * 0.03)
        ])
        
        NSLayoutConstraint.activate([
            nutritionBlock.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nutritionBlock.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.92),
            nutritionBlock.topAnchor.constraint(equalTo: titleBlock.bottomAnchor, constant: screenHeight * 0.03),
//            nutritionBlock.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0.05),
//            nutritionBlock.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
//        NSLayoutConstraint.activate([
//            pieChartView.topAnchor.constraint(equalTo: titleBlock.bottomAnchor),
//            pieChartView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
//                                                multiplier: 0.3),
//            pieChartView.heightAnchor.constraint(equalTo: pieChartView.widthAnchor,
//                                                multiplier: 1)
//        ])
        
//        NSLayoutConstraint.activate([
//            instructionsButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            instructionsButton.topAnchor.constraint(equalTo: iv.bottomAnchor),
////            instructionsButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: screenHeight * -0.09),
//            instructionsButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.83),
//            instructionsButton.heightAnchor.constraint(equalTo: instructionsButton.widthAnchor, multiplier: 0.16)
//        ])
        
        //        contentView.topToSuperview(offset: screenHeight * 0.04)
        //        contentView.centerXToSuperview()
        //        contentView.bottomToSuperview()
        //        contentView.width(screenWidth * 0.8)
    }
}
