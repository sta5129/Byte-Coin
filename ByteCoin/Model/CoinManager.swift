//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Samarah Anderson on 5/9/23.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, price: String, currency: String)
    func didFailWithError (error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "784E3972-8EA2-4930-8065-AFE6BD7838F6"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String)  {
        //creating url string (using string concatenation) based on the currency that the user selects
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"

        //1. create URL
        if let url = URL(string: urlString) {
            
            //2. create URL session
            let session = URLSession(configuration: .default)
            
            //3. give URL session a task
            //Completion handler: Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion.
            //Closure
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let bitcoinPrice = self.parseJSON(safeData) {
                        
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        
                        self.delegate?.didUpdatePrice(self, price: priceString, currency: currency)
                    }
                }
            }
            //4. start task
                task.resume()
        }
    }
    
    //decoding the data
    func parseJSON(_ data: Data) -> Double? {
         let decoder = JSONDecoder()
        
        //do is always executed. if try is successful code flows to the code immediately after try keyword. if try throws error code jumps to catch.
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            //getting the last property from the decoded data
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice 
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
