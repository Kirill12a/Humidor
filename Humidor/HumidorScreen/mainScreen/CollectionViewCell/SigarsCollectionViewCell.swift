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

