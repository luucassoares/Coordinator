//
//  ChartsViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 19/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ChartsViewControllerDelegate: class {
    func didTapAt(charType: ChartType)
}

class ChartsViewController: UIViewController {
    //MARK :- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK :- Vars
    var viewModel: ChartsViewModel?
    let disposeBag = DisposeBag()
    var id = "UITableViewCell"
    weak var delegate: ChartsViewControllerDelegate?
    
    convenience required init (withViewModel: ChartsViewModel?) {
        self.init()
        self.viewModel = withViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK :- Setup
    func setup() {
        setupTableview()
    }
    
    func setupTableview() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: id)
        viewModel!.charts.bind(to: tableView.rx.items(cellIdentifier: id, cellType: UITableViewCell.self)) { row, element, cell in
            cell.textLabel?.text = element.rawValue
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
//        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
//            self.delegate?.didTap(at: indexPath.row)
//            self.tableView.deselectRow(at: indexPath, animated: true)
//        }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ChartType.self).subscribe(onNext: { type in
            self.delegate?.didTapAt(charType: type)
        }).disposed(by: disposeBag)
    }
}

