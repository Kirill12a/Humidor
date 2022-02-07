//
//  HistoryViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 22.01.2022.
//

import UIKit
import CoreData


//MARK: - Protocol
protocol SigarSegueProtocol: AnyObject
{

  func sigarSegue(array: Sigars)
}


class HistoryViewController: UIViewController
{

  //MARK: - Property
// ===========================
  weak var delegate :   SigarSegueProtocol!
  open var todoCDs  :   [Sigars] = []
  var dataTable     :   UITableView!
// ===========================

  //MARK: - ViewDidLoad
  override func viewDidLoad()
  {

    super.viewDidLoad()
    makeTable()
  }

//MARK: - Вычисляемое свойсвто(labelTips)
  let labelTips: UILabel =
  {

    var label = UILabel()
    label.text  = "Тут будут ваши сигары, которые вы можете выкурить"
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  //MARK:  - ViewWillAppear
  override func viewWillAppear(_ animated: Bool) {

    (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
    getToDos()
  }

//MARK: - CoreData read
  func getToDos()
  {

    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    {
      if let toDosFromCoreData = try? context.fetch(Sigars.fetchRequest())
      {
        if let toDos = toDosFromCoreData as? [Sigars]
        {
          todoCDs = toDos
          dataTable.reloadData()
        }
      }
    }
  }

}

















import SnapKit
import UIKit

//MARK: Настройка View элементов(констрэинты)
extension HistoryViewController
{

  //MARK: - Добавление labelTips
  func makeTipsLabel()
  {

    view.addSubview(labelTips)
    labelTips.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.left.equalToSuperview().inset(20)
      make.right.equalToSuperview().inset(20)
    }
  }

  //MARK: - Создание TableView
  func makeTable()
  {

    dataTable = UITableView.init(frame: CGRect(x: 0, y: 0,
                                width: view.bounds.width,
                                height: view.bounds.height),
                                 style: .grouped)

    dataTable.delegate    =   self
    dataTable.dataSource  =   self
    self.view.addSubview(dataTable)
  }

}










import UIKit
import CoreData

//MARK: - Настройка TableView
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate
{

  //MARK: - CellForRowAt
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {

    let identifier = "identifier"
    var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: identifier)
      dataTable.reloadData()
    }

    // настройка ячейки ----------------------------------------------------
    cell?.detailTextLabel?.text     =     "выкурить"
    cell?.detailTextLabel?.font     =     UIFont .systemFont(ofSize: CGFloat(10))
    cell?.textLabel?.font           =     UIFont(name: "Domine", size: 15)
    // ---------------------------------------------------------------------
    let selectedToDo = todoCDs[indexPath.row]

    if let name = selectedToDo.name, let data = selectedToDo.image
    {

      cell?.textLabel?.text   =   name
      cell?.imageView?.image  =   UIImage(data: data)
    }
    return cell ?? UITableViewCell()
  }

  //MARK: - NumberOfRowsInSection
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {

    if todoCDs.count == 0
    {

      makeTipsLabel()
      labelTips.isHidden = false
      return 0
    }else {

      labelTips.isHidden = true
      return todoCDs.count
    }
  }

  //MARK: - DidSelectRowAt
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {

    let secondVC  =   SmokeOutViewController()
    let texgd     =   todoCDs[indexPath.row]
    delegate      =   secondVC
    delegate.sigarSegue(array: texgd)
    navigationController?.pushViewController(secondVC, animated: true)
  }

}
