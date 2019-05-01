//
//  ViewController.swift
//  ChartsDemo
//
//  Created by Melkon Youssif on 01/05/2019.
//  Copyright © 2019 Melkon Youssif. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    private var barChartView: HorizontalBarChart?
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard barChartView == nil else { return }
        setupGraph()
    }
    
    private func setupGraph(dataPoints: [String : Double]? = [:]) {
        let barChartView = HorizontalBarChart.create(frame: view.frame)
        barChartView.delegate = self
        self.barChartView = barChartView
        view.addSubview(barChartView)
    }

}

