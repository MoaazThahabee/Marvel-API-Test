//
//  MasterViewController.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/17/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

class CharactersListViewController: UITableViewController {
    var detailViewController: CharacterDetailsViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
}

