//
//  TableView+Ext.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/09.
//  Copyright © 2023 Udacity. All rights reserved.
//

import Foundation
import UIKit

extension TableViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell")!
        cell.textLabel?.text = AppData.studentLocations[indexPath.row].fullName
        cell.detailTextLabel?.text = AppData.studentLocations[indexPath.row].mediaURL
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: AppData.studentLocations[indexPath.row].mediaURL) {
            openUrl(url: url)
        } else {
            showErrorAlert(message: "No valid URL found")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

