//
//  Recipe.swift
//  Project24
//
//  Created by Hrishikesh D S on 24/11/24.
//

struct Recipe {
    let id: String
    let title: String
    let imageName: String
    let description: String
    let userId: String

    init(id: String, data: [String: Any]) {
        self.id = id
        self.title = data["title"] as? String ?? ""
        self.imageName = data["imageName"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.userId = data["userId"] as? String ?? ""
    }
}
