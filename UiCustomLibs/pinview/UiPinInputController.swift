//
//  UiPinInputController.swift
//  UiCustomLibs
//
//  Created by yohanes saputra on 29/02/24.
//

import Foundation
import UIKit

class UiPinInputController: UIViewController {
    struct Property {
        static let maximumChar: Int = 6
    }
    private var currentText: [String] = []
    private var currentActiveIndex = -1
    var delegate: ((String) -> Void)?
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        label.text = "Masukan PIN/Password"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 17
        return stackView
    }()
    
    private lazy var keyboard: UiKeyboardView = {
        var view = UiKeyboardView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // can be a logo
        let labelLogo = UILabel()
        labelLogo.text = "LOGO"
        labelLogo.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        view.addSubview(labelLogo)
        labelLogo.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
        }
        
        // label
        view.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(labelLogo.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        // start setup pin view
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        clearInputText()
        for _ in 0..<Property.maximumChar {
            let view = UIView()
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            view.layer.cornerRadius = 10
            stackView.addArrangedSubview(view)
            view.snp.makeConstraints { make in
                make.size.equalTo(20)
            }
        }
        
        // setup keyboard
        keyboard.delegate = { data in
            if let inputData = data{
                if inputData == "backspace" {
                    if self.currentActiveIndex >= 0 {
                        self.currentText[self.currentActiveIndex] = ""
                        self.stackView.arrangedSubviews[self.currentActiveIndex].backgroundColor = UIColor.white
                        self.currentActiveIndex -= 1
                    }
                } else if self.currentActiveIndex < Property.maximumChar-1  {
                    self.currentActiveIndex += 1
                    self.currentText[self.currentActiveIndex] = inputData
                    self.stackView.arrangedSubviews[self.currentActiveIndex].backgroundColor = UIColor.black.withAlphaComponent(0.4)
                    
                    if self.currentActiveIndex == Property.maximumChar-1 {
                        // call done
                        let dataPinOrPassword = self.currentText.joined()
                        self.delegate?(dataPinOrPassword)
                        print("---> input done: \(dataPinOrPassword)")
                    }
                }
            }
        }
        view.addSubview(keyboard)
        keyboard.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.bottom.equalToSuperview()
            make.height.equalTo(view.snp.width)
        }
    }
    
    private func clearInputText() {
        self.currentText.removeAll()
        for _ in 0..<Property.maximumChar {
            self.currentText.append("")
        }
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        stackView.arrangedSubviews.forEach({ view in
//            view.layer.cornerRadius = 15
//        })
//    }
}
