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
    
    
    /*
     En SwiftUI, "@escaping completion" signifie qu'une fonction prend un paramètre appelé "completion"
     qui peut être stockée et exécutée ultérieurement, Cela permet généralement de gérer des opérations asynchrones,
     telles que des appels réseau.
     Result<[Gist],Error> : au cas de .success => [Gist], au cas d'erreur : .failure => Error
     */
    
    func fetchGists(completion: @escaping (Result<[Gist],Error>) -> Void ){
        
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
            
            // get data from httpResponse
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
            
                
                let gists = try JSONDecoder().decode([Gist].self, from: validData)
                
                completion(.success(gists))
                
            }catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume() // run data task
        
        
    }
}
