//
//  Gist.swift
//  RestApi
//
//  Created by CHEBIHI FAYCAL on 12/9/2023.
//

import Foundation

struct Gist: Encodable {
    
    var id: String?
    var isPublic: Bool
    var description: String
    var files: [String: File]
    
    // Indiquez les noms dans la réponse JSON
    enum CodingKeys: String, CodingKey {
        case id, description, files, isPublic = "public"
    }
    
    // passer de Gist à JSON (POST, PUT)
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(isPublic, forKey: .isPublic)
        try container.encode(description, forKey: .description)
        try container.encode(files, forKey: .files)
    }
    
}

// Suite de la structure Gist
extension Gist: Decodable {
    // Précisez ce qu'il faut faire en cas d'erreur de conversion (GET)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.isPublic = try container.decode(Bool.self, forKey: .isPublic)
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? "Description is nil"
        self.files = try container.decode([String: File].self, forKey: .files)
    }
}

struct File: Codable {
    var content: String?
}
