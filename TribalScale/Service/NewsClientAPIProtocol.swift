//
//  NewsClientAPIProtocol.swift
//  TribalScale
//
//  Created by Jack Bordner on 8/13/21.
//

import Foundation

protocol NewsClientAPIProtocol {
    func fetchsNewsArticles(completion: @escaping(_ articles: [Article], _ error: Error?) -> Void)
}
