import SpriteKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let background = SKSpriteNode(imageNamed: "background")
    let menuButton = SKSpriteNode(imageNamed: "exit")
    let avatar = SKSpriteNode(imageNamed: "avatar")
    let playerName = SKLabelNode(text: "Player")
    let gameArea = SKSpriteNode(imageNamed: "gameBaground")
    let gold = SKSpriteNode(imageNamed: "gold")
    let bottomButton = SKSpriteNode(imageNamed: "LOGO")
    let ballCategory: UInt32 = 0x1 << 0
    let squareCategory: UInt32 = 0x1 << 1
    let borderCategory: UInt32 = 0x1 << 1
    var currentLevel = 1
    var bollSize:CGSize = CGSize(width: 0, height: 0)
    
    var scoreLabel = SKLabelNode(text: "100")
    var balance:Int = 0
    var selectedSquares = Set<SKSpriteNode>()
    let maxSelectedSquares = 3
    let throwCost = 10
    var skin = 1
    weak var viewController: UIViewController?
    
    var numBalls = 0
    
    private lazy var sounds: Bool = {
        return UserDefaults.standard.object(forKey: "sounds") as? Bool ?? true
    }()
    
    override func didMove(to view: SKView) {
        setupDefaults()
        
        sounds = UserDefaults.standard.object(forKey: "sounds") as? Bool ?? true
        SoundManager.shared.backgroundGameSound(selector: sounds)
        
        // Фоновое изображение
        background.anchorPoint = .zero
        background.position = .zero
        background.size = size
        background.zPosition = -10
        addChild(background)
        
        // Кнопка меню
        if UIDevice.current.userInterfaceIdiom == .pad {
            menuButton.position = CGPoint(x: size.width - 120, y: size.height - 120)
            menuButton.size = CGSize(width: 60, height: 60)
        }else{
            menuButton.position = CGPoint(x: size.width - 50, y: size.height - 55)
            menuButton.size = CGSize(width: 40, height: 40)
        }
        menuButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        menuButton.zPosition = 1
        
        
        addChild(menuButton)
        
        // Аватар игрока
        if UIDevice.current.userInterfaceIdiom == .pad {
            avatar.position = CGPoint(x: 120, y: size.height - 120)
            avatar.size = CGSize(width: 60, height: 60)
        }else{
            avatar.size = CGSize(width: 40, height: 40)
            avatar.position = CGPoint(x: 50, y: size.height - 55)
        }
        if let image = UserDefaults.standard.object(forKey: "avatarPhoto") as? Data {
            DispatchQueue.global().async {
                    if let uiImage = UIImage(data: image) {
                        let texture = SKTexture(image: uiImage)
                        DispatchQueue.main.async {
                            self.avatar.texture = texture
                        }
                    }
                }
            
        }
        avatar.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        avatar.zPosition = 1
        addChild(avatar)
        
        
        
        // Имя игрока
        if let name = UserDefaults.standard.object(forKey: "userName") as? String {
            playerName.text = name
        }
        playerName.position = CGPoint(x: avatar.frame.maxX + playerName.frame.width/1.5, y: avatar.frame.minY + avatar.size.height / 2 - 5)
        playerName.verticalAlignmentMode = .center
        playerName.fontName = "Arial Rounded MT"
        if UIDevice.current.userInterfaceIdiom == .pad {
            //playerName.fontSize = 44
        }else{
            playerName.fontSize = 25
        }
        playerName.zPosition = .zero
        playerName.zPosition = 1
        addChild(playerName)
        
        // Игровая область
        var gameAreaWidth = 0.0
        var gameAreaHeight = 0.0
        if UIDevice.current.userInterfaceIdiom == .pad {
            gameAreaWidth = size.width * 0.6
            gameAreaHeight = gameAreaWidth * 1.5
        }else{
            gameAreaWidth = size.width * 0.8
            gameAreaHeight = gameAreaWidth * 1.5
        }
        gameArea.size = CGSize(width: gameAreaWidth, height: gameAreaHeight)
        gameArea.position = CGPoint(x: (size.width - gameAreaWidth) / 2, y: (size.height - gameAreaHeight) / 2)
        gameArea.zPosition = 1
        gameArea.anchorPoint = .zero
        // установить скругленные углы для gameArea
        
        // Создаем SKShapeNode с прямоугольником и скругленными углами
        let shape = SKShapeNode(rect: CGRect(origin: CGPoint.zero, size: gameArea.size), cornerRadius: 10)
        shape.fillColor = .white
        shape.strokeColor = .clear
        shape.zPosition = 2 // устанавливаем за gameArea
        gameArea.addChild(shape)
        addChild(gameArea)
        //createGameAreaBoundaries()
        
        bollSize = CGSize(width: gameArea.size.width / 5, height: gameArea.size.width / 5)
        
        // Лейбл счетчика очков
       // scoreLabel.position = CGPoint(x: size.width / 2 - 25, y: gameArea.frame.maxY + 30)
        scoreLabel.fontColor = .white
        scoreLabel.fontName = "Arial Rounded MT"
        if UIDevice.current.userInterfaceIdiom == .pad {
            scoreLabel.fontSize = 44
            scoreLabel.position = CGPoint(x: size.width / 2 - 25, y: gameArea.frame.maxY + 30)
        }else{
            scoreLabel.fontSize = 30
            scoreLabel.position = CGPoint(x: size.width / 2 - 25, y: gameArea.frame.maxY + 20)
        }
        //scoreLabel.fontSize = 30
        scoreLabel.zPosition = 1
        scoreLabel.text = "\(balance)"
        addChild(scoreLabel)
        
//        gold.position = CGPoint(x: scoreLabel.frame.maxX + 30, y: gameArea.frame.maxY + 45)
        gold.zPosition = 1
        if UIDevice.current.userInterfaceIdiom == .pad {
            gold.size = CGSize(width: 60, height: 60)
            gold.position = CGPoint(x: scoreLabel.frame.maxX + 30, y: gameArea.frame.maxY + 45)
        }else{
            gold.size = CGSize(width: 40, height: 40)
            gold.position = CGPoint(x: scoreLabel.frame.maxX + 30, y: gameArea.frame.maxY + 35)
        }
        //gold.size = CGSize(width: 40, height: 40)
        gold.zPosition = 1
        addChild(gold)
        // Нижняя кнопка
        bottomButton.position = CGPoint(x: size.width * 0.2 , y: 20)
        bottomButton.zPosition = 1
        bottomButton.size = CGSize(width: size.width * 0.6, height: gameArea.frame.minY - 50)
        bottomButton.anchorPoint = .zero
        addChild(bottomButton)
        
        currentLevel = UserDefaults.standard.value(forKey: "selectedLvl") as? Int ?? 1
        print(currentLevel)
        createObstacles()
        
        createSquares()
        physicsWorld.contactDelegate = self
    }
    
    func setupDefaults(){
        if let balance = UserDefaults.standard.value(forKey: "balance") as? Int{
            if balance <= 0 {
                self.balance = 100
            }else{
                self.balance = balance
            }
        }else{
            UserDefaults.standard.set(100, forKey: "balance")
            self.balance = 100
            FirebaseManager.shared.saveGold(gold: balance)
        }
        
        if let skin = UserDefaults.standard.value(forKey: "skin") as? Int{
            self.skin = skin
        }else{
           skin = 1
        }
    }
    
    // Создание границ игровой области
    func createGameAreaBoundaries() {
        let leftBoundary = SKNode()
        leftBoundary.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: gameArea.frame.minX, y: gameArea.frame.minY),
                                                 to: CGPoint(x: gameArea.frame.minX, y: gameArea.frame.maxY))
        leftBoundary.physicsBody?.isDynamic = false
        addChild(leftBoundary)
        
        let rightBoundary = SKNode()
        rightBoundary.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: gameArea.frame.maxX, y: gameArea.frame.minY),
                                                  to: CGPoint(x: gameArea.frame.maxX, y: gameArea.frame.maxY))
        rightBoundary.physicsBody?.isDynamic = false
        addChild(rightBoundary)
    }
    // Создание и падение шара
    func spawnBall(at location: CGPoint) {
        
        if balance <= 0 {return}
        SoundManager.shared.buttonSound(selector: sounds)
        let ball = SKSpriteNode(imageNamed: "ball\(skin)")
        ball.name = "ball"
        ball.size = CGSize(width: bollSize.width / 2, height: bollSize.height / 2)
        ball.position = location
        ball.zPosition = 2
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.height / 2)
        ball.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Установите имя "ball" для каждого созданного шара
        
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.angularVelocity = CGFloat.pi
        
        ball.physicsBody?.restitution = 0.5
        ball.physicsBody?.friction = 0.0
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = squareCategory
        addChild(ball)
    }
    
    
    // Создание квадратов
    func createSquares() {
        let squareSize: CGFloat = gameArea.size.width / 5.5
        let spacing: CGFloat = 5
        let numSquares = 5
        
        for i in 0..<numSquares {
            let box = SKSpriteNode(imageNamed: "box\(i+1)")
            if UIDevice.current.userInterfaceIdiom == .pad {
                box.position = CGPoint(x: gameArea.frame.minX + 10 + CGFloat(i) * (squareSize + spacing) + squareSize/2, y: gameArea.frame.minY + squareSize/2 + spacing)
            }else{
                box.position = CGPoint(x: gameArea.frame.minX + 2 + CGFloat(i) * (squareSize + spacing) + squareSize/2, y: gameArea.frame.minY + squareSize/2 + spacing)
            }
            //box.position = CGPoint(x: gameArea.frame.minX + 2 + CGFloat(i) * (squareSize + spacing) + squareSize/2, y: gameArea.frame.minY + squareSize/2 + spacing)
            box.zPosition = 2
            box.size = CGSize(width: squareSize * 0.9, height: squareSize * 0.9)
            box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
            box.physicsBody?.categoryBitMask = squareCategory
            box.physicsBody?.isDynamic = false
            box.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            box.name = "box"
            addChild(box)
            
            // Create circular obstacles at top corners
            let cornerRadius: CGFloat = 5
            let cornerOffset: CGFloat = 5
            let topLeftCorner = SKSpriteNode(imageNamed: "ball2")
            topLeftCorner.position = CGPoint(x: box.frame.minX - 2 , y: box.frame.maxY + 10)
            topLeftCorner.size = CGSize(width: 5, height: 5)
            topLeftCorner.zPosition = 3
            topLeftCorner.physicsBody = SKPhysicsBody(circleOfRadius: cornerRadius)
            // topLeftCorner.physicsBody?.categoryBitMask = squareCategory
            topLeftCorner.physicsBody?.isDynamic = false
            addChild(topLeftCorner)
            
            let topRightCorner = SKSpriteNode(imageNamed: "ball2")
            topRightCorner.position = CGPoint(x: box.frame.maxX + 2 , y: box.frame.maxY + 10)
            topRightCorner.size = CGSize(width: 5, height: 5)
            topRightCorner.zPosition = 3
            topRightCorner.physicsBody = SKPhysicsBody(circleOfRadius: cornerRadius)
            //topRightCorner.physicsBody?.categoryBitMask = squareCategory
            topRightCorner.physicsBody?.isDynamic = false
            addChild(topRightCorner)
        }
    }
    
    
    // Создание препятствий
    func createObstacles() {
        gameArea.removeAllChildren()
        
        let layout = createLevel(level: currentLevel)
        //let obstacleSize: CGFloat = 20
        let ballSize: CGFloat = 40
        let numRows = layout.count
        let numObstaclesInRow = layout[0].count
        let obstacleSize: CGFloat = 10
        
        for row in 0..<numRows {
            let rowData = layout[row]
            let numObstaclesInRow = rowData.count
            let totalRowWidth = CGFloat(numObstaclesInRow) * obstacleSize
            let xOffset = (gameArea.size.width - totalRowWidth) / 2
            
            for i in 0..<numObstaclesInRow {
                if rowData[i] == 1 {
                    var xPos: CGFloat = 0
                    var yPos: CGFloat = 0
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        xPos = ballSize * 1.5 + ((bollSize.width / 2) * CGFloat(i)) - obstacleSize / 1.8
                        yPos = gameArea.frame.minY + (CGFloat((bollSize.width / 2) * CGFloat(row)) )
                    }else{
                        xPos = gameArea.frame.minX + ((bollSize.width / 2) * CGFloat(i)) - obstacleSize / 1.8
                        yPos = gameArea.frame.minY + (CGFloat((bollSize.width / 2) * CGFloat(row)) )
                    }

                    let obstacle = SKSpriteNode(imageNamed: "ball8")
                    obstacle.size = CGSize(width: obstacleSize, height: obstacleSize)
                    obstacle.position = CGPoint(x: xPos , y: yPos )
                    obstacle.zPosition = 2
                    obstacle.physicsBody = SKPhysicsBody(circleOfRadius: obstacle.size.height / 4)
                    obstacle.physicsBody?.isDynamic = false
                    obstacle.physicsBody?.friction = 0.0
                    obstacle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    gameArea.addChild(obstacle)
                }
            }
        }
    }
    
    
    // Обработка касаний экрана
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if menuButton.contains(location) {
                print("меню")
                SoundManager.shared.backgroundGameSound(selector: false)
                SoundManager.shared.buttonSound(selector: sounds)
                viewController?.performSegue(withIdentifier: "mainVC", sender: nil)
            }
            print(location.x)
            if let touchedNode = nodes(at: location).first as? SKSpriteNode, touchedNode.name == "box" {
                if selectedSquares.contains(touchedNode) {
                    selectedSquares.remove(touchedNode)
                    touchedNode.run(SKAction.scale(to: 1, duration: 0.1))
                } else if selectedSquares.count < maxSelectedSquares {
                    selectedSquares.insert(touchedNode)
                    touchedNode.run(SKAction.scale(to: 1.1, duration: 0.1))
                }
            } else if gameArea.contains(location) && !selectedSquares.isEmpty {
                
                if balance <= 0 {
                    print("babla ytn")
                    viewController?.showAlert(delegate: viewController as! AlertDelegate, titleText: "GIFT BOX", subTitle: "Get 100 gold as a gift", image: UIImage(named: "box")!)
                    balance = 100
                    UserDefaults.standard.set(balance, forKey: "balance")
                     FirebaseManager.shared.saveGold(gold: balance)
                }
                print(numBalls)
                if numBalls < 3{
                    balance -= throwCost
                    UserDefaults.standard.set(balance, forKey: "balance")
                    FirebaseManager.shared.saveGold(gold: balance)
                    updateScoreLabel()
                    let ballLocation = CGPoint(x: location.x, y: gameArea.frame.maxY - 40)
                    spawnBall(at: ballLocation)
                }
            }else{
                viewController?.showAlert(delegate: viewController as! AlertDelegate, titleText: "Need to choose boxes", subTitle: "You need to choose from 1 to 3 boxes where the ball will fall", image: UIImage(named: "box3")!)
            }
        }
    }
    // Update score label
    func updateScoreLabel() {
        scoreLabel.text = "\(balance)"
        FirebaseManager.shared.saveGold(gold: balance)
        UserDefaults.standard.set(balance, forKey: "balance")
    }
    
    // Collision handling
    func didBegin(_ contact: SKPhysicsContact) {
        var ball: SKNode?
        var square: SKNode?
        let colorLabel = SKLabelNode(text: "")
        if contact.bodyB.categoryBitMask == ballCategory && contact.bodyA.categoryBitMask == squareCategory{
            ball = contact.bodyB.node
            square = contact.bodyA.node
        }
        
        // Check for collision with screen bounds
            if contact.bodyB.categoryBitMask == ballCategory && contact.bodyA.categoryBitMask == borderCategory {
                ball = contact.bodyB.node
                numBalls -= 1
            }
            
        if let ball = ball, let square = square {
            
            ball.removeFromParent()
            numBalls -= 1
            let pulse = SKAction.sequence([
                SKAction.scale(by: 1.2, duration: 0.1),
                SKAction.scale(by: 1 / 1.2, duration: 0.1)
            ])
            if selectedSquares.contains(square as! SKSpriteNode) {
                print(selectedSquares.count)
                balance += 60 / selectedSquares.count
                updateScoreLabel()
                colorLabel.text = "+\(60 / selectedSquares.count)"
            }
            square.run(pulse)
            bottomButton.run(pulse)
           
           // colorLabel.text = "+\(60 / selectedSquares.count)"
            colorLabel.position = CGPoint(x: frame.midX, y: frame.midY)
            colorLabel.zPosition = 3
            addChild(colorLabel)
            
            let fadeOut = SKAction.fadeOut(withDuration: 2)
            colorLabel.run(fadeOut) {
                colorLabel.removeFromParent()
            }
            
        }
        
    }
    
    
}


extension GameScene {
    
    func createLevel(level: Int) -> [[Int]] {
        switch level {
        case 1:
            return [
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1]
            ]
        case 2:
            return [
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [1, 0, 1, 0, 1, 0, 1, 0, 1]
            ]
        case 3:
            return [
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0]
            ]
        case 4:
            return [
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0]
            ]
        case 5:
            return [
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1]
            ]
        case 6:
            return [
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0]
            ]
        case 7:
            return [
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [1, 0, 1, 0, 1, 0, 1, 0, 1]
            ]
        case 8:
            return [
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1]
                
            ]
        case 9:
            return [
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0]
                
                
            ]
        case 10:
            return [
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0],
                [1, 0, 1, 0, 1, 0, 1, 0, 1],
                [0, 1, 0, 1, 0, 1, 0, 1, 0]
                
                
            ]
            
        default:
            return []
        }
    }
}
