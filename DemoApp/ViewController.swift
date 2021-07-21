//
//  ViewController.swift
//  DemoApp
//
//  Created by iKh4 on 8/6/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = self.books[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC: DetailsViewController = DetailsViewController()
        detailsVC.urlString = self.books[indexPath.row].link
        self.present(detailsVC, animated: true, completion: nil)
        
    }
    
    
    var tableView: UITableView?
    
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.view.frame)
        self.view.addSubview(self.tableView!)
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.getBookListFromAPi()
        
        // Do any additional setup after loading the view.
    }
    
    func getBookListFromAPi(){
        let url = URL(string: "https://ikh4ever.github.io/myBookListData/data.json")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error{
                print("Error", error)
                return
            }
            
            guard let httpRes = response as? HTTPURLResponse, (200...299).contains(httpRes.statusCode) else{
                print("Error")
                return
            }
            
            
            if let data = data{
                let bookListResponse = try? JSONDecoder().decode([Book].self, from: data)
                self.books = bookListResponse ?? []
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
                
                print(bookListResponse?.first?.title)
            }
            
        }
        
        task.resume()
    }


}


struct Book: Codable{
    let id: Int
    let title, link: String
}


