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
  //MARK:  - Свойства
  var myCollectionView: UICollectionView?
   var todoCDs: [Sigars] = []

  //MARK: - ViewDidLoad
  override func viewDidLoad()
  {

    super.viewDidLoad()
    createViewElements()
    view.backgroundColor = UIColor(red: 135/255, green: 100/255, blue: 68/255, alpha: 100)

      // layout
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 60, left: 0, bottom: 100, right: 0)
    layout.itemSize = CGSize(width: 300 , height: 300) // размер самой ячейки
    layout.minimumLineSpacing = tabBarController!.tabBar.frame.size.height + 50 // расстояние между ячейками
    // -----

    //MARK: CollectionView настройка
    myCollectionView = UICollectionView(frame: self.view.frame(forAlignmentRect: CGRect(x: 0, y: 255, width: view.bounds.width, height: view.bounds.height / 1.3 - tabBarController!.tabBar.frame.size.height - 60)), collectionViewLayout: layout)// размеры самой коллекции
    myCollectionView?.layer.cornerRadius = 30
    myCollectionView?.register(SigarsCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
    myCollectionView?.backgroundColor = .white
    myCollectionView?.delegate = self
    myCollectionView?.dataSource = self
    self.myCollectionView?.showsVerticalScrollIndicator = false
    view.addSubview(myCollectionView ?? UICollectionView())

  }

  //MARK: - ViewWillAppear
  override func viewWillAppear(_ animated: Bool)
  {

    (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
    getToDos()
  }

  //MARK:  - картинка с пальцем
  let imageTup: UIImageView =
  {

    let imageTup = UIImageView()
    imageTup.image = UIImage(named: "tup")
    return imageTup
  }()

  @objc func perfomens(button: UIButton)
  {

    UIView.animate(withDuration: 0.6,    animations: {
      button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

    },    completion: { _ in
      UIView.animate(withDuration: 0.6) {
        button.transform = CGAffineTransform.identity

        let createVC = CreateUiViewController()
        self.navigationController?.pushViewController(createVC, animated: true)
      }
    })
  }
}


//MARK: - Read the Core Data
extension MySigarsAddSigarsViewController
{

  func getToDos()
  {

    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    {
      if let toDosFromCoreData = try? context.fetch(Sigars.fetchRequest())
      {
        if let toDos = toDosFromCoreData as? [Sigars]
        {
          todoCDs = toDos
          myCollectionView!.reloadData()
        }
      }
    }
  }

}
