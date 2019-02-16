//
//  ExtensionTableView.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit

extension UITableView {
    func removeBlankEspaces() {
        self.tableFooterView = UIView()
    }
    
    // MARK: - RegisterNib
    /**
     Registra a nib na tableView
     */
    func registerNib(named: String){
        self.tableView.register(UINib(nibName: named, bundle: nil), forCellReuseIdentifier: named)
    }
    
}
