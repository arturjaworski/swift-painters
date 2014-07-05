//
//  ComparableProtocol.swift
//  Swift Crunch
//
//  Created by Artur Jaworski on 05.07.2014.
//  Copyright (c) 2014 brckt. All rights reserved.
//

import Foundation
import SpriteKit

protocol ComparableProtocol {
    func isEqualToObject(anotherObject: Self) -> (Bool)
}