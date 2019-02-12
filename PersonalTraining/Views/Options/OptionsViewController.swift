//
//  OptionsViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 11/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit
import RxSwift
import ViewAnimator

protocol OptionsViewControllerDelegate: class {
    func didTapOption(at index: Int)
}

class OptionsViewController: UIViewController {

    //MARK :- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK :- Vars
    var viewModel: OptionsViewModel?
    weak var delegate: OptionsViewControllerDelegate?
    
    convenience required init(withViewModel: OptionsViewModel) {
        self.init()
        self.viewModel = withViewModel
    }
    
    //MARK :- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.didTapOption(at: 3)
    }
    
    //MARK :- Setup
    func setup() {
        title = "Options View"
        setupTableview()
    }
    
    func setupTableview() {
        tableView.removeBlankEspaces()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        viewModel!.getOptions().asObservable().bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
            cell.textLabel?.text = "Row: \(row) - \(element)"
        }.disposed(by: viewModel!.getDisposeBag())
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            self.delegate?.didTapOption(at: indexPath.row)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: viewModel!.getDisposeBag())
    }
    
    func animateTableView() {
        let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
        let zoomAnimation = AnimationType.zoom(scale: 0.5)
        UIView.animate(views: tableView.visibleCells, animations: [zoomAnimation, fromAnimation], delay: 0.3)
    }
}

