//
//  UiDayPickerCell.swift
//  UiCustomLibs
//
//  Created by yohanes saputra on 28/02/24.
//

import Foundation
import UIKit
import SnapKit

enum BillerReminderDateCellStatus {
    case enabled
    case disabled
    case focus
}

class UiDayPickerCell: UICollectionViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.text = "1"
        return label
    }()
    
    lazy var viewFocus: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(hex: 0x104BDD).cgColor
        return view
    }()
    
    var cellStatus: BillerReminderDateCellStatus = .enabled
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        setEnable()
        contentView.addSubview(viewFocus)
        viewFocus.snp.makeConstraints { make in
            make.size.equalTo(self.snp.width).multipliedBy(0.9)
            make.center.equalToSuperview()
        }
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.width * 0.9
        viewFocus.layer.cornerRadius = width / 2
    }
    
    func setDisable() {
        self.viewFocus.isHidden = true
        self.label.textColor = UIColor(hex: 0xC0C0C0)
    }
    
    func setEnable() {
        self.viewFocus.isHidden = true
        self.label.textColor = UIColor(hex: 0x444444)
    }
    
    func setEnableFocus() {
        self.viewFocus.isHidden = false
        self.label.textColor = UIColor.white
    }
}
