//
//  CollectionSettings.swift
//  Humidor
//
//  Created by Kirill Drozdov on 07.02.2022.
//

import UIKit
import SnapKit

//MARK: - Настройка UI экрана
extension MySigarsAddSigarsViewController
{

  func createViewElements()
  {

    //MARK: Кнопка (сигара)
    let addSigar: UIButton =
    {

      let button = UIButton(type: .custom)
      button.setImage(UIImage(named: "addsigar"), for: .normal)
      button.adjustsImageWhenHighlighted = false
      button.addTarget(self, action: #selector(perfomens), for: .touchUpInside)
      return button
    }()

    view.addSubview(addSigar)
    addSigar.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(40)
      make.height.equalTo(200)
      make.left.right.equalToSuperview().offset(5)
    }

    //MARK: Линия
    let line = UIView()
    line.backgroundColor = UIColor.lightGray
    self.view.addSubview(line)

    line.snp.makeConstraints { make in
      make.left.right.equalToSuperview().inset(40)
      make.height.equalTo(1)
      make.top.equalTo(addSigar.snp_bottomMargin).offset(20)
    }
  }

  //MARK: Настройка фотки с пальцем
  func imageTupHiden()
  {

    view.addSubview(imageTup)
    imageTup.snp.makeConstraints { make in
      make.centerY.equalToSuperview().offset(-150)
      make.centerX.equalToSuperview()
    }
  }

}
