//
//  DataService.swift
//  RestApi
//
//  Created by CHEBIHI FAYCAL on 12/9/2023.
//

import Foundation

class DataService {
    static let shared = DataService()
    fileprivate let baseUrlString = "https://api.github.com" // base url
    
    func fetchGists(){
        
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "api.github.com"
        componentURL.path = "/gists/public"
        
        // operator similar to IF codition (example : if validURL = componentURL.url is invalid the else block invoked)
        guard let validURL = componentURL.url else {
            print("URL creation failed ... ")
            return // End of function fetchGists()
        }
        
        // Send a HTTP reques to the API
        URLSession.shared.dataTask(with: validURL){ (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse { // as : convert to HTTPURLResponse
                print("API status : \(httpResponse.statusCode)") // HTTP (Status) example : 200/201 = OK, 404: host not find, 500 error in server .... 401, 403 : permession ..
            }
            
            guard let validData = data, error == nil else {
                print("API error: \(error?.localizedDescription)")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                print(json)
            }catch let serializationError {
                print(serializationError.localizedDescription)
            }
            
        }.resume() // run data task
        
        
    }
}
