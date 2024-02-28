//
//  UiDayPickerDialog.swift
//  UiCustomLibs
//
//  Created by yohanes saputra on 28/02/24.
//

import Foundation
import UIKit
import SnapKit

class UiDayPickerDialog: UIViewController {
    
    struct Property {
        static let dateCell = "cell-day-item"
    }
    
    private var selectedIndex: Int = -1
    private var dayMinus: Int?
    private var dayMinusFormatted: String?
    public var delegate: ((String) -> Void)?
    
    lazy var collectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(UiDayPickerCell.self, forCellWithReuseIdentifier: Property.dateCell)
        return view
    }()
    lazy var labelSelectedDay: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "None"
        label.textAlignment = .left
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let containerView = UIView()
        containerView.layer.backgroundColor = UIColor.white.cgColor
        containerView.layer.cornerRadius = 9
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: -1, height: 1)
        containerView.layer.shadowRadius = 2
        //containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
        //containerView.layer.shouldRasterize = true
        //containerView.layer.rasterizationScale = 1 //UIScreen.main.scale // or 1 (if false)
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
            make.height.equalTo(view.snp.width)
            make.center.equalToSuperview()
        }
        
        let headerView = UIStackView()
        headerView.axis = .horizontal
        containerView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 13, left: 17, bottom: 0, right: 13))
            make.height.equalTo(35)
        }
        headerView.addArrangedSubview(labelSelectedDay)
        
        let btnCancel = UIButton(type: .system)
        btnCancel.setTitle("Cancel", for: .normal)
        headerView.addArrangedSubview(btnCancel)
        btnCancel.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        headerView.setCustomSpacing(15, after: btnCancel)
        btnCancel.addTapGestureListener(action: {
            self.dismiss(animated: true)
        })
        
        let btnDone = DayButton()
        btnDone.setTitle("Done")
        headerView.addArrangedSubview(btnDone)
        btnDone.snp.makeConstraints { make in
            make.width.equalTo(110)
        }
        btnDone.addTapGestureListener(action: {
            self.dismiss(animated: true)
            self.delegate?(self.labelSelectedDay.text ?? "")
        })
        
        let line = UIView()
        line.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        containerView.addSubview(line)
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(13)
            make.height.equalTo(1)
        }
               
        collectionView.delegate = self
        collectionView.dataSource = self
        containerView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(13)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7))
            make.bottom.equalToSuperview()
        }
    }
    
    public static func showPicker(_ controller: UIViewController, delegate: @escaping((String) -> Void)) -> UiDayPickerDialog {
        let vc = UiDayPickerDialog()
        vc.delegate = delegate
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        controller.present(vc, animated: true)
        return vc
    }
}

extension UiDayPickerDialog: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Property.dateCell, for: indexPath) as? UiDayPickerCell else {
            return UICollectionViewCell()
        }
        cell.label.text = "\(indexPath.row+1)"
        if indexPath.row == self.selectedIndex {
            cell.setEnableFocus()
        } else {
            cell.setEnable()
        }
        
        // listener
        cell.addTapGestureListener(action: {
            self.selectedIndex = indexPath.row
            self.labelSelectedDay.text = "\(indexPath.row+1)"
            self.collectionView.reloadData()
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width/7.0
        return CGSize(width: size, height: size+9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
