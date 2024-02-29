//
//  UiKeyboardCell.swift
//  UiCustomLibs
//
//  Created by yohanes saputra on 29/02/24.
//

import Foundation
import UIKit

class UiKeyboardCell: UICollectionViewCell {
    
    var delegate: ((String?) -> Void)?
    var currentData: String?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.text = "1"
        label.textColor = .black.withAlphaComponent(0.8)
        return label
    }()
    
    private lazy var viewBack: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 3
        return view
    }()
    
    private lazy var btnBack: UIImageView = {
        let img = UIImageView(image: UIImage(named: "ic_backspace"))
        return img
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        contentView.addSubview(viewBack)
        viewBack.snp.makeConstraints { make in
            make.size.equalTo(self.contentView.snp.height).multipliedBy(0.8)
            make.center.equalToSuperview()
        }
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        btnBack.isHidden = true
        contentView.addSubview(btnBack)
        btnBack.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.center.equalToSuperview()
        }
    }
    
    func setData(_ data: String) {
        self.currentData = data
        if data.isEmpty {
            viewBack.isHidden = true
            label.isHidden = true
            btnBack.isHidden = true
        } else if data == "backspace" {
            viewBack.isHidden = true
            label.isHidden = true
            btnBack.isHidden = false
        } else {
            viewBack.isHidden = false
            label.isHidden = false
            btnBack.isHidden = true
            label.text = data
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = self.frame.height * 0.8
        viewBack.layer.cornerRadius = height / 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let sizebig = viewBack.layer.frame.height + 4
//        let coordinates = viewBack.layer.frame.origin
//        viewBack.layer.frame = CGRect(x: CGFloat(coordinates.x-2), y: CGFloat(coordinates.y-2), width: CGFloat(sizebig), height: CGFloat(sizebig))
        viewBack.layer.shadowRadius = 6
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let coordinates = viewBack.layer.frame.origin
//        viewBack.layer.frame = CGRect(x: CGFloat(coordinates.x + 2), y: CGFloat(coordinates.y + 2),
//                                      width: CGFloat(viewBack.layer.frame.width - 2), height: CGFloat(viewBack.layer.frame.height - 2))
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
            self.viewBack.layer.shadowRadius = 3
            super.touchesEnded(touches, with: event)
        })
        
        delegate?(self.currentData)
    }
}
