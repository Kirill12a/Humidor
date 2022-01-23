//
//  SigarsCollectionViewCell.swift
//  Humidor
//
//  Created by Kirill Drozdov on 23.01.2022.
//

import Foundation
import UIKit
import SnapKit

class SigarsCollectionViewCell: UICollectionViewCell {

    // Character Image
     lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
      imageView.backgroundColor = .purple

        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Character Name Label
     lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
      label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupUI() {
        addSubview(characterImageView)
        addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(-16)
            make.left.equalToSuperview().inset(15)
        }

        characterImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview().inset(20)
          make.bottom.equalToSuperview().inset(30)
        }
    }
}

