//
//  ViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 21.01.2022.
//


import UIKit
import SnapKit

class MySigarsAddSigarsViewController: UIViewController
{

  override func viewDidLoad()
  {
    super.viewDidLoad()
    create()
  }

  func create()
  {

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


    let line = UIView(frame: CGRect(x: 0, y: 300, width: 200, height: 1))
    line.backgroundColor = UIColor.lightGray
    self.view.addSubview(line)
  }

  @objc func perfomens()
  {
    print("Hrllo")

  }

}

