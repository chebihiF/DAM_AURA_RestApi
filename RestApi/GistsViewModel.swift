//
//  GistsViewModel.swift
//  RestApi
//
//  Created by CHEBIHI FAYCAL on 12/9/2023.
//

import Foundation

final class GistsViewModel : ObservableObject {
    
    @Published var node_id: String = ""
    @Published var isGistCreate : Bool = false
    @Published var listGist: [Gist] = []
    
    func createGist (gist: Gist){
        DataService.shared.createNewGist{ (result) in
            switch result {
            case .success(let json): self.isGistCreate = true
            case .failure(let error): print(error)
            }
        }
    }
    
    // GET
    func gists(){
        DataService.shared.fetchGists { (result) in
            switch result {
            case .success(let gists): self.listGist = gists
            case .failure(let error): print(error)
            }
        }
    }
    
    /*
    init()
    {
       
        DataService.shared.createNewGist{ (result) in
            switch result {
            case .success(let json): print(json)
            case .failure(let error): print(error)
            }
        }
        
        
        DataService.shared.fetchGists { (result) in
            switch result {
            case .success(let gists): listGist = gists
            case .failure(let error): print(error)
            }
        }
    }*/
    
}
