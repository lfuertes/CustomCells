//
//  PCDResultViewController.swift
//  PruebaCD
//
//  Created by Luis Fuertes on 3/3/16.
//  Copyright © 2016 Luis.Fuertes. All rights reserved.
//

import UIKit

class PCDResultViewController: UITableViewController {

    var answersList:[MessageObject] = []
    
    //MARK: Init
    func setContext(objects:[MessageObject])
    {
        self.answersList = objects
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 90
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.answersList.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if(self.answersList[indexPath.row].tipo == "foto" && self.answersList[indexPath.row].respuestaImagen != nil){
            return 100
        }else{
            return UITableViewAutomaticDimension
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        let answer = self.answersList[indexPath.row]
        
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.text = answer.texto
        cell.textLabel!.sizeToFit()
        
        if(answer.tipo == "foto"){
            
            cell.detailTextLabel!.text = ""
            cell.imageView!.image = answer.respuestaImagen
            
        }else if(answer.tipo == "bool"){
        
            if(answer.respuestaBool != nil && answer.respuestaBool == true){
                cell.detailTextLabel!.text = "Sí"
            }else{
                cell.detailTextLabel!.text = "No"
            }
        }else{
            
            if let respuestaString = answer.respuestaString{
                cell.detailTextLabel!.text = respuestaString
            }else{
                cell.detailTextLabel!.text = ""
            }
        }

        return cell
    }
}
