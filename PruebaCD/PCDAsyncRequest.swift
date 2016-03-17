//
//  PCDAsyncRequest.swift
//  PruebaCD
//
//  Created by Luis Fuertes on 3/3/16.
//  Copyright © 2016 Luis.Fuertes. All rights reserved.
//

import Foundation
import Alamofire


//MARK: Protocol
protocol PCDAsyncRequestDelegate{
    func setData(questionList:[MessageObject])
}


class PCDAsyncRequest{
    
    var questionList:[MessageObject] = []
    var delegate:PCDAsyncRequestDelegate?
    
    let requestURL = "https://demo4958483.mockable.io/getQuestion"

    //MARK: Functions
    func doRequest()
    {
        Alamofire.request(.GET, requestURL)
            .responseJSON { response in
                
                if let result: NSArray = (try? NSJSONSerialization.JSONObjectWithData(response.data!,options: NSJSONReadingOptions.MutableContainers)) as? NSArray{
                    
                    self.questionList = PCDDataLoader().getData(result)
                }
    
                self.delegate?.setData(self.questionList)
        }
    }
}
