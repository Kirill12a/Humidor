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
  private var myCollectionView: UICollectionView?

  // пока не будет бд
  var  im = ["sif", "sif", "sif"]  // это фотки
  var tx =  ["Montecristo 1935 Anniversary Nicaragua No. 2", "Padrón 1964 Anniversary Series Torpedo (Natural)", "Montecristo 1935 Anniversary Nicaragua No. 2"] // это текст

  override func viewDidLoad()
  {
    super.viewDidLoad()
    create()


    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 60, left: 0, bottom: 60, right: 0)
    layout.itemSize = CGSize(width: 300 , height: 300) // размер самой ячейки
//    layout.minimumInteritemSpacing = 40
    layout.minimumLineSpacing = tabBarController!.tabBar.frame.size.height + 50 // расстояние между ячейками

    myCollectionView = UICollectionView(frame: self.view.frame(forAlignmentRect: CGRect(x: 0, y: view.center.y, width: view.bounds.width, height: view.bounds.height / 2 - tabBarController!.tabBar.frame.size.height)), collectionViewLayout: layout)// размеры самой коллекции
    myCollectionView?.register(SigarsCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
    //    myCollectionView?.backgroundColor = UIColor.white
    myCollectionView?.backgroundColor = .white
    myCollectionView?.dataSource = self
    view.addSubview(myCollectionView ?? UICollectionView())

  }


  override func viewWillAppear(_ animated: Bool) {
      (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
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

    let line = UIView()
    line.backgroundColor = UIColor.lightGray
    self.view.addSubview(line)

    line.snp.makeConstraints { make in
      make.left.right.equalToSuperview().inset(40)
      make.height.equalTo(1)
      make.top.equalTo(addSigar.snp_bottomMargin).offset(20)
    }
  }

  @objc func perfomens()
  {
    print("Hrllo")

  }
}

extension MySigarsAddSigarsViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return im.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! SigarsCollectionViewCell
            myCell.backgroundColor = UIColor.blue // это ячейка
    myCell.layer.cornerRadius = myCell.bounds.height / 2
    myCell.characterImageView.image =  UIImage(named: im[indexPath.row])
    myCell.nameLabel.text = tx[indexPath.row]
    return myCell
  }
}
extension MySigarsAddSigarsViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("User tapped on item \(indexPath.row)")
  }
}