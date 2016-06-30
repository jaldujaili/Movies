//
//  MovieViewController.swift
//  MovieDB
//
//  Created by Jordan  on 4/29/16.
//  Copyright © 2016 Jordan . All rights reserved.
//

import UIKit
import AFNetworking

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movies : [Movie] = [Movie]()
    var movie : Movie?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiStuff()

        // Do any additional setup after loading the view.
    }
    func apiStuff(){
        let apiKey = "d18a8c079db4937b5dbc3ae9e842de91"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(configuration:  NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue()
        )
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            if let data = data {
                if let responseDictionary = try!
                    NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary{
                    print("response \(responseDictionary)")
                    
                    let movieDictionaries = responseDictionary["results"] as! [[String : AnyObject]]
                    self.movies = movieDictionaries.map(){
                        Movie(dictionary: $0)
                    }
                    self.tableView.reloadData()
                }
            }
            
    })
        task.resume()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
            return movies.count
      
    
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let movie = movies[indexPath.row]
//        let title = movie["title"] as! String
//        let overView = movie["overview"] as! String
        let baseUrl = "http://image.tmdb.org/t/p/w500"
//        let poster = movie["poster_path"] as! String
        
        let imageUrl = NSURL(string: baseUrl + movie.poster!)
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        cell.titleLbl.text = movie.title
        cell.overViewLbl.text = movie.overview
        cell.posterView.setImageWithURL(imageUrl!)
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        movie = self.movies[indexPath.row] as! Movie
        performSegueWithIdentifier("showMovie", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMovie"{
           let vc = segue.destinationViewController as! ShowMovieViewController
            vc.movie = movie
        }
    }


}
