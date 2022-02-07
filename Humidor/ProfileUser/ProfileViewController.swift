//
//  ProfileViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 22.01.2022.
//

import UIKit

class ProfileViewController: UIViewController
{

  var todoCDs: [History] = []

  var fds = ["Hello","ValueOne"]
  var tableView: UITableView!
  override func viewDidLoad()
  {
    super.viewDidLoad()
    view.backgroundColor = .gray
    makeTable()
    getToDos()


  }

  var tipLabel: UILabel = {
    var label = UILabel()
    label.text = "Тут будут все ваши выкуренные сигары "
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()


  func createTipsLabel(){
    view.addSubview(tipLabel)
    tipLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }


  func makeTable(){
    tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .grouped)
    tableView?.dataSource = self
    tableView?.delegate = self
    self.view.addSubview(tableView)
  }


  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getToDos()
    title = "\(todoCDs.count) сигары"

  }



  func getToDos()
  {

    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    {
      if let toDosFromCoreData = try? context.fetch(History.fetchRequest())
      {
        if let toDos = toDosFromCoreData as? [History]
        {
          todoCDs = toDos
          tableView!.reloadData()
        }
      }
    }
  }
}
