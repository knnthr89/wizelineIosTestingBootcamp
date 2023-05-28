//
//  FeedViewModel.swift
//  MiniBootcamp
//
//  Created by Josué Quiñones Rivera on 17/05/23.
//

import UIKit

class FeedViewModel {
    let title: String
    var backgroundColor: UIColor? = .white
    var root : Root?
    
let networkManager = NetworkManager()
    
    let observer: Observer<FetchState> = Observer<FetchState>()
    
    init(title: String = "TweetFeed") {
        self.title = title
        self.requestDataTable()
    }
    
    func requestDataTable() {
        if let feedsUrl = URL(string: FeedsUrl.url.rawValue) {
            networkManager.getFeeds(url : feedsUrl) { [weak self] result in
                switch result {
                    case .success(let root):
                        DispatchQueue.main.async {
                           self?.root = root
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                self?.observer.updateValue(with: .success)
                            }
                        }
                case .failure(_):
                    self?.observer.updateValue(with: .failure)
                }
            }
        }
    }
}
