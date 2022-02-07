//
//  SettingsCV.swift
//  Humidor
//
//  Created by Kirill Drozdov on 07.02.2022.
//

import UIKit

//MARK: - dataSource у collectionView
extension MySigarsAddSigarsViewController: UICollectionViewDataSource
{

  //MARK:  - NumberOfItemsInSection
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if todoCDs.count == 0{

      collectionView.backgroundColor      =   UIColor(red: 135/255, green: 100/255, blue: 68/255, alpha: 100)
      myCollectionView?.backgroundColor   =   UIColor(red: 135/255, green: 100/255, blue: 68/255, alpha: 100)
      imageTup.isHidden                   =   false
      imageTupHiden()
      return 0

    }else{

      collectionView.backgroundColor      =   .white
      myCollectionView?.backgroundColor   =   .white
      imageTup.isHidden                   =   true
      return todoCDs.count
    }
  }

  //MARK: - CellForItemAt
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {

    let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! SigarsCollectionViewCell
    myCell.layer.cornerRadius   =   myCell.bounds.height / 2
    let selectedToDo            =   todoCDs[indexPath.row]

    if let name = selectedToDo.name, let data = selectedToDo.image
    {

      myCell.nameLabel.text             =   name
      myCell.characterImageView.image   =   UIImage(data: data)
    }
    return myCell
  }

}

//MARK:  -  delegate у collectionView
extension MySigarsAddSigarsViewController: UICollectionViewDelegate
{

  //MARK: - DidSelectItemAt
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
  {

    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    {

      let selectedToDo = todoCDs[indexPath.row]
      context.delete(selectedToDo)
      (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
      getToDos()
    }
  }
}
