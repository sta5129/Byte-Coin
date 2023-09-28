//
//  ViewController.swift
//  ByteCoin
//
//  Created by Samarah Anderson on 5/9/23.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        // Setting VC as data source for currencyPicker
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    //MARK: - UIPickerView data source and delegatete
}
    extension ViewController: UIPickerViewDelegate{
        
        //telling xcode how many rows and columns the picker should have
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        //delegate method
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return coinManager.currencyArray.count
        }
        //delegate method
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return coinManager.currencyArray[row]
        }
        //delegate method - gets called everytime user scrolls picker. records the row number that was selected
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selectedCurrency = coinManager.currencyArray[row]
            coinManager.getCoinPrice(for: selectedCurrency)
        }
    }
//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(_ coinManager: CoinManager, price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

