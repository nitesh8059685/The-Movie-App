//
//  MovieDetailsViewController.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 23/07/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let selectedMovie = selectedMovie {
            movieDetailsConfigure(selectedMovie: selectedMovie)
        }
    }
    
    func movieDetailsConfigure(selectedMovie: Movie) {
        movieTitle.text = selectedMovie.title
        movieDescription.text = selectedMovie.plot
        movieGenre.text = selectedMovie.genre
        imdbRating.text = selectedMovie.imdbRating
        if let posterURL = URL(string: selectedMovie.poster) {   // Load the movie poster image using Kingfisher library
            moviePoster.kf.setImage(with: posterURL)
        } else {
            moviePoster.image = UIImage(named: "posterPlaceHolder") //Setting Placeholder Imagee if url is Invalid
        }
        
        
    }
}


