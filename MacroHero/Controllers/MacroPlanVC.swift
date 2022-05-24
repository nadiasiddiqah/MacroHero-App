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
        var label = UILabel()
        label.text = "Here's your plan"
        label.font = Fonts.solid_30
        label.textColor = Color.customOrange
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var pieChartView: PieChartView = {
        var chart = PieChartView()
        chart.holeRadiusPercent = 0.78
        chart.legend.enabled = false
        chart.drawEntryLabelsEnabled = false
        chart.centerAttributedText = centerAttributedStringInPieHole(calories: calories)
        
        return chart
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
    
    func centerAttributedStringInPieHole(calories: Int) -> NSMutableAttributedString {
        let centerText = """
                        \(calories)
                        cal
                        """
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: centerText)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle,
                                      range: NSRange(location: 0, length: 7))
        attributedString.addAttribute(.foregroundColor, value: Color.customBlue!,
                                      range: NSRange(location: 0, length: 4))
        attributedString.addAttribute(.font, value: Fonts.solid_30!, range: NSRange(location: 0, length: 4))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 25, weight: .regular),
                                      range: NSRange(location: 5, length: 3))
        
        return attributedString
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
    }
    
    fileprivate func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
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
            pieChartView.widthAnchor.constraint(equalTo: pieChartView.heightAnchor, multiplier: 1)
        ])
    }
}
