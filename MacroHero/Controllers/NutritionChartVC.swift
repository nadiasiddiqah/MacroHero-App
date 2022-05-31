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
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // TODO: update with personalized nutrition parameters derived from API
    lazy var pieChartView: PieChartView = {
        var chart = PieChartView()
        chart.holeRadiusPercent = 0.78
        chart.legend.enabled = false
        chart.drawEntryLabelsEnabled = false
        chart.centerAttributedText = createCenterAttributedText(
            calories: calories
        )
        chart.translatesAutoresizingMaskIntoConstraints = false
        
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
//        dataSet.drawValuesEnabled = false
        
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
            pieChartView.widthAnchor.constraint(equalTo: pieChartView.heightAnchor,
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
