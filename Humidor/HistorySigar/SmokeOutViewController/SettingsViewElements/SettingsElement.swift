//
//  SettingsElement.swift
//  Humidor
//
//  Created by Kirill Drozdov on 07.02.2022.
//

import UIKit
import SnapKit

//MARK:  - Настройка UI элементов
extension SmokeOutViewController
{
  func setUpView()
  {

    view.backgroundColor = .white

    view.addSubview(sigarImage)
    sigarImage.snp.makeConstraints { make in
      make.topMargin.equalToSuperview().inset(8)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(250)
    }

    view.addSubview(sigarName)
    sigarName.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalTo(sigarImage.snp_bottomMargin).offset(30)
      make.width.equalTo(view.bounds.width - 25)
      make.height.equalTo(40)
    }

    view.addSubview(dataLabel)
    dataLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalTo(sigarName.snp_bottomMargin).offset(15)
    }

    view.addSubview(placeBuy)
    placeBuy.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalTo(dataLabel.snp_bottomMargin).offset(20)
    }

    view.addSubview(reviewSigar)
    reviewSigar.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalTo(placeBuy.snp_bottomMargin).offset(40)
      make.height.equalTo(50)
      make.width.equalTo(200)
    }

    view.addSubview(smokeOutSigar)
    smokeOutSigar.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalTo(reviewSigar.snp_bottomMargin).offset(100)
      make.width.height.equalTo(100)
    }
  }

}
