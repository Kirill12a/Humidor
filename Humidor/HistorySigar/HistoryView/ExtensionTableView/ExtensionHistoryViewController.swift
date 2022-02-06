//
//  ExtensionHistoryViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 03.02.2022.
//

import UIKit
import CoreData


extension HistoryViewController
{

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = "identifier"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: identifier)
              dataTable.reloadData()

            }


            cell?.detailTextLabel?.text = "выкурить"
            cell?.detailTextLabel?.font = UIFont .systemFont(ofSize: CGFloat(10))
    cell?.textLabel?.font = UIFont(name: "Domine", size: 15)

    let selectedToDo = todoCDs[indexPath.row]

    if let name = selectedToDo.name
    {
      cell?.textLabel!.text = name
    }

    if let data = selectedToDo.image {
      cell?.imageView?.image = UIImage(data: data)
    }


    return cell ?? UITableViewCell()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if todoCDs.count == 0  {
      makeTipsLabel()
      labelTips.isHidden = false
      return 0
    }else {
      labelTips.isHidden = true
      return todoCDs.count
    }

    

  }


  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let secondVC = SmokeOutViewController()
    let texgd = todoCDs[indexPath.row]
    delegate = secondVC
    delegate.testSegue(array: texgd)
    navigationController?.pushViewController(secondVC, animated: true)
  }

}
