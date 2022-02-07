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

//MARK: - Экран с доступными сигарами 
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
























