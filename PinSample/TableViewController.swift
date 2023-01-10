//
//  TableViewController.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/07.
//  Copyright © 2023 Udacity. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNavBarItem: UIBarButtonItem!
    @IBOutlet weak var refreshNavBarItem: UIBarButtonItem!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    // MARK: Helper Methods
   private func onDataRefresh(inProgress: Bool) {
        refreshNavBarItem.isEnabled = !inProgress
        addNavBarItem.isEnabled = !inProgress
        
        inProgress ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
    }
    
    private func loadData() {
        onDataRefresh(inProgress: true)

        OnTheMapClient.getStudentLocations { (success, error) in
            self.onDataRefresh(inProgress: false)
            if success {
                self.tableView.reloadData()
            } else {
                self.showErrorAlert(message: error?.localizedDescription ?? "Unable to refresh")
            }
        }
    }
    
    // MARK: Button Actions
    @IBAction func logout(_ sender: UIBarButtonItem) {
        OnTheMapClient.logout { (success, error) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func onRefresh(_ sender: UIBarButtonItem) {
        loadData()
    }
    
    
}

