//
//  ViewController.swift
//  RxTestApp
//
//  Created by HINOMORI HIROYA on 2018/06/19.
//  Copyright © 2018年 HINOMORI HIROYA. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MVVMViewController: UIViewController {

    private let apiURL = "https://api.syosetu.com/novelapi/api/?ispickup=1&order=hyoka&lim=50&out=json"
    private let viewModel = MVVMViewModel()
    private let disposebag = DisposeBag()
    @IBOutlet weak private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        viewModel.contents.bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: CollectionViewCell.self)) { (row, data, cell) in
            cell.register(data: data)
        }.disposed(by: disposebag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestAPI(string: apiURL)
    }
    
}
