/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class MovieDetailViewController: UIViewController {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var synopsisLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var directorNameLabel: UILabel!
  @IBOutlet weak var actorsNameLabel: UILabel!
  @IBOutlet weak var filmDetailsLabel: UILabel!
  @IBOutlet weak var watchedButton: UIButton!
  
  var movie: Movie?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateUI()
  }
}

// MARK: Private Methods
private extension MovieDetailViewController {
  func updateUI() {
    if let movie = movie {
      // 2
      titleLabel.text = movie.title
      synopsisLabel.text = movie.synopsis
      
      titleLabel.text = movie.title
      synopsisLabel.text = movie.synopsis
      directorNameLabel.text = movie.director
      actorsNameLabel.text = movie.actors.joinWithSeparator("\n")
      filmDetailsLabel.text = "\(movie.genre)\n" +
        "Run Time \(movie.runtime) min\n" +
      "Rated \(movie.pictureRating)"
      imageView.setImageFromMovie(movie)
      
      updateWatchedStatus()
    }
  }
  
  func updateWatchedStatus() {
    if let movie = movie {
      let wasWatched = MovieService.isMovieWatched(movie)
      let buttonTitle = wasWatched ? "Mark Unwatched" : "Mark Watched"
      watchedButton.setTitle(buttonTitle, forState: .Normal)
        
    }
  }
}

// MARK: Actions
extension MovieDetailViewController {
  @IBAction func toggleWatchedPressed(sender: UIButton) {
    if let movie = movie {
      let toggledStatus = !MovieService.isMovieWatched(movie)
      MovieService.setMovie(movie, asWatched: toggledStatus)
      updateWatchedStatus()
    }
  }
}