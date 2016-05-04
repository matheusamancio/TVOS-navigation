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

enum CategoryType: Int, CustomStringConvertible {
  case BestPicture
  case AnimatedFeature
  
  var description: String {
    switch self {
    case .BestPicture: return "Best Picture"
    case .AnimatedFeature: return "Animated Feature"
    }
  }
}

class MovieService {
  static let sharedInstance = MovieService()
  let session: NSURLSession
  let URLCache = NSURLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: "ImageDownloadCache")
  
  init() {
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    config.requestCachePolicy = NSURLRequestCachePolicy.ReturnCacheDataElseLoad
    config.URLCache = URLCache
    session = NSURLSession(configuration: config)
  }
  
  func getMovieNominationsForCategory(category: CategoryType, completion: ([Movie]) -> Void) {
    var movies: [Movie] = []
    
    // Simulating an API call using a prebundled .plist file
    if let plistPath = NSBundle.mainBundle().pathForResource("BestPictureNominees", ofType: "plist"), dict = NSDictionary(contentsOfFile: plistPath) as? Dictionary<String, [[String: AnyObject]]> {
      
      if let categoryData = dict[category.description] {
        for movieInfo in categoryData {
          if let movie = Movie(dictionary: movieInfo) {
            movies.append(movie)
          }
        }
      }
    }
    
    dispatch_async(dispatch_get_main_queue()) {
      completion(movies)
    }
  }
  
  func getSampleMovie(completion: (Movie?) -> Void) {
    getMovieNominationsForCategory(.BestPicture) { movies in
      completion(movies.first)
    }
  }
  
  func getImageFromMovie(movie: Movie, completion: (UIImage?) -> Void) {
    if let url = NSURL(string: movie.imageURL) {
      let urlRequest = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 30.0)
      
      if let response = URLCache.cachedResponseForRequest(urlRequest) {
        let image = UIImage(data: response.data)
        dispatch_async(dispatch_get_main_queue()) {
          completion(image)
          return
        }
      }
      
      session.dataTaskWithRequest(urlRequest) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        guard let response = response, data = data else {
          completion(nil)
          return
        }
        
        MovieService.sharedInstance.URLCache.storeCachedResponse(NSCachedURLResponse(response:response, data:data, userInfo:nil, storagePolicy:.Allowed), forRequest: urlRequest) // commit response into cache
        
        let downloadedImage = UIImage(data: data)
        dispatch_async(dispatch_get_main_queue()) {
          completion(downloadedImage)
        }
      }.resume()
    }
  }
  
  static func setMovie(movie: Movie, asWatched watched: Bool) {
    NSUserDefaults.standardUserDefaults().setBool(watched, forKey: movie.title)
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
  static func isMovieWatched(movie: Movie) -> Bool {
    return NSUserDefaults.standardUserDefaults().boolForKey(movie.title)
  }
}

extension UIImageView {
  func setImageFromMovie(movie: Movie) {
    image = nil
    MovieService.sharedInstance.getImageFromMovie(movie) { image in
      if self.image == nil {
        self.image = image
      }
    }
  }
}