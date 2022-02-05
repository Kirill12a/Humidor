//
//  HistoryViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 22.01.2022.
//

import UIKit
import CoreData


protocol TransferText: AnyObject
{
  func transfertext(textForms: String, shop: String, date: String, image: Data, index: Int)
}


protocol TestSegue: AnyObject {func testSegue(array: Sigars)}


class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

//  weak var delegate: TransferText!

  weak var delegate: TestSegue!

  open var todoCDs: [Sigars] = []



  var dataTable:UITableView!


  override func viewDidLoad()
  {
    super.viewDidLoad()
    view.backgroundColor = .orange
    makeTable()
  }


  func makeTable()
  {
    dataTable=UITableView.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .grouped)
            dataTable.delegate = self
            dataTable.dataSource = self
            self.view.addSubview(dataTable)

  }


  override func viewWillAppear(_ animated: Bool) {
    (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
    getToDos()

  }


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



