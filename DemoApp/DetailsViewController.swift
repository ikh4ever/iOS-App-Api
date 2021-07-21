//
//  DetailsViewController.swift
//  DemoApp
//
//  Created by ikh4ever on 10/6/21.
//

import UIKit
import PDFKit

class DetailsViewController: UIViewController {
    
    var urlString : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var pdfView : PDFView = PDFView(frame: self.view.frame)
        self.view.addSubview(pdfView)
        
        let url : URL = URL(string: self.urlString)!
        
        if let pdfDoc = PDFDocument(url: url){
            pdfView.displayMode = .singlePageContinuous
            pdfView.autoScales = true
            pdfView.displayDirection = .vertical
            pdfView.document = pdfDoc
        }
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
