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

  let model = DeepLabV3()
  let context = CIContext(options: nil)



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
  
  
  private func configuration ()
  {
    
    
    view.addSubview(saveSigarButton)
    saveSigarButton.snp.makeConstraints { make in
      make.topMargin.equalToSuperview().offset(30)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.height.equalTo(100)
      make.width.equalTo(200)
    }
    
    view.addSubview(nameSigarTF)
    nameSigarTF.snp.makeConstraints { make in
      make.topMargin.equalTo(saveSigarButton.snp_topMargin).offset(100)
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
    
    view.addSubview(sigarImage)
    sigarImage.snp.makeConstraints { make in
      make.topMargin.equalTo(yearOfPurchaseTF.snp_topMargin).offset(100)
      make.rightMargin.leftMargin.equalTo(view.bounds.width / 2)
      make.centerX.equalToSuperview()
      make.width.height.equalTo(300)
    }
  }



   func removeBackground(image:UIImage) -> UIImage?{
      let resizedImage = image.resized(to: CGSize(width: 513, height: 513))
      if let pixelBuffer = resizedImage.pixelBuffer(width: Int(resizedImage.size.width), height: Int(resizedImage.size.height)){
          if let outputImage = (try? model.prediction(image: pixelBuffer))?.semanticPredictions.image(min: 0, max: 1, axes: (0,0,1)), let outputCIImage = CIImage(image:outputImage){
              if let maskImage = removeWhitePixels(image:outputCIImage), let resizedCIImage = CIImage(image: resizedImage), let compositedImage = composite(image: resizedCIImage, mask: maskImage){
                  return UIImage(ciImage: compositedImage).resized(to: CGSize(width: image.size.width, height: image.size.height))
              }
          }
      }
      return nil
  }


  private func removeWhitePixels(image:CIImage) -> CIImage?{
      let chromaCIFilter = chromaKeyFilter()
      chromaCIFilter?.setValue(image, forKey: kCIInputImageKey)
      return chromaCIFilter?.outputImage
  }

  private func composite(image:CIImage,mask:CIImage) -> CIImage?{
      return CIFilter(name:"CISourceOutCompositing",parameters:
          [kCIInputImageKey: image,kCIInputBackgroundImageKey: mask])?.outputImage
  }


  private func chromaKeyFilter() -> CIFilter? {
      let size = 64
      var cubeRGB = [Float]()

      for z in 0 ..< size {
          let blue = CGFloat(z) / CGFloat(size-1)
          for y in 0 ..< size {
              let green = CGFloat(y) / CGFloat(size-1)
              for x in 0 ..< size {
                  let red = CGFloat(x) / CGFloat(size-1)
                  let brightness = getBrightness(red: red, green: green, blue: blue)
                  let alpha: CGFloat = brightness == 1 ? 0 : 1
                  cubeRGB.append(Float(red * alpha))
                  cubeRGB.append(Float(green * alpha))
                  cubeRGB.append(Float(blue * alpha))
                  cubeRGB.append(Float(alpha))
              }
          }
      }

      let data = Data(buffer: UnsafeBufferPointer(start: &cubeRGB, count: cubeRGB.count))

      let colorCubeFilter = CIFilter(name: "CIColorCube", parameters: ["inputCubeDimension": size, "inputCubeData": data])
      return colorCubeFilter
  }


  private func getBrightness(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGFloat {
      let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
      var brightness: CGFloat = 0
      color.getHue(nil, saturation: nil, brightness: &brightness, alpha: nil)
      return brightness
  }

  
}









