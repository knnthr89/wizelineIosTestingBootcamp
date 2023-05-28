//
//  FeedViewController.swift
//  MiniBootcamp
//
//  Created by Fernando de la Rosa on 10/05/23.
//

import UIKit

enum FetchState {
    case loading
    case failure
    case success
}

final class FeedViewController: UIViewController {
    
    private(set) lazy var tableView: UITableView = {
       let tableView =  UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private(set) lazy var loader: UIActivityIndicatorView = {
        UIActivityIndicatorView(frame: view.bounds)
    }()
    
    var viewModel: FeedViewModel = FeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = viewModel.backgroundColor
        setupTableView()
        binding()
        self.viewModel.observer.updateValue(with: .loading)
    }
    
    private func binding() {
        viewModel.observer.bind { [unowned self] state in
            switch state {
            case .loading:
                loader.startAnimating()
                self.view.addSubview(loader)
            case .failure:
                self.loader.removeFromSuperview()
            case .success:
                self.tableView.reloadData()
              self.loader.removeFromSuperview()
            default:
                break
            }
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(TweetCell.self, forCellReuseIdentifier: TweetCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.root?.tweets.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.identifier) as? TweetCell else { return UITableViewCell() }
        
        cell.contentLabel.text = viewModel.root?.tweets[indexPath.row].text
        cell.nameLabel.text = viewModel.root?.tweets[indexPath.row].user.name
        cell.usernameLabel.text = viewModel.root?.tweets[indexPath.row].user.screenName
        cell.userImageView.image = viewModel.root?.tweets[indexPath.row].user.profilePictureName
        
        return cell
    }
}
