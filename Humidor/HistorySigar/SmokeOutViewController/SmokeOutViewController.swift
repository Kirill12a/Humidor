//
//  SmokeOutViewController.swift
//  Humidor
//
//  Created by Kirill Drozdov on 03.02.2022.
//

import SnapKit
import UIKit



class SmokeOutViewController: UIViewController, TransferText, UITextViewDelegate {
  func transfertext(textForms: String) {
    sigarName.text = textForms

  }


  //MARK: Delegate

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


  lazy var image: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "sif")
    image.backgroundColor = .red // удалить потом
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


  @objc func smoking(){
    print("Hello")
  }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
      hideKeyboard()
      reviewSigar.text = "Вывод:"




      //MARK:  - Подсчет времени, которое сигара пролежала у меня
      let startDate = "2022-02-1"
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"
      let formatedStartDate = dateFormatter.date(from: startDate)
      let currentDate = Date()
      let components = Set<Calendar.Component>([ .day, .month, .year])
      let differenceOfDate = Calendar.current.dateComponents(components, from: formatedStartDate!, to: currentDate)
      print (differenceOfDate)
    }





    private func setUpView() {
      view.backgroundColor = .white


      view.addSubview(image)
      image.snp.makeConstraints { make in
        make.topMargin.equalToSuperview().inset(8) // это если шо
//        make.top.equalToSuperview().offset(45)
        make.centerX.equalToSuperview()
        make.width.height.equalTo(250)
      }


        view.addSubview(sigarName)
        sigarName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
//          make.centerY.equalToSuperview().offset(image.snp_topMargin + 30) // --- так тоже вроде норм, НО ХЗ
          make.centerY.equalTo(image.snp_bottomMargin).offset(30)
          make.width.equalTo(view.bounds.width - 25)
          make.height.equalTo(40)
        }


      view.addSubview(dataLabel)
      dataLabel.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.centerY.equalTo(sigarName.snp_bottomMargin).offset(15)
      }

      view.addSubview(placeBuy)
      placeBuy.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.centerY.equalTo(dataLabel.snp_bottomMargin).offset(20)

      }

      view.addSubview(reviewSigar)
      reviewSigar.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.centerY.equalTo(placeBuy.snp_bottomMargin).offset(40)
        make.height.equalTo(50)
        make.width.equalTo(200)
      }

      view.addSubview(smokeOutSigar)
      smokeOutSigar.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.centerY.equalTo(reviewSigar.snp_bottomMargin).offset(100)
        make.width.height.equalTo(100)
      }







    }


}















