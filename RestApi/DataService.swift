//
//  DataService.swift
//  RestApi
//
//  Created by CHEBIHI FAYCAL on 12/9/2023.
//

import Foundation

// implement CRUD operations

class DataService {
    static let shared = DataService()
    /*
     En SwiftUI, "@escaping completion" signifie qu'une fonction prend un paramètre appelé "completion"
     qui peut être stockée et exécutée ultérieurement, Cela permet généralement de gérer des opérations asynchrones,
     telles que des appels réseau.
     Result<[Gist],Error> : au cas de .success => [Gist], au cas d'erreur : .failure => Error
     */
    
    // GET
    func fetchGists(completion: @escaping (Result<[Gist],Error>) -> Void ){
        
       let componentURL = createURLComponents(path: "/gists/public")
        
        // operator similar to IF codition (example : if validURL = componentURL.url is invalid the else block invoked)
        guard let validURL = componentURL.url else {
            print("URL creation failed ... ")
            return // End of function fetchGists()
        }
        
        // Send a HTTP request to the API (GET)
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
    
    // POST
    func createNewGist(completion: @escaping (Result<Any,Error>) -> Void){
        let postComponents = createURLComponents(path: "/gists")
        
        // operator similar to IF codition (example : if validURL = componentURL.url is invalid the else block invoked)
        guard let validURL = postComponents.url else {
            print("URL creation failed ... ")
            return // End of function fetchGists()
        }
        
        // Create a HTTP request to the API (POST)
        var postRequest = URLRequest(url: validURL)
        postRequest.httpMethod = "POST"
        
        postRequest.setValue("Basic \(createAuthCredentials())", forHTTPHeaderField: "Authorization")
        postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        postRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Case of Token
        //postRequest.setValue("Bearer TOKEN", forHTTPHeaderField: "Authorization")
        
        // Create new Gist for test
        let newGist = Gist(id: nil, isPublic: true, description: "A brand new Gist", files: ["text_file.txt": File(content: "Hello World")])
        
        do{
            // try to encode Gist to JSON
            let gistData = try JSONEncoder().encode(newGist)
            // add JSON data to the HTTP Post request
            postRequest.httpBody = gistData
        }catch {
            print("Gist encoding failed ...")
        }
        
        // SEND HTTP Request and look for response
        URLSession.shared.dataTask(with: postRequest){ (data, response, error) in
            
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
        }.resume()
    }
    
    // PUT
    func updateGist(id: String, completion: @escaping (Result<Any,Error>) -> Void){
        let updateComponent = createURLComponents(path: "/gists/\(id)")
        // operator similar to IF codition (example : if validURL = componentURL.url is invalid the else block invoked)
        guard let validURL = updateComponent.url else {
            print("URL creation failed ... ")
            return // End of function fetchGists()
        }
        
        var updateRequest = URLRequest(url: validURL)
        updateRequest.httpMethod = "PUT"
        
        updateRequest.setValue("Basic \(createAuthCredentials())", forHTTPHeaderField: "Authorization")
        updateRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        updateRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Create new Gist for test
        let updatedGist = Gist(id: nil, isPublic: false, description: "A brand update Gist", files: ["text_file.txt": File(content: "Hello World")])
        
        do{
            // try to encode Gist to JSON
            let gistData = try JSONEncoder().encode(updatedGist)
            // add JSON data to the HTTP Post request
            updateRequest.httpBody = gistData
        }catch {
            print("Gist encoding failed ...")
        }
        
        URLSession.shared.dataTask(with: updateRequest){ (data, response, error) in
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
        }
        
        
    }
    
    // DELETE
    func deleteGist(id: String, completion: @escaping (Result<Any,Error>) -> Void){
        let deleteComponent = createURLComponents(path: "/gists/\(id)")
        // operator similar to IF codition (example : if validURL = componentURL.url is invalid the else block invoked)
        guard let validURL = deleteComponent.url else {
            print("URL creation failed ... ")
            return // End of function fetchGists()
        }
        
        var deleteRequest = URLRequest(url: validURL)
        deleteRequest.httpMethod = "DELETE"
        
        deleteRequest.setValue("Basic \(createAuthCredentials())", forHTTPHeaderField: "Authorization")
        deleteRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        deleteRequest.setValue("application/json", forHTTPHeaderField: "Accept")
 
        
        URLSession.shared.dataTask(with: deleteRequest){ (data, response, error) in
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
        }
        
        
    }
    
    // Generate auth credentials
    func createAuthCredentials() -> String {
        let authString = "TOKEN_API"
        var authStringBase64 = ""
        
        // Basic auth (user, password)
        if let authData = authString.data(using: .utf8){
            authStringBase64 = authData.base64EncodedString()
        }
        return authStringBase64
    }
    
    // Générer le PATH de la requette HTTP
    func createURLComponents(path: String) -> URLComponents {
        
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "api.github.com"
        componentURL.path = path
        
        return componentURL
    }
}
