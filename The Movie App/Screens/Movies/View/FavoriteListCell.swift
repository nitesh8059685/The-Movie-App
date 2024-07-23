//
//  FavoriteListCell.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 23/07/24.
//

import UIKit

class FavoriteListCell: UITableViewCell {
    
    @IBOutlet weak var favoriteCellBackground: UIView!
    @IBOutlet weak var favoriteMovieLable: UILabel!
  
    weak var movieListDelegate: ReloadTaleViewDelegate?
    weak var favoriteListDelegate: ReloadTaleViewDelegate?
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        favoriteCellBackground.clipsToBounds = false
        favoriteCellBackground.layer.cornerRadius = 10
        favoriteCellBackground.backgroundColor = .systemGray6

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension FavoriteListCell {
    func favoriteConfigure(with favoriteMovies: [String], at indexPath: IndexPath) {
        let movie = favoriteMovies[indexPath.row]
        favoriteMovieLable.text = movie
    }
}
