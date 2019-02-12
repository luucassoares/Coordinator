//
//  RxOptionViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 11/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class RxOptionViewController: UIViewController {

    //MARK :- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK :- ViewModel
    let viewModel = RxOptionViewModel()
    
    //MARK :- Vars
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Buscar universidade"
        return searchController
    }()
    let disposeBag = DisposeBag()
    let apiClient = APIClient()
    
    //MARK :- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK :- Setup
    func setup() {
        setupTableView()
        setupUI()
    }

    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.removeBlankEspaces()
    }
    
    func setupUI() {
        searchController.searchBar.rx.text.asObservable()
            .map { ($0 ?? "").lowercased() }
            .map { UniversityRequest(name: $0) }
            .flatMap { request -> Observable<[UniversityModel]> in
                return self.apiClient.send(apiRequest: request)
            }
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { index, model, cell in
                cell.textLabel?.text = model.name
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(UniversityModel.self)
            .map { URL(string: $0.webPages?.first ?? "")! }
            .map { SFSafariViewController(url: $0) }
            .subscribe(onNext: { [weak self] safariViewController in
                self?.present(safariViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
