//
//  main.swift
//  Structs vs Classes
//
//  Created by Ismail Elmaliki on 9/7/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import Foundation

//print("Hello, World!")

var hero = StructHero(name: "Iron Man", universe: "Marvel")

// New reference to the same object
var anotherHero = hero
anotherHero.name = "The Hulk"

print("hero name = \(hero.name)")
print("anotherMarvelhero name = \(anotherHero.name)")
