//
//  OptionsViewModel.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 11/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class OptionsViewModel {
    
    private let bag = DisposeBag()
    private let options = BehaviorRelay<[String]>(value: [])
    
    init( withOptions: [String] ) {
        NSLog("Initing OptionsViewModel")
        self.options.accept(withOptions)
    }
    
    func getOptions() -> BehaviorRelay<[String]> {
        return options
    }
    
    func getOption(at index: Int) -> String {
        return options.value[index]
    }
    
    func getDisposeBag() -> DisposeBag {
        return bag
    }
}
