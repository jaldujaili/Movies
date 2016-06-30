//
//  ShowMovieViewController.swift
//  MovieDB
//
//  Created by Jordan  on 5/2/16.
//  Copyright © 2016 Jordan . All rights reserved.
//

import UIKit

class ShowMovieViewController: UIViewController {
    var movie : Movie?
    var favoriteMovies: MovieList?
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        favoriteMovies = (UIApplication.sharedApplication().delegate as! AppDelegate).favoriteMovies
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    func configureUI(){
        self.setPoster()
        titleLbl.text = movie?.title
        overviewLbl.text = movie?.overview
        let name = favoriteMovies!.contains(movie!) ? "favorite" : "not-favorite"
        favoriteButton.setImage(UIImage(named: name), forState: .Normal)
    }

    @IBAction func toogleFavorites(sender: AnyObject) {
        favoriteMovies?.toggle(movie!)
        configureUI()
    }
    func setPoster(){
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let imageUrl = NSURL(string: baseUrl + movie!.poster!)
        posterImage.setImageWithURL(imageUrl!)
    }
    
    @IBAction func backBtnTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
