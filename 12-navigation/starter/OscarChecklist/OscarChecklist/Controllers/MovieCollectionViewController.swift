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

class MovieCollectionViewController: UICollectionViewController {
    private let detailSegueIdentifier = "DetailSegue"
    private let reuseIdentifier = "MovieCell"
    var movies = [Movie]()
    var movieOrder: SortOrder = .Alphabetical
    var movieCategory: CategoryType {
        if let tabBarController = tabBarController,
            splitViewController = splitViewController, index =
            tabBarController.viewControllers?.indexOf(splitViewController) {
            return CategoryType(rawValue: index)!
        }
        return .BestPicture
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieService.sharedInstance.getMovieNominationsForCategory(movieCategory) {
            movies in
            self.movies = movies
            self.collectionView?.reloadData()
        }
    }
    
    
    //MARK: -Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? MovieDetailViewController,  selectedIndex = collectionView!.indexPathsForSelectedItems()?.first {
            let sectionMovies = moviesForSection(selectedIndex.section)
            destinationViewController.movie = sectionMovies[selectedIndex.item]
        }
    }
}


// MARK: UICollectionViewDataSource
extension MovieCollectionViewController {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesForSection(section).count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MovieCollectionViewCell
        
        // 2
        let sectionMovies = moviesForSection(indexPath.section)
        let movie = sectionMovies[indexPath.item]
        
        // 3
        cell.movieTitleLabel.text = movie.title
        cell.movieImageView.setImageFromMovie(movie)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        // 1
        switch kind {
        // 2
        case UICollectionElementKindSectionHeader:
            // 3
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "MovieHeaderView", forIndexPath: indexPath) as! MovieCollectionReusableView
            
            // 4
            if indexPath.section == 0 {
                headerView.headerLabel.text = "Unwatched Movies"
            } else {
                headerView.headerLabel.text = "Watched Movies"
            }
            
            return headerView
        default:
            // 5
            assert(false, "Unexpected Supplementary View Type")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieCollectionViewController: UICollectionViewDelegateFlowLayout {
    // 1
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 300, height: 525)
    }
    
    // 3
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 90, bottom: 70, right: 90)
    }
}

// MARK: UICollectionViewDelegate
extension MovieCollectionViewController {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let sectionMovies = moviesForSection(indexPath.section)
        let selectedMovie = sectionMovies[indexPath.item]
        print("Selected \(selectedMovie.title)")
        performSegueWithIdentifier(detailSegueIdentifier, sender: nil)
    }
    
    // 1
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        // 2
        cell.alpha = 0.0
        // 3
        UIView.animateWithDuration(1.0) { () -> Void in
            cell.alpha = 1.0
        }
    }
    
    // 1
    override func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        // 2
        view.frame.origin.x += 50
        view.alpha = 0.0
        
        // 3
        UIView.animateWithDuration(1.0) { () -> Void in
            view.frame.origin.x -= 50
            view.alpha = 1.0
        }
    }
}



// MARK: MovieSortDelegate
extension MovieCollectionViewController: MovieSortDelegate {
    func orderChanged(order: SortOrder) {
        movieOrder = order
        collectionView?.reloadData()
    }
}

// MARK: Private Methods
private extension MovieCollectionViewController {
    func moviesForSection(section: Int) -> [Movie] {
        if section == 0 {
            return sortMovies(movies.filter({
                MovieService.isMovieWatched($0) == false }))
        } else {
            return sortMovies(movies.filter({
                MovieService.isMovieWatched($0) == true }))
        }
    }
    func sortMovies(movies: [Movie]) -> [Movie] {
        switch movieOrder {
        case .Alphabetical:
            return movies.sort{$0.title < $1.title}
        case .UserRating:
            return movies.sort{$0.userRating > $1.userRating}
        case .Length:
            return movies.sort{$0.runtime > $1.runtime}
        }
    }
    
}
