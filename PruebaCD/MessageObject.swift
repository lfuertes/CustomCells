//
//  messageObject.swift
//  PruebaCD
//
//  Created by Luis Fuertes on 3/3/16.
//  Copyright © 2016 Luis.Fuertes. All rights reserved.
//

import Foundation
import UIKit


class MessageObject{
    
    var pregunta:Int
    var tipo:String
    var texto:String
    var respuestaString:String?
    var respuestaImagen:UIImage?
    var respuestaBool:Bool?
    
    
    init(pregunta: Int, tipo: String, texto: String)
    {
        self.pregunta = pregunta
        self.tipo = tipo
        self.texto = texto
    }

    
}