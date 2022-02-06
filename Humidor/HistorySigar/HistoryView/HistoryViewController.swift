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

  let labelTips: UILabel = {
    var label = UILabel()
    label.text  = "Тут будут ваши сигары, которые вы можете выкурить"
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  func makeTipsLabel()
  {
    view.addSubview(labelTips)
    labelTips.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.left.equalToSuperview().inset(20)
      make.right.equalToSuperview().inset(20)


    }
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



