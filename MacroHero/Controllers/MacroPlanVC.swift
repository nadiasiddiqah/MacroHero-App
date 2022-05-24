//
//  MacroPlanVC.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 5/20/22.
//

import UIKit
import Charts

class MacroPlanVC: UIViewController, ChartViewDelegate {
    
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
    
    #warning("figure out how to make bgImageView bigger")
    lazy var carbView: UIView = {
        var carbView = UIView()
        
        var bgImageView = UIImageView(image: Image.planViewBg)
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.addShadowEffect()
        
        carbView.addSubview(bgImageView)
        
        return carbView
    }()
    
    // Stack view
    // Add carbs - %, g, and title
    // Add protein -
    // Add fat -
    
    // MARK: - TAP METHODS
    
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
                    .font: Fonts.solid_35!,
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

extension MacroPlanVC {
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
        view.addSubview(carbView)
    }
    
    fileprivate func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        carbView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func constrainViews() {
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight * 0.12),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            pieChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pieChartView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor,
                                              constant: screenHeight * 0.05),
            pieChartView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            pieChartView.widthAnchor.constraint(equalTo: pieChartView.heightAnchor, multiplier: 1),
            
            carbView.topAnchor.constraint(equalTo: pieChartView.bottomAnchor,
                                          constant: screenHeight * 0.05),
            carbView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: screenWidth * 0.07),
            carbView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
    }
}
