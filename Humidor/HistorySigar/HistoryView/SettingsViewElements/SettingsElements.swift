//
//  SettingsElements.swift
//  Humidor
//
//  Created by Kirill Drozdov on 07.02.2022.
//

import UIKit
import SnapKit

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




