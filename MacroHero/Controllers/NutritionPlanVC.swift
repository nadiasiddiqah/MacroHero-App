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
    
    #warning("create class for macrodetailview")
    #warning("how to center stack view in superview")
    lazy var carbView: UIView = {
        var view = UIView()
        
        var iv = UIImageView(image: Image.planViewBg)
        iv.frame = CGRect(x: 0, y: 0, width: screenWidth * 0.27,
                                   height: screenHeight * 0.14)
        iv.contentMode = .scaleAspectFit
        iv.addShadowEffect()
        
        var label1 = UILabel()
        label1.text = "31%"
        label1.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label1.textColor = UIColor.systemGreen
        label1.textAlignment = .center
        
        var label2 = UILabel()
        label2.text = "30g"
        label2.font = Font.solid_25
        label2.textColor = Color.customNavy
        label2.textAlignment = .center
        
        var label3 = UILabel()
        label3.text = "Carbs"
        label3.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label3.textColor = Color.customDarkGray
        label3.textAlignment = .center
        
        var labelStack = UIStackView(arrangedSubviews: [label1, label2, label3])
        labelStack.axis = .vertical
        labelStack.spacing = screenHeight * 0.01
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iv)
        iv.addSubview(labelStack)
        
        NSLayoutConstraint.activate([
            labelStack.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            labelStack.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
        ])

        return view
    }()
    
    lazy var proteinView: UIView = {
        var view = UIView()
        
        var iv = UIImageView(image: Image.planViewBg)
        iv.frame = CGRect(x: 0, y: 0, width: screenWidth * 0.27,
                                   height: screenHeight * 0.14)
        iv.contentMode = .scaleAspectFit
        iv.addShadowEffect()
        
        var label1 = UILabel()
        label1.text = "23%"
        label1.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label1.textColor = UIColor.systemYellow
        label1.textAlignment = .center
        
        var label2 = UILabel()
        label2.text = "23g"
        label2.font = Font.solid_25
        label2.textColor = Color.customNavy
        label2.textAlignment = .center
        
        var label3 = UILabel()
        label3.text = "Protein"
        label3.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label3.textColor = Color.customDarkGray
        label3.textAlignment = .center
        
        var labelStack = UIStackView(arrangedSubviews: [label1, label2, label3])
        labelStack.axis = .vertical
        labelStack.spacing = screenHeight * 0.01
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iv)
        iv.addSubview(labelStack)
        
        NSLayoutConstraint.activate([
            labelStack.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            labelStack.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
        ])

        return view
    }()
    
    lazy var fatView: UIView = {
        var view = UIView()
        
        var iv = UIImageView(image: Image.planViewBg)
        iv.frame = CGRect(x: 0, y: 0, width: screenWidth * 0.27,
                                   height: screenHeight * 0.14)
        iv.contentMode = .scaleAspectFit
        iv.addShadowEffect()
        
        var label1 = UILabel()
        label1.text = "46%"
        label1.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label1.textColor = UIColor.systemRed
        label1.textAlignment = .center
        
        var label2 = UILabel()
        label2.text = "20g"
        label2.font = Font.solid_25
        label2.textColor = Color.customNavy
        label2.textAlignment = .center
        
        var label3 = UILabel()
        label3.text = "Fat"
        label3.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label3.textColor = Color.customDarkGray
        label3.textAlignment = .center
        
        var labelStack = UIStackView(arrangedSubviews: [label1, label2, label3])
        labelStack.axis = .vertical
        labelStack.spacing = screenHeight * 0.01
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iv)
        iv.addSubview(labelStack)
        
        NSLayoutConstraint.activate([
            labelStack.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            labelStack.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
        ])

        return view
    }()
    
    lazy var macroStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [carbView, proteinView, fatView])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        
        return stack
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = Font.solid_20
        button.setBackgroundImage(Image.ctaButton, for: .normal)
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        button.addShadowEffect()
        
        return button
    }()
    
    // MARK: - TAP METHODS
    @objc func didTapNext() {
        print("next")
        goToNextScreen()
    }
    
    // MARK: - NAV METHODS
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
        dataSet.colors = ChartColorTemplates.colorful()
        
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
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: screenHeight * 0.12),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            pieChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pieChartView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor,
                                              constant: screenHeight * 0.04),
            pieChartView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            pieChartView.widthAnchor.constraint(equalTo: pieChartView.heightAnchor, multiplier: 1),
            
            macroStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            macroStackView.topAnchor.constraint(equalTo: pieChartView.bottomAnchor,
                                          constant: screenHeight * 0.04),
            macroStackView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                  multiplier: 0.9),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                    constant: screenHeight * -0.1),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.83)
        ])
    }
}
