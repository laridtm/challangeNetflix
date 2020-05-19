//
//  MovieListWorker.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 06/05/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieListWorkerProtocol: class {
    func request(urlName: String, closure: (([Movie]) -> Void)?)
    func searchMovie(movies: [Movie], search: String) -> [Movie]
    var dataProviderList: MovieListDataProvider { get }
}

class MovieListWorker: MovieListWorkerProtocol {
    let dataProviderList: MovieListDataProvider

    init(dataProvider: MovieListDataProvider) {
        self.dataProviderList = dataProvider
    }

    func request(urlName: String, closure: (([Movie]) -> Void)?) {
        let session = URLSession.shared
        let url = URL(string: urlName)!
        let task = session.dataTask(with: url) { [weak self]
            data, response, error in

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(error)
                    return
            }

            let movies = try? JSONDecoder().decode([Movie].self, from: data!)
            self?.dataProviderList.addDB(movies: movies ?? [])
            closure!(movies ?? [])
        }
        task.resume()
        
    }

    func searchMovie(movies: [Movie], search: String) -> [Movie] {
        var moviesAux: [Movie] = []

        for item in movies {
            if (item.title.lowercased().contains(search.lowercased())) {
                moviesAux.append(item)
            }
        }

        if (search.isEmpty) {
            moviesAux = movies
        }

        return moviesAux
    }
}
