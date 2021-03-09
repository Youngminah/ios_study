//
//  SearchViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/02.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SearchViewController: UISearchBarDelegate{
    //키보드가 올라와 있을 때 내려가게 처리
    private func dismissKeyboard(){
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        //검색어가 없으면 아무일도 잃어나지 않음.
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            return
        }
        //네트워킹을 통한 검색
        // - 목표 : 서치텀을 가지고 네트워킹을 통해서 영화 검색
        // - [x] 검색 API가 필요
        // - [x] 결과를 받아올 모델 Movie, Response
        // - 결과를 받아와서, CollectionView로 표현해주자.
        SearchAPI.search(searchTerm){ movies in
            print("-->몇개 넘어왔어?: \(movies.count), 첫번째꺼 제목: \(movies.first?.title)")
        }
    
        
    }
}

class SearchAPI{
    static func search(_ term: String, completion: @escaping ([Movie]) -> Void ){
        let session = URLSession(configuration: .default)
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let termQuery = URLQueryItem(name: "term", value: "movie")
        urlComponents.queryItems?.append(mediaQuery)
        urlComponents.queryItems?.append(entityQuery)
        urlComponents.queryItems?.append(termQuery)
        
        let requestURL = urlComponents.url!
        
        let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
            let successRange = 200..<300
            guard error == nil, let statusCode  = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else{
                completion([])
                return
            }
            guard let resultData = data else {
                completion([])
                return
            }
            // data -> [Movie]
            let movies = SearchAPI.parseMovies(resultData)
            completion(movies)        }
        dataTask.resume()
    }
    
    static func parseMovies(_ data: Data) -> [Movie] {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(Response.self, from: data)
            let movies = response.moives
            return movies
        }catch let error {
            print("--> parsing error: \(error.localizedDescription)")
            return []
        }
    }
}

struct Response: Codable{
    let resultCount: Int
    let moives: [Movie]
    enum CodingKeys: String, CodingKey{
        case resultCount
        case moives = "results"
    }
}

struct Movie: Codable{
    let title: String
    let director: String
    let thumbnailPath: String
    let previewURL : String
    
    enum CodingKeys: String, CodingKey{
        case title = "trackName"
        case director = "artistName"
        case thumbnailPath = "artworkUrl100"
        case previewURL = "previewUrl"
    }
}
