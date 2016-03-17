//
//  PCDMainViewController.swift
//  PruebaCD
//
//  Created by Luis Fuertes on 3/3/16.
//  Copyright © 2016 Luis.Fuertes. All rights reserved.
//

import UIKit

class PCDMainViewController: UITableViewController, PCDAsyncRequestDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var questionList:[MessageObject] = []
    var currentPhotoCellIndexPath:NSIndexPath?
    
    var aIndicator = UIActivityIndicatorView()
    
    
    //MARK: Init
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = ""
        
        //ActivityIndicator On
        setActivityIndicator()
        
        //Do request
        let service = PCDAsyncRequest()
        service.delegate = self
        service.doRequest()
        
        //Load Custom Cells
        loadCells()
        
        //Add showResults Button
        addShowResultsBarButton()
        
        //Hide Keyboard on tap outside
        addDismissKeyboardGesture()
    }
    
    
    //MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionList.count
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let question = self.questionList[indexPath.row]
        
        if(question.tipo == "foto")
        {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("imageCell") as! ImageTableViewCell
            
            cell.fieldCell.numberOfLines = 0;
            cell.fieldCell.text = question.texto
            cell.fieldCell.sizeToFit()
            
            cell.selectImageButton.addTarget(self, action: "selectImageButtonTapped:", forControlEvents: .TouchUpInside)
            
            return cell
            
        }else if(question.tipo == "bool")
        {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("boolCell") as! BoolTableViewCell
            
            cell.fieldCell.numberOfLines = 0;
            cell.fieldCell.text = question.texto
            cell.fieldCell.sizeToFit()
            
            cell.switchCell.addTarget(self, action: "switchButtonTapped:", forControlEvents: .ValueChanged)
            
            return cell
            
        }else //Texto
        {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("textCell") as! TextTableViewCell
            
            cell.fieldCell.numberOfLines = 0;
            cell.fieldCell.text = question.texto
            cell.fieldCell.sizeToFit()
            
            cell.textCell.addTarget(self, action: "textEdited:", forControlEvents: .EditingDidEnd)
            
            return cell
        }
    }
    
    
    //MARK: Delegates
    //Implement PCDAsyncRequestDelegate
    func setData(questionList: [MessageObject])
    {
        if(questionList.count > 0){
            
            self.aIndicator.stopAnimating()
            
            self.questionList = questionList
            self.tableView.reloadData()
            
        }else{
            showErrorAlert()
        }
    }
    
    //Implement imagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let photo = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.questionList[self.currentPhotoCellIndexPath!.row].respuestaImagen = photo
        
        let cell = self.tableView.cellForRowAtIndexPath(self.currentPhotoCellIndexPath!) as! ImageTableViewCell
        cell.imageCell.image = photo
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: Functions
    func showErrorAlert()
    {
        let alertError = UIAlertController(title: "Información", message: "Error al conectar con el servidor", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Aceptar", style: .Default) { (action:UIAlertAction!) in
        }
        alertError.addAction(cancelAction)
        presentViewController(alertError, animated: true, completion: nil)
    }
    
    func loadCells()
    {
        self.tableView.estimatedRowHeight = 90
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let textCell = UINib(nibName: "TextCell", bundle: nil)
        let imageCell = UINib(nibName: "ImageCell", bundle: nil)
        let boolCell = UINib(nibName: "BoolCell", bundle: nil)

        tableView.registerNib(textCell, forCellReuseIdentifier: "textCell")
        tableView.registerNib(imageCell, forCellReuseIdentifier: "imageCell")
        tableView.registerNib(boolCell, forCellReuseIdentifier: "boolCell")
    }
    
    func addShowResultsBarButton()
    {
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Ver resultados", style: UIBarButtonItemStyle.Plain, target: self, action: "showResults:")
        self.navigationItem.setRightBarButtonItem(rightAddBarButtonItem, animated: true)
    }
    
    func addDismissKeyboardGesture()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func setActivityIndicator()
    {
        self.aIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 40, 40))
        self.aIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.aIndicator.center = self.view.center
        self.view.addSubview(self.aIndicator)
        self.aIndicator.hidesWhenStopped = true
        self.aIndicator.startAnimating()
    }
    
    
    //MARK: Buttons
    func showResults(sender: AnyObject)
    {
        self.view.endEditing(true)
        
        let resultSegue = "PushResultSegue"
        self.performSegueWithIdentifier(resultSegue, sender: self)
    }
    
    func selectImageButtonTapped(sender: AnyObject)
    {
        let pointInTable: CGPoint = sender.convertPoint(sender.bounds.origin, toView: self.tableView)
        let cellIndexPath = self.tableView.indexPathForRowAtPoint(pointInTable)
        self.currentPhotoCellIndexPath = cellIndexPath
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    //MARK: Events
    func switchButtonTapped(sender: AnyObject)
    {
        let pointInTable: CGPoint = sender.convertPoint(sender.bounds.origin, toView: self.tableView)
        let cellIndexPath = self.tableView.indexPathForRowAtPoint(pointInTable)
        
        let cell = self.tableView.cellForRowAtIndexPath(cellIndexPath!) as! BoolTableViewCell
        self.questionList[cellIndexPath!.row].respuestaBool = cell.switchCell.on
    }
    
    //Text Editing Did End Event
    func textEdited(textField: UITextField)
    {
        let pointInTable: CGPoint = textField.convertPoint(textField.bounds.origin, toView: self.tableView)
        let cellIndexPath = self.tableView.indexPathForRowAtPoint(pointInTable)
        
        let cell = self.tableView.cellForRowAtIndexPath(cellIndexPath!) as! TextTableViewCell
        self.questionList[cellIndexPath!.row].respuestaString = cell.textCell.text
    }
    
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let presenterVC = segue.destinationViewController as? PCDResultViewController
        {
            presenterVC.setContext(self.questionList)
        }
    }
}

