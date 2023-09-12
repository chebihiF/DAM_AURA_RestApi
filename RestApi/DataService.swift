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
        print(componentURL.url!)
    }
}
