//
//  MovieCell.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 03/07/24.
//

import UIKit

class MovieCell: UITableViewCell {

    
    @IBOutlet weak var movieListBackgroundView: UIView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var favourateButtonLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieListBackgroundView.clipsToBounds = false
        movieListBackgroundView.layer.cornerRadius = 15
        moviePoster.layer.cornerRadius = 10
        movieListBackgroundView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    @IBAction func favourateButton(_ sender: Any) {
    }
}

extension MovieCell {
    func movieConfigure(with movie: Movie) {
        movieTitle.text = movie.title
        movieReleaseDate.text = movie.released
        moviePoster.setImage(with: movie.poster)
        
    }
    
    
}
