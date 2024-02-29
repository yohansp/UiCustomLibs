//
//  UiKeyboardView.swift
//  UiCustomLibs
//
//  Created by yohanes saputra on 29/02/24.
//

import Foundation
import UIKit

class UiKeyboardView: UIView {
    
    struct Property {
        static let cellKeyboardName = "cell-keyboard-item"
    }
    
    private let listData: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9" ,"", "0", "backspace"]
    var delegate: ((String?) -> Void)?
    
    lazy var collectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(UiKeyboardCell.self, forCellWithReuseIdentifier: Property.cellKeyboardName)
        return view
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
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension UiKeyboardView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Property.cellKeyboardName, for: indexPath) as? UiKeyboardCell else {
            return UICollectionViewCell()
        }
        cell.setData(self.listData[indexPath.row])
        cell.delegate = self.delegate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3.0
        let height = width * 0.65
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
