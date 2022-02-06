//
//  TableViewProfileViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 06.02.2022.
//

import Foundation
import UIKit


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fds.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifire = "identifier"
    var cell = tableView.dequeueReusableCell(withIdentifier: identifire)
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: identifire)
      tableView.reloadData()
    }

      cell?.textLabel?.text = fds[indexPath.row]
      cell?.detailTextLabel?.text = fds[indexPath.row]
    cell?.imageView?.image = UIImage(named: "logo")


    return cell!
  }

  


}
