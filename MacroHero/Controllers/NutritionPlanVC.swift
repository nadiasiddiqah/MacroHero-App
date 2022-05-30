//
//  NutritionPlanVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/20/22.
//

import UIKit
import Charts
import Inject

class NutritionPlanVC: UIViewController, ChartViewDelegate {
    
    // TODO: retrieve generated personalized nutrition and show in views
    // MARK: - PROPERTIES
    var screenWidth = Utils.screenWidth
    var screenHeight = Utils.screenHeight
    var calories = 1890
    
    // MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setData()
    }
    
    let yValues: [ChartDataEntry] = [ChartDataEntry(x: 1.0, y: 31.0),
                                     ChartDataEntry(x: 2.0, y: 23.0),
                                     ChartDataEntry(x: 3.0, y: 46.0)]
    
    lazy var mainTitle: UILabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(
            title: "Here's your plan"))
        
        return label
    }()
    
    // TODO: update with personalized nutrition parameters derived from API
    // TODO: update pie chart colors to match views below
    lazy var pieChartView: PieChartView = {
        var chart = PieChartView()
        chart.holeRadiusPercent = 0.78
        chart.legend.enabled = false
        chart.drawEntryLabelsEnabled = false
        chart.centerAttributedText = createCenterAttributedText(
            calories: calories
        )
        
        return chart
    }()
    
   // TODO: update with personalized nutrition parameters derived from API
    lazy var macroStackView: UIStackView = {
        var carbView = MacroDetailView()
        carbView.configure(with: MacroDetailModel(
            percent: "31%", grams: "30g",
            label: "Carbs", percentColor: .systemGreen))
        
        var proteinView = MacroDetailView()
        proteinView.configure(with: MacroDetailModel(
            percent: "23%", grams: "23g",
            label: "Protein", percentColor: .systemYellow))
        
        var fatView = MacroDetailView()
        fatView.configure(with: MacroDetailModel(
            percent: "46%", grams: "20g",
            label: "Fat", percentColor: .systemRed))
        
        var stack = UIStackView(arrangedSubviews: [carbView, proteinView, fatView])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = Font.solid_25
        button.setBackgroundImage(Image.ctaButton, for: .normal)
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        button.addShadowEffect(type: .ctaButton)
        
        return button
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapNext() {
        print("next")
        goToNextScreen()
    }
    
    // MARK: - NAV METHODS
    // TODO: generate meal plan based on nutrition plan, go to MealPlan screen
    func goToNextScreen() {
//        let nextScreen = Inject.ViewControllerHost(MealPlanVC())
//        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    // MARK: - HELPER METHODS
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData() {
        let dataSet = PieChartDataSet(entries: yValues)
        dataSet.colors = [.systemGreen, .systemYellow, .systemRed]
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
    }
    
    func createCenterAttributedText(
        calories: Int
    ) -> NSMutableAttributedString {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        
        let twoLines = [
            NSAttributedString(
                string: "\(calories)" + "\n",
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
}

extension NutritionPlanVC {
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
        view.addSubview(mainTitle)
        view.addSubview(pieChartView)
        view.addSubview(macroStackView)
        view.addSubview(nextButton)
    }
    
    fileprivate func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        macroStackView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: screenHeight * 0.01),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            pieChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pieChartView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor,
                                              constant: screenHeight * 0.04),
            pieChartView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            pieChartView.widthAnchor.constraint(equalTo: pieChartView.heightAnchor,
                                                multiplier: 1),
            
            macroStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            macroStackView.topAnchor.constraint(equalTo: pieChartView.bottomAnchor,
                                                constant: screenHeight * 0.04),
            macroStackView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                  multiplier: 0.9),
            macroStackView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                                   multiplier: 0.14),
            
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: screenHeight * -0.1),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.83)
        ])
    }
}
