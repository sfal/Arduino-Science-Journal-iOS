//  
//  DriveSyncFolderPickerView.swift
//  ScienceJournal
//
//  Created by Emilio Pavia on 07/01/21.
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

class DriveSyncFolderPickerView: UIStackView {
  let pageView = UIView()

  init(pathView: DriveSyncPathView) {
    super.init(frame: .zero)

    axis = .vertical
    spacing = 0
    isLayoutMarginsRelativeArrangement = true
    layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    
    pathView.setContentHuggingPriority(.required, for: .vertical)
    addArrangedSubview(pathView)

    pageView.translatesAutoresizingMaskIntoConstraints = false
    addArrangedSubview(pageView)
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)
  }
}