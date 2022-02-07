//
//  TableViewProfileViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 06.02.2022.
//

import Foundation
import UIKit

//MARK: - Настройка таблицы
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate
{

  //MARK:  - NumberOfRowsInSection
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {

    if todoCDs.count == 0
    {

      createTipsLabel()
      tipLabel.isEnabled = false
      return 0
    }else{

      tipLabel.isHidden = true
      return todoCDs.count
    }
  }

  //MARK:  - CellForRowAt
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {

    let identifire = "identifier"
    var cell = tableView.dequeueReusableCell(withIdentifier: identifire)
    cell?.selectionStyle = .none
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: identifire)
      tableView.reloadData()
    }

    let selectedSigar = todoCDs[indexPath.row]
    if let name = selectedSigar.name, let data = selectedSigar.imageSigar
    {
      cell?.textLabel?.text   =   name
      cell?.imageView?.image  =   UIImage(data: data)
    }
    return cell!
  }

  //MARK:  - EditingStyle
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete
    {

      let alert = UIAlertController(title: "Удалить сигарку ", message: "Удалить сигару из приложения?", preferredStyle: .actionSheet)
      alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { _ in
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        {

          let selectedToDo = self.todoCDs[indexPath.row]
          context.delete(selectedToDo)
          (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
          self.getToDos()
        }
      }))

      alert.addAction(UIAlertAction(title: "Оставить", style: .cancel, handler: nil))

      present(alert, animated: true, completion: nil)
    }
  }

  //MARK: - DidSelectRowAt
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {

    let alert = UIAlertController(title: todoCDs[indexPath.row].review, message: "Магазин: \(todoCDs[indexPath.row].shop ?? String())", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Отлично", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}
