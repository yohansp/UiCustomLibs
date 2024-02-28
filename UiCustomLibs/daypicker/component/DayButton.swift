//
//  DayButton.swift
//  UiCustomLibs
//
//  Created by yohanes saputra on 28/02/24.
//

import Foundation
import UIKit

class DayButton: UIView {
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.layer.backgroundColor = UIColor(hex: 0x2841fc).cgColor
        self.layer.cornerRadius = 9
        self.clipsToBounds = true
        addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
}
