//
//  HorizontalBarChart.swift
//  ChartsDemo
//
//  Created by Melkon Youssif on 01/05/2019.
//  Copyright © 2019 Melkon Youssif. All rights reserved.
//

import Foundation
import Charts

class HorizontalBarChart: HorizontalBarChartView {
    
    static func create(frame: CGRect) -> HorizontalBarChart {
        let barChartView = HorizontalBarChart(frame: frame)
        
        // let workingInput: [(key: String, value: Double)] = [(key: "123", value: 10), (key: "456", value: 152), (key: "333", value: 153), (key: "890", value: 20)]
        let notWorkingInput: [(key: String, value: Double)] = [(key: "123", value: 30), (key: "456", value: 152), (key: "333", value: 153), (key: "890", value: 20)]
        
        barChartView.sortedDataPoints = notWorkingInput
        return barChartView
    }
    
    private var sortedDataPoints: [(key: String, value: Double)]? {
        didSet {
            setupGraph()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    
    func setupGraph() {
        setGraphData()
        
        chartDescription?.enabled = false
        
        configureGestureRecognizers()
        configureAxes()
        
        setVisibleXRangeMaximum(24)
        extraBottomOffset = 20
        setExtraRightOffset()

        if let entryCount = (data?.entryCount) {
            moveViewToY(Double(entryCount), axis: leftAxis.axisDependency)
        }
        
        animate(yAxisDuration: 1.1)
    }
    
    private func setExtraRightOffset() {
        if let yMax = data?.yMax {
            let digits = (yMax == 0) ? 0 : (floor(log10(yMax)) + 1)
            extraRightOffset = CGFloat(15 + digits * 10)
        } else {
            extraRightOffset = 35
        }
    }
    
    
    private func setGraphData() {
        var dataEntries: [BarChartDataEntry] = []
        guard let sortedDataPoints = sortedDataPoints else { return }
        for i in 0..<sortedDataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: sortedDataPoints[i].value)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        
                chartDataSet.barBorderWidth = 1
                chartDataSet.barBorderColor = UIColor.lightGray
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        chartData.setValueFormatter(DefaultValueFormatter(formatter: getNumberformatter()))
        chartData.setValueFont(.systemFont(ofSize: 13))
        
        
        chartData.barWidth = chartData.entryCount < 5 ? 0.3 : chartData.barWidth
        
        chartData.setDrawValues(true)
        
        data = chartData
        notifyDataSetChanged()
    }
    
    private func getNumberformatter() -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = Locale.current
        numberFormatter.zeroSymbol = "€0,00"
        return numberFormatter
    }
    
    private func configureAxes() {
        configureXAxis()
        leftAxis.enabled = false
        rightAxis.enabled = true
    }
    
    private func configureXAxis() {
        guard let sortedDataPoints = sortedDataPoints else { return }
        xAxis.valueFormatter = AxisValueFormatter(dataPoints: sortedDataPoints)
        xAxis.setLabelCount(sortedDataPoints.count + 1, force: true)
        
        let xAxisPadding = 0.45
        xAxis.axisMinimum =  -0.45
        xAxis.axisMaximum = Double(sortedDataPoints.count) - xAxisPadding
        
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 14, weight: .medium)
        xAxis.labelTextColor = .darkGray
        
        xAxis.centerAxisLabelsEnabled = true
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.granularityEnabled = true
        xAxis.granularity = 1
    }
    
    private func configureGestureRecognizers() {
        dragEnabled = true // to enable scrolling
        setScaleEnabled(true)
        scaleYEnabled = true
        scaleXEnabled = true
        
        pinchZoomEnabled = false
        doubleTapToZoomEnabled = false
    }
}

