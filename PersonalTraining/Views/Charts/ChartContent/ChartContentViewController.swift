//
//  ChartContentViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 19/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit
import SwiftCharts

class ChartContentViewController: UIViewController {

    //MARK :- Components
    var backButton: CustomUIButton!
    
    //MARK :- Vars
    var chartType: ChartType!
    var marginGuide: UILayoutGuide!
    
    convenience required init(chartType: ChartType) {
        self.init()
        self.chartType = chartType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        marginGuide = view.layoutMarginsGuide
        setup()
        
    }
    
    func setup() {
        setupBackButton()
        setupChart()
    }
    
    func setupBackButton() {
        backButton = CustomUIButton(type: .custom)
        self.view.addSubview(backButton)
        backButton.borderWidth = 1
        backButton.borderColor = .black
        backButton.setTitle("Voltar", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        backButton.cornerRadius = 8
        backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: self.marginGuide.leadingAnchor, constant: 16).isActive = true
        backButton.topAnchor.constraint(equalTo: self.marginGuide.topAnchor, constant: 32).isActive = true
    }

    func setupChart() {
        let chartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 2, to: 14, by: 2),
            yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
        )
        
        let frame = CGRect(x: 0, y: 70, width: 300, height: 500)
        
        let chart = LineChart(
            frame: frame,
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            lines: [
                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.red),
                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blue)
            ]
        )
        
        self.view.addSubview(chart.view)
    }
    
    //MARK :- Actoins
    @objc func backButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }
}
