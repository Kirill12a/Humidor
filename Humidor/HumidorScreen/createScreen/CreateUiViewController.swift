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
    place.placeholder = "555-555-5555"
    place.leadingAssistiveLabel.text = "Ссылка или магазин"
    place.font = UIFont(name: "Domine", size: 20)

    place.sizeToFit()
    return place
  }()


  lazy var yearOfPurchaseTF: tfFirstStyle = {
    let year = tfFirstStyle()
    year.label.text = "Phone number"
    year.placeholder = "555-555-5555"
    year.leadingAssistiveLabel.text = "This is helper text"
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
    
  }

  @objc func tapDone() {
          if let datePicker = self.yearOfPurchaseTF.inputView as? UIDatePicker { // 2-1
              let dateformatter = DateFormatter() // 2-2
              dateformatter.dateStyle = .medium // 2-3
              self.yearOfPurchaseTF.text = dateformatter.string(from: datePicker.date) //2-4
          }
          self.yearOfPurchaseTF.resignFirstResponder() // 2-5
      }


  private func configuration ()
  {

    view.addSubview(nameSigarTF)
    nameSigarTF.snp.makeConstraints { make in
      make.topMargin.equalToSuperview().offset(100)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(200)
    }

    view.addSubview(shoppingPlaceTF)
    shoppingPlaceTF.snp.makeConstraints { make in
      make.topMargin.equalTo(nameSigarTF.snp_topMargin).offset(100)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(200)
    }

    view.addSubview(yearOfPurchaseTF)
    yearOfPurchaseTF.snp.makeConstraints { make in
      make.topMargin.equalTo(shoppingPlaceTF.snp_topMargin).offset(100)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(200)
    }

    view.addSubview(saveSigarButton)
    saveSigarButton.snp.makeConstraints { make in
      make.topMargin.equalTo(yearOfPurchaseTF.snp_topMargin).offset(100)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.height.equalTo(100)
      make.width.equalTo(200)
    }


    view.addSubview(sigarImage)
    sigarImage.snp.makeConstraints { make in
      make.topMargin.equalTo(saveSigarButton.snp_topMargin).offset(100)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(300)
    }

  }

}


extension CreateUiViewController // Нажатие
{
  @objc func btnChooseImageOnClick(tapGestureRecognizer: UITapGestureRecognizer){
    let tappedImage = tapGestureRecognizer.view as! UIImageView    // Your action
print("HI BABY")

    let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [self] _ in
               openCamera()
           }))

           alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { [self] _ in
               self.openGallery()
           }))

           alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

           self.present(alert, animated: true, completion: nil)
  }





  @objc func btnSaveSigar()
  {
    print("save")
  }
}



extension CreateUiViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate // Доступ к камере и альбому
{

  //MARK: Камера
  func openCamera()
  {
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
          let imagePicker = UIImagePickerController()
          imagePicker.delegate = self
          imagePicker.sourceType = UIImagePickerController.SourceType.camera
          imagePicker.allowsEditing = false
          self.present(imagePicker, animated: true, completion: nil)
      }
      else
      {
          let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
      }
  }




  //MARK: Галерея
  func openGallery()
  {
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
          let imagePicker = UIImagePickerController()
          imagePicker.delegate = self
          imagePicker.allowsEditing = true
          imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
          self.present(imagePicker, animated: true, completion: nil)
      }
      else
      {
          let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
      }
  }

//MARK: Выбор из галереи
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let pickedImage = info[.originalImage] as? UIImage {
          // sigarImage.contentMode = .scaleToFill
        sigarImage.image = pickedImage
      }
      picker.dismiss(animated: true, completion: nil)
  }
}



extension CreateUiViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}


extension MDCOutlinedTextField
{
  func setInputViewDatePicker(target: Any, selector: Selector) {
          // Create a UIDatePicker object and assign to inputView
          let screenWidth = UIScreen.main.bounds.width
          let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
          datePicker.datePickerMode = .date //2
          // iOS 14 and above
          if #available(iOS 14, *) {// Added condition for iOS 14
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
          }
          self.inputView = datePicker //3

          // Create a toolbar and assign it to inputAccessoryView
          let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
          let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
          let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
          let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
          toolBar.setItems([cancel, flexible, barButton], animated: false) //8
          self.inputAccessoryView = toolBar //9
      }

      @objc func tapCancel() {
          self.resignFirstResponder()
      }
}
