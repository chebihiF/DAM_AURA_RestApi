//
//  Gist.swift
//  RestApi
//
//  Created by CHEBIHI FAYCAL on 12/9/2023.
//

import Foundation

struct Gist: Codable {
    var id: String
    var isPublic: Bool
    var description: String
    
    // Indiquez les noms dans la réponse JSON
    enum CodingKeys: String, CodingKey {
        case id, description, isPublic = "public"
    }
    
    // Précisez ce qu'il faut faire en cas d'erreur de conversion
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.isPublic = try container.decode(Bool.self, forKey: .isPublic)
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? "Description is nil"
    }
    
}
