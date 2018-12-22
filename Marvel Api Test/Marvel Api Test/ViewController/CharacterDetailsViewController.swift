//
//  DetailViewController.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/17/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var workItemsTableView: UITableView!
    
    private let workItemsListTableViewCellIdentifier = "WorkItemsListTableViewCell"
    
    var characterIndex: Int?
    private let maxItemToPresent = 3
    var character: Character? {
        get {
            if let characterIndex = characterIndex {
                return DataManager.shared.characters[characterIndex]
            }
            
            return nil
        }
    }
    
    var comics: [Comic] = []
    var stories: [Story] = []
    var series: [Series] = []
    var events: [Event] = []
    var grouppedWorkItems: [String: [WorkItem]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.workItemsTableView.refreshControl = UIRefreshControl()
        
        self.workItemsTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        self.navigationItem.title = "(\(character!.id!))\(character!.name!)"
        
        self.workItemsTableView.register(UINib(nibName: workItemsListTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: workItemsListTableViewCellIdentifier)
        
        self.refreshData()
    }
    
    @objc func refreshData() {
        self.loadData()
        self.workItemsTableView.refreshControl?.endRefreshing()
    }
    
    func loadData() {
        guard let character = self.character, let characterId = self.character?.id else {
            return
        }
        
        if !(character.comics?.isEmpty ?? true) {
            self.grouppedWorkItems["Commics:"] = []
            APIManager.shared.comics(characterId: characterId, offset: 0, limit: maxItemToPresent, success: { (data) in
                self.grouppedWorkItems["Commics:"] = data.data ?? []
                self.workItemsTableView.reloadData()
            }) { (message) in
                AlertManager.shared.showAlertDialog(title: NSLocalizedString("ConnectionProblem", comment: ""), message: message, buttonTitle: NSLocalizedString("Ok", comment: ""), completitionHandler: {
                    
                })
            }
        }
        
        if !(character.events?.isEmpty ?? true) {
            self.grouppedWorkItems["Events:"] = []
            APIManager.shared.events(characterId: characterId, offset: 0, limit: maxItemToPresent, success: { (data) in
                self.grouppedWorkItems["Events:"] = data.data ?? []
                self.workItemsTableView.reloadData()
            }) { (message) in
                AlertManager.shared.showAlertDialog(title: NSLocalizedString("ConnectionProblem", comment: ""), message: message, buttonTitle: NSLocalizedString("Ok", comment: ""), completitionHandler: {
                    
                })
            }
        }
        
        if !(character.series?.isEmpty ?? true) {
            self.grouppedWorkItems["Series:"] = []
            APIManager.shared.series(characterId: characterId, offset: 0, limit: maxItemToPresent, success: { (data) in
                self.grouppedWorkItems["Series:"] = data.data ?? []
                self.workItemsTableView.reloadData()
            }) { (message) in
                AlertManager.shared.showAlertDialog(title: NSLocalizedString("ConnectionProblem", comment: ""), message: message, buttonTitle: NSLocalizedString("Ok", comment: ""), completitionHandler: {
                    
                })
            }
        }
        
        if !(character.stories?.isEmpty ?? true) {
            self.grouppedWorkItems["Stories:"] = []
            APIManager.shared.stories(characterId: characterId, offset: 0, limit: maxItemToPresent, success: { (data) in
                self.grouppedWorkItems["Stories:"] = data.data ?? []
                self.workItemsTableView.reloadData()
            }) { (message) in
                AlertManager.shared.showAlertDialog(title: NSLocalizedString("ConnectionProblem", comment: ""), message: message, buttonTitle: NSLocalizedString("Ok", comment: ""), completitionHandler: {
                    
                })
            }
        }
    }
}

extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.grouppedWorkItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(self.grouppedWorkItems)[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: workItemsListTableViewCellIdentifier) as! WorkItemsListTableViewCell
        
        let workItem = Array(self.grouppedWorkItems)[indexPath.section].1[indexPath.row]
        
        cell.nameLabel.text = workItem.title
        cell.iconImageView.kf.indicatorType = .activity
        
        cell.iconImageView.kf.setImage(with: URL(string: workItem.thumbnail?.imagePath ?? ""), placeholder: UIImage(named: "logo"), options: nil, progressBlock: nil) { (result) in
            
        }
        
        cell.selectionStyle = .none
        
        cell.iconImageView.layer.cornerRadius = cell.iconImageView.frame.size.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(self.grouppedWorkItems)[section].0
    }
}

