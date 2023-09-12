//
//  GistsViewModel.swift
//  RestApi
//
//  Created by CHEBIHI FAYCAL on 12/9/2023.
//

import Foundation

final class GistsViewModel : ObservableObject {
    
    init()
    {
        DataService.shared.fetchGists { (result) in
            switch result {
            case .success(let json): print(json)
            case .failure(let error): print(error)
            }
        }
    }
}
