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

enum SortOrder: Int, CustomStringConvertible {
  case Alphabetical
  case UserRating
  case Length
  
  var description: String {
    switch self {
    case .Alphabetical: return "Alphabetical"
    case .UserRating: return "User Rating"
    case .Length: return "Film Length"
    }
  }
}

protocol MovieSortDelegate: class {
  func orderChanged(order: SortOrder)
}

class MasterTableViewController: UITableViewController {
  
  weak var delegate: MovieSortDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 200))
    
    if let detailNav = splitViewController?.viewControllers.last as? UINavigationController, sortDelegate = detailNav.topViewController as? MovieSortDelegate {
      delegate = sortDelegate
    }
    
    splitViewController?.maximumPrimaryColumnWidth = 400
  }
}

// MARK: - Table view data source
extension MasterTableViewController {
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    
    let order = SortOrder(rawValue: indexPath.row)!
    cell.textLabel?.text = order.description
    
    return cell
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Sort By"
  }
}

// MARK: - Table view delegate
extension MasterTableViewController {
  override func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
    guard let indexPath = context.nextFocusedIndexPath else { return }
    delegate?.orderChanged(SortOrder(rawValue: indexPath.row)!)
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let detailNav = splitViewController?.viewControllers.last as? UINavigationController {
      detailNav.popToRootViewControllerAnimated(true)
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}
