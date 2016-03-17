//
//  PCDDataLoader.swift
//  PruebaCD
//
//  Created by Luis Fuertes on 3/3/16.
//  Copyright © 2016 Luis.Fuertes. All rights reserved.
//

import Foundation


class PCDDataLoader{
    
    func getData(response:NSArray) -> [MessageObject]
    {
        var questionList:[MessageObject] = []
        
        for item in response
        {
            if let pPregunta = (item.objectForKey("pregunta") as? Int), pTipo = (item.objectForKey("tipo") as? String), pTexto = (item.objectForKey("texto") as? String)
            {
                let askObject = MessageObject(pregunta: pPregunta, tipo: pTipo, texto: pTexto)
                questionList.append(askObject)
            }
        }
        return questionList
    }
}