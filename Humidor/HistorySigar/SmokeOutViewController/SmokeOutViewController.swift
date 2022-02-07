//
//  SmokeOutViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 03.02.2022.
//

import SnapKit
import UIKit
import CoreData


//MARK: - Экран выкуривания сигары
class SmokeOutViewController: UIViewController,SigarSegueProtocol, UITextViewDelegate {

  //MARK: - Property
  // ===========================
  var value: Sigars?
  var dateSigar: String?
  // ============================


  //MARK: - ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    hideKeyboard()
    reviewSigar.text = "Вывод:"
  }

  //MARK: - Delegate
  func sigarSegue(array: Sigars)
  {

    // ---------------
    let profileImage  =   UIImage(named:"cigarDefult")!
    let imageData     =   profileImage.pngData()
    // ---------------

    sigarName.text      =     array.name
    sigarImage.image    =     UIImage(data: array.image ?? imageData! )
    dataLabel.text      =     array.date
    placeBuy.text       =     array.place

    //!!!!!!!!!!!!!!!
    value = array
    //!!!!!!!!!!!!!!!
  }


  //MARK: - TextViewDelegate
  var count = 0
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    if count < 1  {
      count += 1
      textView.text = ""
    }
    return true
  }




  func hideKeyboard ()
  {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(dismissKeyboard))

    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }




  @objc func dismissKeyboard ()
  {
    view.endEditing(true)
  }

  //MARK: - Создание UI элементов
  lazy var sigarImage: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "sif")
    image.layer.masksToBounds = true
    image.layer.cornerRadius = 125
    image.layer.borderWidth = 2
    image.layer.borderColor = UIColor(red: 74/255, green: 27/255, blue: 0/255, alpha: 100).cgColor
    return image
  }()

  lazy var sigarName: UILabel = {
    let label = UILabel()
    label.text = "ОПС"
    label.textColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 100)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont(name:"Domine", size: 25)
    return label
  }()

  lazy var dataLabel: UILabel = {
    var label = UILabel()
    label.text = "11.24.February"
    label.font = UIFont.systemFont(ofSize: 13, weight: .light)
    label.textColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 100)
    return label
  }()


  lazy var reviewSigar: UITextView = {
    var review = UITextView()
    review.backgroundColor = .lightGray
    review.layer.cornerRadius = 10
    review.delegate = self
    return review
  }()

  lazy var placeBuy: UILabel = {
    var label = UILabel()
    label.text = "Папирсока"
    label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
    label.textColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 100)

    return label
  }()


  lazy var smokeOutSigar: UIButton = {
    var button = UIButton(type: .custom)
    button.setImage(UIImage(named: "smokeOut"), for: .normal)
    button.addTarget(self, action: #selector(smoking), for: .touchUpInside)
    return button
  }()

  var ide = 0

  @objc func smoking(){
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    if let todo = value {
      context!.delete(todo)
    }
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()


    if let contextSigarHistory = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
      let newHistoryItem = History(context: contextSigarHistory)

      if let nameSigar = sigarName.text, let place = placeBuy.text, let rewiew = reviewSigar.text
      {
        newHistoryItem.name = nameSigar
        newHistoryItem.shop = place
        newHistoryItem.review = rewiew
        newHistoryItem.imageSigar = sigarImage.image?.jpegData(compressionQuality: 1.0)
      }

      newHistoryItem.imageSigar = sigarImage.image?.jpegData(compressionQuality: 1.0)
      (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    navigationController?.popViewController(animated: true)
  }







  


}


