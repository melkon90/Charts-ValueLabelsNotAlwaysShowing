//
//  AxisValueFormatter.swift
//  ChartsDemo
//
//  Created by Melkon Youssif on 01/05/2019.
//  Copyright © 2019 Melkon Youssif. All rights reserved.
//

import Foundation
import Charts

final class AxisValueFormatter: IAxisValueFormatter {
    
    var sortedDataPoints = [(key: String, value: Double)]()
    
    convenience init(dataPoints: [(key: String, value: Double)]) {
        self.init()
        self.sortedDataPoints = dataPoints
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int((value).rounded())
        
        if index >= 0 && index < sortedDataPoints.count {
            return sortedDataPoints[index].key
        }
        return "NA"
    }
}
