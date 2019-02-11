//
//  LottieViewController.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 11/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LottieViewController: UIViewController {

    //MARK :- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK :- Vars
    var viewModel: LottieViewModel?
    
    //MARK :- Init
    convenience required init(withViewModel: LottieViewModel) {
        self.init()
        self.viewModel = withViewModel
    }
    
    
    //MARK :- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    //MARK :- Setup
    func setup() {
        collectionView.register(UINib(nibName: "LottieCell", bundle: nil), forCellWithReuseIdentifier: viewModel!.getCellIdentifier())
        
        collectionView.rx.delegate(self).disposed(by: viewModel!.disposeBag)
        
        viewModel!.content.asObservable().bind(to: collectionView.rx.items(cellIdentifier: viewModel!.getCellIdentifier(), cellType: LottieCell.self)) { row, element, cell in
            cell.setup(withName: element.title)
        }.disposed(by: viewModel!.disposeBag)
    }
}

//extension LottieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel!.content.value.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel!.getCellIdentifier(), for: indexPath) as! LottieCell
//        let element = viewModel!.content.value[indexPath.row]
////        cell.setup(icon: element.icon, animationTitle: element.title)
//        cell.setup(withName: element.title)
//        return cell
//    }
//
//
//}
