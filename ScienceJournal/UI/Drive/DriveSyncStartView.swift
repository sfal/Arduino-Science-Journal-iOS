//  
//  DriveSyncStartView.swift
//  ScienceJournal
//
//  Copyright © 2021 Arduino. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import UIKit

class DriveSyncStartView: UIStackView {

  let onAction: () -> Void
  
  var isChecked: Bool = false {
    didSet {
      refreshCheckBox()
    }
  }

  lazy var folderView: UIView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 8
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    stackView.layer.borderWidth = 1
    stackView.layer.borderColor = ArduinoColorPalette.grayPalette.tint500?.cgColor
    stackView.layer.cornerRadius = 5
    stackView.heightAnchor.constraint(equalToConstant: 42).isActive = true
    
    let folderImage = UIImageView(image: UIImage(named: "google_drive_folder"))
    folderImage.setContentCompressionResistancePriority(.required, for: .horizontal)
    folderImage.tintColor = ArduinoColorPalette.grayPalette.tint500
    
    stackView.addArrangedSubview(folderImage)
    stackView.addArrangedSubview(folderLabel)
    
    return stackView
  }()
  
  let confirmButton = WizardButton(title: String.driveSyncStartButton.uppercased(), style: .solid)

  let notice: UILabel = {
    let label = UILabel()
    label.textColor = ArduinoColorPalette.grayPalette.tint500
    label.font = ArduinoTypography.regularFont(forSize: ArduinoTypography.FontSize.XSmall.rawValue)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  private let folderLabel: UILabel = {
    let label = UILabel()
    label.textColor = ArduinoColorPalette.grayPalette.tint400
    label.font = ArduinoTypography.regularFont(forSize: ArduinoTypography.FontSize.Small.rawValue)
    return label
  }()

  lazy var checkBoxView: UIView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .top
    stackView.spacing = 8
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    // checkBoxImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
    // textView.setContentCompressionResistancePriority(.required, for: .horizontal)
    checkBoxImageView.setContentHuggingPriority(.required, for: .horizontal)

    stackView.addArrangedSubview(checkBoxImageView)
    stackView.addArrangedSubview(textView)

    // checkBoxImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
    return stackView
  }()

  private let checkBoxImageView = UIImageView(image: UIImage(named: "sign_in_checkbox"))
  private let textView: UITextView = {
    let textView = UITextView()
    textView.textContainer.lineFragmentPadding = 0
    textView.textContainerInset = .zero
    textView.isScrollEnabled = false
    textView.scrollsToTop = false
    textView.isSelectable = true
    textView.isEditable = false
    textView.delaysContentTouches = false
    textView.dataDetectorTypes = [.link]
    textView.font = ArduinoTypography.labelFont
    textView.textColor = .black
    textView.backgroundColor = .clear
    textView.linkTextAttributes = [
      .foregroundColor: ArduinoColorPalette.tealPalette.tint800!,
    ]
    return textView
  }()
  
  private let uncheckedImage = UIImage(named: "sign_in_checkbox")
  private let checkedImage = UIImage(named: "sign_in_checkbox_selected")

  private let myText: String = "I have read the <a href=\"[%1]\" style=\"text-decoration: none\">Privacy Policy</a>" +
                                "I have read the <a href=\"[%1]\" style=\"text-decoration: none\">Privacy Policy</a>" +
                                "I have read the <a href=\"[%1]\" style=\"text-decoration: none\">Privacy Policy</a>"
  
  init(folderName: String, onAction: @escaping (() -> Void)) {
    self.onAction = onAction
    super.init(frame: .zero)

    axis = .vertical
    alignment = .center
    isLayoutMarginsRelativeArrangement = true
    layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    spacing = 48

    folderLabel.text = folderName
    textView.set(htmlText: myText)
    textView.inject(urls: [Constants.ArduinoSignIn.privacyPolicyUrl])

    checkBoxImageView.isUserInteractionEnabled = true
    
    addArrangedSubview(folderView)
    addArrangedSubview(checkBoxView)
    addArrangedSubview(confirmButton)
    addArrangedSubview(notice)

    let leadingConstraint = checkBoxView.leadingAnchor.constraint(equalTo: leadingAnchor)
    leadingConstraint.priority = .required-1
    NSLayoutConstraint.activate([
      leadingConstraint,
      checkBoxView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
    ])

    let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
    checkBoxImageView.addGestureRecognizer(tap)
  }

  @objc private func didTap(_ sender: UITapGestureRecognizer) {    
    if sender.state == .ended {
      isChecked.toggle()
      onAction()
    }
  }

  private func refreshCheckBox() {
    checkBoxImageView.image = isChecked ? checkedImage : uncheckedImage
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
