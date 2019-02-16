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

protocol LottieViewControllerDelegate: class {
    func didTapAnimation(at index: Int)
}

class LottieViewController: UIViewController {

    //MARK :- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK :- Vars
    var viewModel: LottieViewModel?
    weak var delegate: LottieViewControllerDelegate?
    
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
        collectionView.registerNib(named: viewModel!.getCellIdentifier())
        collectionView.rx.setDelegate(self).disposed(by: viewModel!.disposeBag)
        
        viewModel!.content.asObservable().bind(to: collectionView.rx.items(cellIdentifier: viewModel!.getCellIdentifier(), cellType: LottieCell.self)) { indexPath, element, cell in
            cell.setup(withName: element.title, withIcon: element.icon)
        }.disposed(by: viewModel!.disposeBag)
        
        collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            self.delegate?.didTapAnimation(at: indexPath.row)
        }).disposed(by: viewModel!.disposeBag)
    }
}

extension LottieViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 16.0) / 2.0
        return CGSize(width: width, height: 200.0)
    }
}
