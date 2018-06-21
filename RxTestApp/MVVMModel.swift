//
//  MVVMModel.swift
//  RxTestApp
//
//  Created by HINOMORI HIROYA on 2018/06/19.
//  Copyright © 2018年 HINOMORI HIROYA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MVVMModel {

    private var contentsSubject = BehaviorSubject<[ContentData]>(value: [ContentData]())
    var contents: Observable<[ContentData]> {
        return contentsSubject
    }

    func connectAPI(_ url: URL) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data, _, error) in
            if let err = error {
                self.contentsSubject.onError(err)
            } else if let res = data {
                do {
                    let list = try JSONDecoder().decode([ContentData].self, from: res)
                    var result = [ContentData]()
                    list.forEach({ (content) in
                        if content.novelType != 0 {
                            result.append(content)
                        }
                    })
                    self.contentsSubject.onNext(list)
                } catch {
                    self.contentsSubject.onNext([ContentData]())
                }
            }
        }.resume()
    }

}
