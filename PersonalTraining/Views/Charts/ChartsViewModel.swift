//
//  ChartsViewModel.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 19/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ChartsViewModel {
    let charts = BehaviorRelay<[ChartType]>(value: [])
    
    init (with chartOptions: [ChartType]) {
        self.charts.accept(chartOptions)
    }
}
