//
//  MVVMViewModel.swift
//  RxTestApp
//
//  Created by HINOMORI HIROYA on 2018/06/19.
//  Copyright © 2018年 HINOMORI HIROYA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MVVMViewModel {

    private let model: MVVMModel
    private let disposebag: DisposeBag
    private let contentsSubject: BehaviorSubject<[ContentData]>
    var contents: Observable<[ContentData]> {
        return contentsSubject
    }

    init() {
        model = MVVMModel()
        disposebag = DisposeBag()
        contentsSubject = BehaviorSubject<[ContentData]>(value: [ContentData]())
        model.contents.subscribe(onNext: { (list) in
            let filterList = list.filter({ (data) -> Bool in
                if data.novelType == 0 {
                    return false
                }
                return true
            })
            self.contentsSubject.onNext(filterList)
        }, onError: { (error) in
            self.contentsSubject.onError(error)
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposebag)
    }

    func requestAPI(string: String) {
        guard let url = URL(string: string) else { return }
        model.connectAPI(url)
    }

}
