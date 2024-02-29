//
//  ViewController.swift
//  UiCustomLibs
//
//  Created by yohanes saputra on 28/02/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onOpenDayPicker(_ sender: Any) {
        let _ = UiDayPickerDialog.showPicker(self, delegate: { day in
            print("---> selected day: \(day)")
        })
    }
    
    @IBAction func onOpenInputPin(_ sender: Any) {
        let vc = UiPinInputController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

