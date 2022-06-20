//
//  RankViewController.swift
//  MacroHero
//
//  Created by Nadia Siddiqah on 12/27/21.
//

import Foundation
import Inject
import UIKit

// TODO: - Implement long press gesture re-ordering
// TODO: - Add reorder symbol to the left of each cell 
class RankVC: UIViewController {
    
    // MARK: - PROPERTIES
    private var userData: UserData
    private var cellData = [TwoLabelCellModel]()
    
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
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
        
        setTableViewData()
        setupViews()
    }
    
    // MARK: - VIEW OBJECTS
    lazy var mainTitle: UILabel = {
        var label = MainLabel()
        label.configure(with: MainLabelModel(
            title: "Rank your macro goals:", type: .onboardingView))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TwoLabelCell.self, forCellReuseIdentifier: "macroCell")
        
        tableView.backgroundColor = Color.customYellow
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
        
        tableView.rowHeight = (screenHeight * 0.3) / 4
        tableView.contentInset.top = 10
        tableView.contentInset.bottom = 10
        
        return tableView
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
  
    // MARK: - NAV METHODS
    @objc func didTapNext() {
        let proteinVC = Inject.ViewControllerHost(ProteinVC())
        navigationController?.pushViewController(proteinVC, animated: true)
    }
    
    // MARK: - FUNCTIONS
    func setTableViewData() {
        guard let macros = userData.nutritionPlan else { return }
        cellData = [
            TwoLabelCellModel(title: "Calories", value: "\(macros.calories)"),
            TwoLabelCellModel(title: "Carbs", value: "\(macros.carbs) g"),
            TwoLabelCellModel(title: "Protein", value: "\(macros.protein) g"),
            TwoLabelCellModel(title: "Fat", value: "\(macros.fat) g")
        ]
    }
}

extension RankVC {
    
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
        view.addSubview(mainTitle)
        view.addSubview(tableView)
        view.addSubview(nextButton)
    }
    
    fileprivate func autoLayoutViews() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func constrainSubviews() {
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: screenHeight * 0.01),
            mainTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: screenHeight * 0.05),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: screenHeight * -0.09),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.83),
            nextButton.heightAnchor.constraint(equalTo: nextButton.widthAnchor, multiplier: 0.16)
        ])
    }
}

extension RankVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "macroCell") as! TwoLabelCell
        
        cell.backgroundColor = Color.customYellow
        
        cell.leftLabel.text = cellData[indexPath.row].title
        cell.rightLabel.text = cellData[indexPath.row].value
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
}
