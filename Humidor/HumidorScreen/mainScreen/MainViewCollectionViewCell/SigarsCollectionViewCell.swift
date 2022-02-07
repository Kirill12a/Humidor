//
//  SigarsCollectionViewCell.swift
//  Humidor
//
//  Created by Kirill Drozdov on 23.01.2022.
//


import Foundation
import UIKit
import SnapKit

//MARK: - Ячейка
class SigarsCollectionViewCell: UICollectionViewCell
{

  // Character Image
  lazy var characterImageView: UIImageView =
  {

    let imageView = UIImageView()
    imageView.layer.cornerRadius = 150
    imageView.layer.borderWidth = 2
    imageView.layer.borderColor = UIColor(red: 74/255, green: 27/255, blue: 0/255, alpha: 100).cgColor

    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  // Character Name Label
  lazy var nameLabel: UILabel =
  {

    let label = UILabel()
    label.textColor = .label
    label.font = UIFont(name: "Domine", size: 26)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 100)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  //MARK: init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}






import UIKit
import SnapKit

//MARK: - Настройка UI ячейки
extension SigarsCollectionViewCell
{
  //MARK: Cell elements
  func setupUI()
  {
    addSubview(characterImageView)
    addSubview(nameLabel)

    nameLabel.snp.makeConstraints { make in
      make.width.equalTo(contentView.bounds.width)
      make.centerX.equalToSuperview()
      make.centerY.equalTo(contentView.bounds.height + 48)
    }

    characterImageView.snp.makeConstraints { make in
      make.width.height.equalTo(300)
      make.center.equalToSuperview()

    }
  }
}

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
