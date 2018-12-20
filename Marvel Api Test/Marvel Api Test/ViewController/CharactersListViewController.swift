//
//  MasterViewController.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/17/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import Kingfisher
class CharactersListViewController: UITableViewController {
    var detailViewController: CharacterDetailsViewController? = nil
    
    private let charactersListTableViewCellIdentifier = "CharactersListTableViewCell"
    private let showCharacterDetailsSegueIdentifier = "ShowCharacterDetailsSegue"
    
    private let loadingActivity = UIActivityIndicatorView(style: .gray)
    
    let dataManager = DataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.tableView.register(UINib(nibName: charactersListTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: charactersListTableViewCellIdentifier)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 60
        self.tableView.tableFooterView = loadingActivity
        
        self.loadData()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? CharacterDetailsViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showCharacterDetailsSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! CharacterDetailsViewController
                controller.characterIndex = indexPath.row
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    @objc func refreshData() {
        dataManager.characters = []
        self.loadData()
        self.refreshControl?.endRefreshing()
    }
    
    func loadData() {
        APIManager.shared.characters(offset: dataManager.characters.count, limit: 20, success: { (data) in
            self.loadingActivity.stopAnimating()
            self.dataManager.characters.append(contentsOf: data.data ?? [])
            self.tableView.reloadData()
        }) { (message) in
            self.loadingActivity.stopAnimating()
            AlertManager.shared.showAlertDialog(title: NSLocalizedString("ConnectionProblem", comment: ""), message: message, buttonTitle: NSLocalizedString("Ok", comment: ""), completitionHandler: {
                
            })
        }
    }
}

extension CharactersListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: charactersListTableViewCellIdentifier) as!CharactersListTableViewCell
        let character = DataManager.shared.characters[indexPath.row]
        
        cell.nameLabel.text = character.name
        cell.iconImageView.kf.indicatorType = .activity
        cell.iconImageView.kf.setImage(with: URL(string: character.thumbnail?.imagePath ?? ""))
        cell.selectionStyle = .none
        
        if indexPath.row == dataManager.characters.count - 5 {
            self.loadingActivity.startAnimating()
            self.loadData()
        }
        
        cell.iconImageView.layer.cornerRadius = cell.iconImageView.frame.size.height / 2
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: showCharacterDetailsSegueIdentifier, sender: self)
    }
}
