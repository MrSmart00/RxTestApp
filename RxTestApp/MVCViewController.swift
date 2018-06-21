//
//  MVCViewController.swift
//  RxTestApp
//
//  Created by HINOMORI HIROYA on 2018/06/21.
//  Copyright © 2018年 HINOMORI HIROYA. All rights reserved.
//

import UIKit

class MVCViewController: UIViewController {

    @IBOutlet weak private var collectionView: UICollectionView!
    private let apiURL = "https://api.syosetu.com/novelapi/api/?ispickup=1&order=hyoka&lim=50&out=json"
    private(set) var contents = [ContentData]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        connectAPI()
    }
    
    func connectAPI() {
        guard let url = URL(string: apiURL) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { [weak self] (data, _, error) in
            if let weakSelf = self {
                guard error == nil else {
                    return
                }
                if let json = data {
                    do {
                        let list = try JSONDecoder().decode([ContentData].self, from: json)
                        var result = [ContentData]()
                        list.forEach({ (content) in
                            if content.novelType != 0 {
                                result.append(content)
                            }
                        })
                        weakSelf.contents = result
                    } catch {
                    }
                }
            }
        }.resume()
    }

}

extension MVCViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let contentCell = cell as? CollectionViewCell {
            contentCell.register(data: contents[indexPath.row])
        }
        return cell
    }
    
}

