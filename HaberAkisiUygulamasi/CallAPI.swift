//
//  CallAPI.swift
//  HaberAkisiUygulamasi
//
//  Created by resedat on 29.04.2022.
//

import Foundation
import Metal

final class CallAPI {
    
    static let shared = CallAPI()
    
    struct Constans {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=tr&apiKey=c1230b54ce054ef1a698cc141bbb5278")
        static let searchUrlString = "https://newsapi.org/v2/top-headlines?country=tr&apiKey=c1230b54ce054ef1a698cc141bbb5278&q="
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constans.topHeadlinesURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let urltring = Constans.searchUrlString + query
        guard let url = URL(string: urltring) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}

struct APIResponse : Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
