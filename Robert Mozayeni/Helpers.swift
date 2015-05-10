//
//  Helpers.swift
//  Robert Mozayeni
//
//  Created by Robert S Mozayeni on 4/22/15.
//  Copyright (c) 2015 Robert Mozayeni. All rights reserved.
//

import UIKit

//For any class or struct that has characteristics on linear scales.
//In the most intuitive application, this would be used with anything that exists on physical dimensions (CGPoint, CGRect),
//however, this is also very much applicable to anything that can exist in an n-dimensional data space, anything with 
//multiple characteristics that could be compared in similarity to something of the same type.

typealias DimensionVector = [Double]

protocol Dimensional {
    var dimensions: DimensionVector { get } //Could make an Interpolable protocol to use instead of Double, but that would be a confusing design pattern in the case of Ints
    static func itemFromDimensions(fromDimensions: DimensionVector) -> Self?
}

func inBetween(a: Double, b: Double, byRatio ratio: Double) -> Double {
    let diff = abs(a - b)
    let calcd = ratio * diff
    let adjusted = (a<b) ? a + calcd : a - calcd
    
    return adjusted
}

func interpolated<T: Dimensional>(a: T, b: T, byRatio ratio: Double) -> T? {
    let aDimensions = a.dimensions
    let bDimensions = b.dimensions
    if aDimensions.count != bDimensions.count {
        //This function's type signature is necessarily a proof that this block will never be executed given T's correct adherence to Dimensional.
        assertionFailure("The type \(T.self)'s implementation of Dimensional's `dimensions` property is flawed")
        return nil
    }
    
    let zpd = Array(Zip2(aDimensions, bDimensions))
    
    let rescaled = zpd.map { inBetween($0.0, $0.1, byRatio: ratio) }
    
    let result = T.itemFromDimensions(rescaled)
    
    return result
    
}

//isWithinNDimensionalBox()

extension CGPoint: Dimensional {
    var dimensions: DimensionVector {
        return [x,y].map { Double($0) }
    }
    
    static func itemFromDimensions(fromDimensions: DimensionVector) -> CGPoint? {
        return CGPoint(x: fromDimensions[0], y: fromDimensions[1])
    }
}

extension CGSize: Dimensional {
    var dimensions: DimensionVector {
        return [width, height].map { Double($0) }
    }
    
    static func itemFromDimensions(fromDimensions: DimensionVector) -> CGSize? {
        return CGSize(width: fromDimensions[0], height: fromDimensions[1])
    }
}

typealias ColorTuple = (red: CGFloat, green: CGFloat, blue: CGFloat)


extension UIColor {
    convenience init(tuple: ColorTuple) {
        self.init(red: tuple.red/255, green: tuple.green/255, blue: tuple.blue/255, alpha: 1)
    }
}
