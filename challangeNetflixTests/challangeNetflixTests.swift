//
//  challangeNetflixTests.swift
//  challangeNetflixTests
//
//  Created by Larissa Diniz  on 20/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import XCTest
@testable import challangeNetflix

class challangeNetflixTests: XCTestCase {
    
    let decoder = JSONDecoder()
    var movies: [Movie] = []

    override func setUp() {
        super.setUp()
        self.movies = decodeMovies(nameFile: "movies")
    }

    override func tearDown() {
        super.tearDown()
        self.movies.removeAll()
    }
    
    func decodeMovies(nameFile: String) -> [Movie] {
        
        guard let fileURL = Bundle.main.url(forResource: nameFile, withExtension: "json") else {
            print("couldn't find the file")
            return []
        }
        
        do {
            let content = try Data(contentsOf: fileURL)
            
            do {
                let movies = try decoder.decode([Movie].self, from: content)
                return movies
            } catch {
                print(error)
            }
            
        } catch let error {
            print(error)
        }
        return []
    }
    
    func testDecodingIsCorrect() {
        
        XCTAssertEqual(movies.count, 4)
    }
    
//    func testIfTheCellContainsAnImage() {
//
//        let cell: MovieCell
//        cell = MovieCell()
//
//        guard let urlImage: URL = self.movies[0].images[2] else {
//            print(Error.self)
//            return
//        }
//
//        XCTAssertNil(cell.movieImage)
//
//        cell.configureImage(url: urlImage)
//
//        XCTAssertNotNil(cell.movieImage)
//    }
    
    func testIfTheSearchIsCorrect() {
        
        var moviesSearch: [Movie] = []
        
        let movieAux: MovieAux = MovieAux()
        
        moviesSearch = movieAux.searchMovie(movies: movies, search: "Av")
        
        XCTAssertEqual(moviesSearch.count, 1)
        XCTAssertEqual(moviesSearch[0].title, "Avatar")
        
    }
    

}
