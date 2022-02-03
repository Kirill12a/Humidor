//
//  SmokeOutViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 03.02.2022.
//

import SnapKit
import UIKit



class SmokeOutViewController: UIViewController, TransferText {
  func transfertext(textForms: String) {
    label.text = textForms

  }



  lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Нихуя не работает"
        label.font = UIFont(name:"Arial", size: 35)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
