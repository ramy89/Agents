//
//  Util2D.swift
//  
//
//  Created by Ramy Al Zuhouri on 22/10/16.
//
//

import GameplayKit

precedencegroup Multiplicative
{
    higherThan:AdditionPrecedence
}

infix operator • : Multiplicative

/********************* CGSize Functions ********************/
// MARK: - vector_float2 Functions

extension vector_float2
{
    init(withPoint point:CGPoint)
    {
        self.init(x:Float(point.x), y:Float(point.y))
    }
}

/********************* CGSize Functions ********************/
// MARK: - CGSize Functions

func + (s1:CGSize, s2:CGSize) -> CGSize
{
    return CGSize(width: s1.width + s2.width, height: s1.height + s2.height)
}

func - (s1:CGSize, s2:CGSize) -> CGSize
{
    return CGSize(width: s1.width - s2.width, height: s1.height - s2.height)
}

func * (size:CGSize, factor:CGFloat) -> CGSize
{
    return CGSize(width: size.width * factor, height: size.height * factor)
}

func / (size:CGSize, dividend:CGFloat) -> CGSize
{
    return CGSize(width: size.width / dividend, height: size.height / dividend)
}

/********************* CGPoint Functions *******************/
// MARK: - CGPoint Functions

func * (point:CGPoint, factor:CGFloat) -> CGPoint
{
    return CGPoint(x: point.x * factor, y: point.y * factor)
}

func / (point:CGPoint, divisor:CGFloat) -> CGPoint
{
    return CGPoint(x: point.x / divisor, y: point.y / divisor)
}

func + (p1:CGPoint, p2:CGPoint) -> CGPoint
{
    return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}

func + (point:CGPoint, size:CGSize) -> CGPoint
{
    return CGPoint(x: point.x + size.width, y: point.y + size.height)
}

func + (p:CGPoint, v:CGVector) -> CGPoint
{
    return CGPoint(x: p.x + v.dx, y: p.y + v.dy)
}

func - (p1:CGPoint, p2:CGPoint) -> CGPoint
{
    return CGPoint(x: p1.x - p2.x, y: p1.y - p2.y)
}

func - (point:CGPoint, size:CGSize) -> CGPoint
{
    return CGPoint(x: point.x - size.width, y: point.y - size.height)
}

extension CGPoint
{
    init(vector_float2 vector:vector_float2)
    {
        self.init(x: CGFloat(vector.x), y:CGFloat(vector.y))
    }
    
    var magnitude : CGFloat
    {
        return CGFloat(sqrt(x * x + y * y))
    }

    var normalized : CGPoint
    {
        return self / self.magnitude
    }
}

/********************* CGVector Functions *******************/
// MARK: - CGVector Functions

func * (vector:CGVector, factor:CGFloat) -> CGVector
{
    return CGVector(dx: vector.dx * factor, dy: vector.dy * factor)
}

func / (vector:CGVector, divisor:CGFloat) -> CGVector
{
    return CGVector(dx: vector.dx / divisor, dy: vector.dy / divisor)
}

func + (p1:CGVector, p2:CGVector) -> CGVector
{
    return CGVector(dx: p1.dx + p2.dx, dy: p1.dy + p2.dy)
}

func + (v:CGVector, p:CGPoint) -> CGVector
{
    return CGVector(dx: v.dx + p.x, dy: v.dy + p.y)
}


func - (v1:CGVector, v2:CGVector) -> CGVector
{
    return CGVector(dx: v1.dx - v2.dx, dy: v1.dy - v2.dy)
}

func • (v1:CGVector, v2:CGVector) -> CGFloat
{
    return v1.dx * v2.dx + v1.dy * v2.dy
}

extension CGVector
{

    var magnitude : CGFloat
    {
        return CGFloat(sqrt(dx * dx + dy * dy))
    }

    var normalized : CGVector
    {
        return self / self.magnitude
    }
    
    func angle(withVector vector:CGVector) -> CGFloat
    {
        let versor = vector.normalized
        var angle = acos(versor • self.normalized)
        
        if self.dx < 0.0 {
            angle += CGFloat.pi
        } else {
            angle = CGFloat.pi - angle
        }
        
        return angle
    }
}







