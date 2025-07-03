//
//  FavoritesListViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 10/06/25.
//

import UIKit

class FavoritesListViewController: GFDataLoadingViewController {
    private var favorites: [Follower] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 80
        table.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        buildViewHierarchy()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFavorites()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if favorites.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            
            config.image = .init(systemName: "star")
            config.text = "No favorites yet"
            config.secondaryText = "Add a favorite on the followers list by tapping the plus icon"
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
    
    private func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setup() {
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] favorites in
            guard let self else { return }
            
            switch favorites {
            case .success(let favorites):
                self.favorites = favorites
                setNeedsUpdateContentUnavailableConfiguration()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGFAlert(title: "Something went wrong", message: error.rawValue)
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        
        cell.setup(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let followerListViewController = FollowerListViewController(username: favorite.login)
        
        navigationController?.pushViewController(followerListViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self else { return }
            guard let error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                setNeedsUpdateContentUnavailableConfiguration()
                return
            }
            
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Unable to remove favorite", message: error.rawValue)
            }
        }
    }
}
