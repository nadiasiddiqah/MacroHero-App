//
//  NutritionPlanVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/20/22.
//

import UIKit
import Charts
import Inject

class NutritionChartVC: UIViewController, ChartViewDelegate {
    
    // MARK: - PROPERTIES
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    private var userData: UserData
    var yValues = [ChartDataEntry]()
    
    var carbsPercent = Double()
    var proteinPercent = Double()
    var fatPercent = Double()
    
    // MARK: - INITIALIZERS
    init(userData: UserData) {
        self.userData = userData
        
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
        calculateMealReqs()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(
            title: "Here's your plan", type: .onboardingView))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var pieChartView: PieChartView = {
        var chart = PieChartView()
        chart.holeRadiusPercent = 0.72
        chart.legend.enabled = false
        chart.drawEntryLabelsEnabled = false
        if let calories = userData.nutritionPlan?.calories {
            chart.centerAttributedText = createCenterAttributedText(
                calories: calories
            )
        }
        chart.translatesAutoresizingMaskIntoConstraints = false
        
        return chart
    }()
    
    lazy var macroStackView: UIStackView = {
        var carbView = VerticalMacroView()
        var proteinView = VerticalMacroView()
        var fatView = VerticalMacroView()
        
        if let macroPlan = userData.nutritionPlan {
            carbView.configure(with: VerticalMacroModel(
                percent: "\(Int(carbsPercent))%", grams: "\(macroPlan.carbs)g",
                label: "Carbs", percentColor: .systemGreen))
            
            proteinView.configure(with: VerticalMacroModel(
                percent: "\(Int(proteinPercent))%", grams: "\(macroPlan.protein)g",
                label: "Protein", percentColor: .systemYellow))
            
            fatView.configure(with: VerticalMacroModel(
                percent: "\(Int(fatPercent))%", grams: "\(macroPlan.fat)g",
                label: "Fat", percentColor: .systemRed))
        }
        
        var stack = UIStackView(arrangedSubviews: [carbView, proteinView, fatView])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var topStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mainTitle, pieChartView, macroStackView])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = screenHeight * 0.03
        
        return stack
    }()
    
    lazy var nextButton: UIButton = {
        let button = CTAButton()
        button.configure(with: CTAButtonModel(name: "NEXT", backgroundColor: Color.ctaButtonColor) {
            self.didTapNext()
        })
        button.addShadowEffect(type: .ctaButton)
        
        return button
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapNext() {
        print("next")
        goToNextScreen()
    }
    
    // MARK: - NAV METHODS
    func goToNextScreen() {
        let nextScreen = Inject.ViewControllerHost(RankVC(userData: self.userData))
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    // MARK: - HELPER METHODS
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func convertGramsToPercentageValue() {
        guard let macros = userData.nutritionPlan,
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

    func formatToPercentage(data: PieChartData) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.multiplier = 1.0
        formatter.percentSymbol = "%"
        formatter.zeroSymbol = ""
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
    }
    
    func setChartData() {
        convertGramsToPercentageValue()
        
        let dataSet = PieChartDataSet(entries: yValues)
        dataSet.colors = [.systemGreen, .systemYellow, .systemRed]
//        dataSet.drawValuesEnabled = false
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        
        formatToPercentage(data: data)
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
                    .font: Font.solid_35!,
                    .foregroundColor: Color.customNavy!,
                    .paragraphStyle: centeredParagraphStyle
                ]
            ),
            NSAttributedString(
                string: "cal",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 25,
                                             weight: .regular),
                    .paragraphStyle: centeredParagraphStyle
                ]
            )
        ]
        
        let string = NSMutableAttributedString()
        twoLines.forEach { string.append($0) }
        return string
    }
    
    func calculateMealReqs() {
        guard let macros = userData.nutritionPlan else { return }
        
        if let cal = Int(macros.calories), let carbs = Int(macros.carbs),
           let protein = Int(macros.protein), let fat = Int(macros.fat) {
            let mealReqMacros = Macros(calories: (String(cal/3)), carbs: (String(carbs/3)),
                                       protein: String(protein/3) + "+", fat: (String(fat/3)))
            let breakfastReq = MealReq(type: MealType.breakfast.rawValue, macros: mealReqMacros, random: true)
            let lunchReq = MealReq(type: MealType.lunch.rawValue, macros: mealReqMacros, random: true)
            let dinnerReq = MealReq(type: MealType.dinner.rawValue, macros: mealReqMacros, random: true)
            
            print(userData.nutritionPlan)
            userData.mealReqs = [breakfastReq, lunchReq, dinnerReq]
            print(userData.mealReqs)
        }
    }
}

extension NutritionChartVC {
    fileprivate func setupViews() {
        view.backgroundColor = Color.bgColor
        addBackButton()
        addViews()
        autoLayoutViews()
        constrainViews()
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
    
    fileprivate func addViews() {
        view.addSubview(topStack)
        view.addSubview(nextButton)
    }
    
    fileprivate func autoLayoutViews() {
        topStack.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
        
        NSLayoutConstraint.activate([
            pieChartView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor,
                                                multiplier: 0.5),
            pieChartView.heightAnchor.constraint(equalTo: pieChartView.widthAnchor,
                                                multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            macroStackView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                  multiplier: 0.9),
            macroStackView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                                   multiplier: 0.14)
        ])
        
        NSLayoutConstraint.activate([
            topStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: screenHeight * 0.01),
            topStack.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(greaterThanOrEqualTo: topStack.bottomAnchor, constant: screenHeight * 0.04),
            nextButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: screenHeight * -0.09),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.83),
            nextButton.heightAnchor.constraint(equalTo: nextButton.widthAnchor, multiplier: 0.16)
        ])
        
    }
}
