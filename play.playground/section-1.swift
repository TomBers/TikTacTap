// Playground - noun: a place where people can play
// Consider this your Main class, basically the Stage
// Note: The code below is for OSX Playground, not iOS

// this imports higher level APIs like Starling
import SpriteKit
import XCPlayground

// we create our custom MyCircle class extending SKShapeNode
// we define two properties for the destination properties
// we use Float for a 32 bit floating point, we would use Double if we needed 64 bit precision
class MyCircle : SKShapeNode {
    var destX: Float = 0.0
    var destY: Float = 0.0
}

// canvas size for the positioning
let canvasWidth: UInt32 = 500
let canvasHeight: UInt32 = 500

// our main logic inside this class
// we subclass the SKScene class by using the :TheType syntax below
class GameScene: SKScene {
    
    // this gets triggered automatically when presented to the view, put initialization logic here
    override func didMoveToView(view: SKView) {
        
        // let's iterate 20 times
        for i in 1..20 {
            // we create new instances of our MyCircle class
            // note that we don't use new, this is done implicitely
            // SkShapeNode is a primitive for drawing like with the AS3 Drawing API
            // it has built in support for primitives like a circle, so we pass a radius
            let shape = MyCircle(circleOfRadius: 10)
            // we set initial position
            shape.position = CGPoint (x: CGFloat(arc4random()%(canvasWidth)), y: CGFloat(arc4random()%(canvasHeight)))
            // we set random destination values
            // we convert the random values returned as Int to Float
            // Note the use of arc4random() as an equivalent to Math.random()
            shape.destX = Float(arc4random()%(canvasWidth))
            shape.destY = Float(arc4random()%(canvasHeight))
            // we add each circle to the display list
            self.addChild(shape)
        }
    }
    
    // we override update, which is like an Event.ENTER_FRAME or advanceTime in Starling
    override func update(currentTime: CFTimeInterval) {
        // to remove ambiguity we annotate ball
        for ball: AnyObject in self.children{
            // we downcast with the as keyword before using the MyCircle custom properties
            let currentBall = ball as MyCircle
            // we apply easing motion to the balls
            currentBall.position.x += (CGFloat(currentBall.destX)-currentBall.position.x)*0.1
            currentBall.position.y += (CGFloat(currentBall.destY)-currentBall.position.y)*0.1
            // we calculate the difference between positions (distance)
            // by default x and y positions use the CGFloat type that can accept Float and Double values, we cast it to Float to be consistent with our destX and destY properties
            let diffX = Float(currentBall.position.x) - currentBall.destX
            let diffY = Float(currentBall.position.y) - currentBall.destY
            // if less than 1, we are done, let's set new a destination
            if ( diffX <= 1.0 && diffY <= 1.0 ){
                currentBall.destX = Float(arc4random()%(canvasWidth))
                currentBall.destY = Float(arc4random()%(canvasHeight))
            }
        }
    }
}

// we create our scene (from our GameScene above), like a main canvas
let scene = GameScene(size: CGSize(width:CGFloat(canvasWidth), height: CGFloat(canvasHeight)))

// we need a view
let view = SKView(frame: NSRect(x: 0, y: 0, width: CGFloat(canvasWidth), height: CGFloat(canvasHeight)))

// we link both
view.presentScene(scene)

// display it, XCPShowView is a global function that paints the final scene
XCPShowView("result", view)