//
//  CreateUiViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 26.01.2022.
//

import UIKit
import SnapKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields


typealias tfFirstStyle = MDCOutlinedTextField
class CreateUiViewController: UIViewController
{



  var imagePicker = UIImagePickerController()

    lazy var nameSigarTF: tfFirstStyle =
    {
      let name = tfFirstStyle()
      name.label.text = "Название с банта"
      name.placeholder = "Cohiba"
      name.leadingAssistiveLabel.text = "Веди название сигары "
      name.font = UIFont(name: "Domine", size: 20)
      name.sizeToFit()
      return name
    }()


    lazy var shoppingPlaceTF: tfFirstStyle = {
      let place = tfFirstStyle()
      place.label.text = "Место покупки"
      place.placeholder = "сигары.рф"
      place.leadingAssistiveLabel.text = "Ссылка или магазин"
      place.font = UIFont(name: "Domine", size: 20)
      place.sizeToFit()
      return place
    }()


    lazy var yearOfPurchaseTF: tfFirstStyle = {
      let year = tfFirstStyle()
      year.label.text = "Дата покупки"
      year.placeholder = "30 jan 2020"
      year.leadingAssistiveLabel.text = "Когда вы купили сигару"
      year.font = UIFont(name: "Domine", size: 20)
      year.sizeToFit()
      return year
    }()


    lazy var saveSigarButton: UIButton =
    {
      let button = UIButton(type: .system)
      button.setTitle("Добавить сигару", for: .normal)
      button.addTarget(self, action: #selector(btnSaveSigar), for: .touchUpInside)
      button.titleLabel?.font = UIFont(name: "Domine", size: 20)
      return button
    }()


    lazy var sigarImage: UIImageView =
    {
      var image = UIImageView()
      image.backgroundColor = .white
      image.layer.borderColor = UIColor.gray.cgColor
      image.layer.borderWidth = 3
      image.layer.cornerRadius = 150
      image.layer.masksToBounds = true
      let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(btnChooseImageOnClick(tapGestureRecognizer:)))
      image.isUserInteractionEnabled = true
      image.addGestureRecognizer(tapGestureRecognizer)
      return image
    }()

    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .green
      configuration()
      hideKeyboard()
      yearOfPurchaseTF.setInputViewDatePicker(target: self, selector: #selector(tapDone))
      view.backgroundColor = UIColor(red: 202/255, green: 150/255, blue: 92/255, alpha: 100)

    }

    @objc func tapDone() {
      if let datePicker = self.yearOfPurchaseTF.inputView as? UIDatePicker { // 2-1
        let dateformatter = DateFormatter() // 2-2
        dateformatter.dateStyle = .medium // 2-3
        self.yearOfPurchaseTF.text = dateformatter.string(from: datePicker.date) //2-4
      }
      self.yearOfPurchaseTF.resignFirstResponder() // 2-5
    }


     

  }
