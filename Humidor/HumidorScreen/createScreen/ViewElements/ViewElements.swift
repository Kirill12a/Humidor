//
//  ViewElements.swift
//  Humidor
//
//  Created by Kirill Drozdov on 07.02.2022.
//

import UIKit
import SnapKit

//MARK: - Настройка констрэинтов на экране создания
extension CreateUiViewController
{
  func configuration ()
  {
    view.addSubview(saveSigarButton)
    saveSigarButton.snp.makeConstraints { make in
      make.topMargin.equalToSuperview().offset(10)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.height.equalTo(50)
      make.width.equalTo(200)
    }

    view.addSubview(nameSigarTF)
    nameSigarTF.snp.makeConstraints { make in
      make.topMargin.equalTo(saveSigarButton.snp_topMargin).offset(60)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(200)
    }

    view.addSubview(shoppingPlaceTF)
    shoppingPlaceTF.snp.makeConstraints { make in
      make.topMargin.equalTo(nameSigarTF.snp_topMargin).offset(90)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(200)
    }

    view.addSubview(yearOfPurchaseTF)
    yearOfPurchaseTF.snp.makeConstraints { make in
      make.topMargin.equalTo(shoppingPlaceTF.snp_topMargin).offset(90)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(200)
    }

    view.addSubview(sigarImage)
    sigarImage.snp.makeConstraints { make in
      make.topMargin.equalTo(yearOfPurchaseTF.snp_topMargin).offset(90)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(300)
    }
  }
}
