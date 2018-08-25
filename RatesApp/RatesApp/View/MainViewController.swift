//
//  ViewController.swift
//  RatesApp
//
//  Created by Алексей Папин on 25.08.2018.
//  Copyright © 2018 Алексей Папин. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.maximumDate = Date()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let datePicker = self.datePicker else {
            print("view: \(self.view), datePicker: \(self.datePicker), usdLabel: \(self.usdLabel), eurLabel: \(self.eurLabel)")
            return
        }
        datePicker.addTarget(self, action: #selector(self.datePicked(_:)), for: .valueChanged)
    }
}

extension MainViewController {
    @objc func datePicked(_ sender: UIDatePicker) {
        sender.isEnabled = false
        APIClient.default.getRates([.usd, .eur], on: sender.date).done{ self.showRates($0) }.catch{ print($0) }.finally{ sender.isEnabled = true }
    }
    
    func showRates(_ rates: [Rate]) {
        for rate in rates {
            switch rate.currency {
            case .usd   : self.usdLabel.text = "USD: \(String.init(format: "%.2f", rate.value))"
            case .eur   : self.eurLabel.text = "EUR: \(String.init(format: "%.2f", rate.value))"
            }
        }
    }
}
