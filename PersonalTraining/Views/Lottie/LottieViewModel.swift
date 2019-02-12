//
//  LottieViewModel.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 11/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LottieViewModel {
    let disposeBag = DisposeBag()
    let content = BehaviorRelay<[(icon: String, title: String)]>(value: [])
    
    init(collectionContent: [(String,String)]) {
        print("Initing LottieViewModel")
        content.accept(collectionContent)
    }
    
    func getCellIdentifier() -> String {
        return "LottieCell"
    }
}
