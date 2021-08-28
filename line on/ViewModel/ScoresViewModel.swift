//
//  ScoresViewModel.swift
//  line on
//
//  Created by Recep Bayraktar on 28.08.2021.
//

import Foundation

class ScoresViewModel {
    
    var onSuccessResponse: (()->())?
    var onErrorResponse: ((String)->())?
    
    var scores: ScoresModel?
    
    func fetchData() {
        
        let request = URLRequest(url: URL(string: "https://demo1899326.mockable.io/matches")!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            DispatchQueue.main.async {
                if response.statusCode == 200 {
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let response = try decoder.decode(ScoresModel.self, from: data)
                            self.onSuccessResponse?()
                            self.scores = response
                        } catch let error {
                            self.onErrorResponse?("Not a Valid JSON Response with Error : \(error)")
                            print(error)
                        }
                    } else {
                        self.onErrorResponse?("HTTP Status: \(response.statusCode)")
                    }
                }
            }
        }
        task.resume()
    }
}
