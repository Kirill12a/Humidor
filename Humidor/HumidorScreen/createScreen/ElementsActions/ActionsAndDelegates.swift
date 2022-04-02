//
//  Actions.swift
//  Humidor
//
//  Created by Kirill Drozdov on 07.02.2022.
//

import UIKit
import MaterialComponents


//MARK: - Нажатия
extension CreateUiViewController
{
  //MARK:  Нажатие на image (с Сигарой)
  @objc func btnChooseImageOnClick (tapGestureRecognizer: UITapGestureRecognizer){
    _ = tapGestureRecognizer.view as! UIImageView    // Your action

    let alert = UIAlertController(title: "Выбрать сигару", message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Сфоткать сигару", style: .default, handler: { [self] _ in
      openCamera()
    }))

    alert.addAction(UIAlertAction(title: "Выбрать сигару", style: .default, handler: { [self] _ in
      self.openGallery()
    }))

    alert.addAction(UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil))

    self.present(alert, animated: true, completion: nil)
  }

  //MARK: Сохранение сигары
  @objc func btnSaveSigar ()
  {

    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    {
      let newTodo = Sigars(context: context)

      if let name   =   nameSigarTF.text,
         let place  =   shoppingPlaceTF.text,
         let date   =   yearOfPurchaseTF.text
      {

        newTodo.name    =   name
        newTodo.place   =   place
        newTodo.date    =   date
        newTodo.image   =   sigarImage.image?.jpegData(compressionQuality: 1.0)
      }

      (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    navigationController?.popViewController(animated: true)
  }

}

//MARK: - Дата пикер при касание tf
extension MDCOutlinedTextField //
{
  func setInputViewDatePicker (target: Any, selector: Selector)
  {

    // Создайте объект UIDatePicker и назначьте его для представления ввода
    let screenWidth             =   UIScreen.main.bounds.width
    let datePicker              =   UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
    datePicker.datePickerMode   =   .date //2

    if #available(iOS 14, *)
    {
      datePicker.preferredDatePickerStyle = .wheels
      datePicker.sizeToFit()
    }
    self.inputView = datePicker //3

    // Создайте панель инструментов и назначьте ее inputAccessoryView
    let toolBar     =   UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
    let flexible    =   UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
    let cancel      =   UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
    let barButton   =   UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
    toolBar.setItems([cancel, flexible, barButton], animated: false) //8
    self.inputAccessoryView = toolBar //9
  }

  //MARK: Нажатие сancel
  @objc func tapCancel ()
  {
    self.resignFirstResponder()
  }
}

//MARK: Скрывать клавиатуру
extension CreateUiViewController
{
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
}

//MARK: - Доступ к камере и альбому
extension CreateUiViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate
{
  //MARK: Выбрать "открытие камеры"
  func openCamera ()
  {

    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
      let imagePicker           =   UIImagePickerController()
      imagePicker.delegate      =   self
      imagePicker.sourceType    =   UIImagePickerController.SourceType.camera
      imagePicker.allowsEditing =   false
      self.present(imagePicker, animated: true, completion: nil)
    }
    else
    {

      let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }

  //MARK: Выбрать "открытие галереи"
  func openGallery ()
  {

    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)
    {

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

  //MARK: - Выбор из галереи
  func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
  {
    if let pickedImage = info[.originalImage] as? UIImage
    {

      sigarImage.image = RemoveBackground.removeBAC.removeBackground(image: pickedImage) // кладем фотку в так скажем в наше фото сигары
    }

    picker.dismiss(animated: true, completion: nil)
  }

  // MARK: - Methods for UI configuration.
   func setUpView() {
    self.tabBarController?.tabBar.isHidden = false // скрыть tabBar
  }
}
