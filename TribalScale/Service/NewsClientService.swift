//
//  NewsClientService.swift
//  TribalScale
//
//  Created by Jack Bordner on 8/13/21.
//

import Foundation

enum NewsClientServiceError: Error {
    case invalidURL
    case responseError
    case invalidDataResponse
    case parsingJSONError
    case initializingError
}

class NewsClientService: NewsClientAPIProtocol {
    
    private func fetchNewsIDS(completion: @escaping ([Int], Error?) -> Void) {
        
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") else {
            completion([], NewsClientServiceError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion([], NewsClientServiceError.responseError)
                return
            }
            
            guard let data = data else {
                completion([], NewsClientServiceError.invalidDataResponse)
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
            
            guard let arrayOfIds = json as? [Int] else {
                completion([], NewsClientServiceError.parsingJSONError)
                return
            }
            
            completion(arrayOfIds, nil)
            
        }.resume()
        
    }
    
    func fetchsNewsArticles(completion: @escaping ([Article], Error?) -> Void) {
        
        fetchNewsIDS { (ids, error) in
            guard error == nil else {
                completion([], error)
                return
            }
            
            var retrievedArticles = [Article]()
            
            let dispatchGroup = DispatchGroup()
            
            for id in ids {
                
                dispatchGroup.enter()
                guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty") else {
                    completion([], NewsClientServiceError.invalidURL)
                    return
                }
                
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard error == nil else {
                        completion([], NewsClientServiceError.responseError)
                        return
                    }
                    
                    guard let data = data else {
                        completion([], NewsClientServiceError.invalidDataResponse)
                        return
                    }
                    
                    guard let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        completion([], NewsClientServiceError.parsingJSONError)
                        return
                    }
                    
                    do {
                        let article = try Article(dictionary: jsonDict)
                        retrievedArticles.append(article)
                    } catch {
                        print(error)
                    }
                    
                    dispatchGroup.leave()
                }.resume()
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                completion(retrievedArticles, nil)
            }
        }
    }
}
