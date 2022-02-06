//
//  ProfileViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 22.01.2022.
//

import UIKit

class ProfileViewController: UIViewController
{

  var fds = ["Hello","ValueOne"]
  var tableView: UITableView!
  override func viewDidLoad()
  {
    super.viewDidLoad()
    view.backgroundColor = .gray
    makeTable()
    title = "\(fds.count) сигары"
    

  }


  func makeTable(){
    tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .grouped)
    tableView?.dataSource = self
    tableView?.delegate = self
    self.view.addSubview(tableView)
  }
}
