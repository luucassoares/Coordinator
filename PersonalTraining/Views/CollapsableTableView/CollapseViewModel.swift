//
//  CollapseViewModel.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import Foundation
class CollapseViewModel {
    
    //MARK :- Vars
    var data = [Section]()
    
    //MARK :- Init
    init ( with data: [Section] ) {
        self.data = data
    }
    
    //MARK :- Getters
    func getNumberOfSections() -> Int {
        return data.count
    }
    
    func getNumberOfRowsInSection(at section: Int) -> Int {
        let sectionItem = data[section]
        return sectionItem.collapsed ? 0 : sectionItem.items.count
    }
    
    func getModelAtIndexPath(at indexPath: IndexPath) -> Item {
        return data[indexPath.section].items[indexPath.row]
    }
    
    func getHeaderTitle(at section: Int) -> String {
        return data[section].name
    }
    
    func getCollapsed(atSection section: Int) -> Bool {
        return data[section].collapsed
    }
    
    //MARK :- Setters
    func setCollapsible(at section: Int) {
        data[section].collapsed.toggle()
    }
}
