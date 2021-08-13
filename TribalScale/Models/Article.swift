//
//  Article.swift
//  TribalScale
//
//  Created by Jack Bordner on 8/13/21.
//

import Foundation

struct Article {
    let title: String
    let author: String
    let publishedTimeStamp: Int
    
    init(dictionary: [String: Any]) throws {
        guard let title = dictionary["title"] as? String else { throw NewsClientServiceError.initializingError }
        guard let author = dictionary["by"] as? String else { throw NewsClientServiceError.initializingError }
        guard let time = dictionary["time"] as? Int else { throw NewsClientServiceError.initializingError }
        
        self.title = title
        self.author = author
        self.publishedTimeStamp = time
    }
}
