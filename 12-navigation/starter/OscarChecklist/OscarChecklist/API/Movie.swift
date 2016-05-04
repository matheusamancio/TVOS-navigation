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

import Foundation

struct Movie {
  let title: String
  let synopsis: String
  let director: String
  let actors: [String]
  let genre: String
  let runtime: Int
  let pictureRating: String
  let imageURL: String
  let userRating: Float
  
  init?(dictionary: [String: AnyObject]) {
    guard let title = dictionary["title"] as? String, synopsis = dictionary["synopsis"] as? String, director = dictionary["director"] as? String, actors = dictionary["actors"] as? [String], genre = dictionary["genre"] as? String, runtime = dictionary["runtime"] as? Int, pictureRating = dictionary["pictureRating"] as? String, imageURL = dictionary["imageURL"] as? String, userRating = dictionary["userRating"] as? Float else {
      return nil
    }
    
    self.title = title
    self.synopsis = synopsis
    self.director = director
    self.actors = actors
    self.genre = genre
    self.runtime = runtime
    self.pictureRating = pictureRating
    self.imageURL = imageURL
    self.userRating = userRating
  }
}