//
//  GameScene.swift
//  FVSS Game
//
//  Created by Benjamin Nierlich on 25.03.21.
//

import SpriteKit
import GameplayKit


var loaded: Bool = false
var charakter: String = ""

class GameScene: SKScene {
    
    let loadingImage = SKSpriteNode(imageNamed: "loadingimage")
    
    override func didMove(to view: SKView) {
        loadingImage.size = self.size
        loadingImage.anchorPoint = CGPoint.zero
        self.addChild(loadingImage)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            loaded = true
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if loaded == true{
            let selectCharakter = selectCharakter(size: self.size)
            let animation = SKTransition.fade(withDuration: 0.2)
            self.view?.presentScene(selectCharakter, transition: animation)
        }
    }
    
    func preLoadStructs(){
        
    }

}

//CREATE CHARAKTRE SCENE
class selectCharakter: SKScene{
    
    
    
    func send(){
        print("funkt")
    }
    
    //Charakter auswählen UI
    //in every game u can play Edison or Tesla
    let imagecharakter = SKSpriteNode(imageNamed: "charakter")
    
    override func didMove(to view: SKView) {
        let edisonBTN = UIButton.init(type: .system)
        edisonBTN.setTitle("", for: .normal)
        edisonBTN.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        edisonBTN.addTarget(self, action: #selector(edisonbtnClicked(_:)), for: .touchUpInside)
        self.view?.addSubview(edisonBTN)
        
        
        let teslabtn = UIButton.init(type: .system)
        teslabtn.setTitle("", for: .normal)
        teslabtn.frame = CGRect(x: 650, y: 170, width: 250, height: 250)
        teslabtn.addTarget(self, action: #selector(teslabtnClicked(_:)), for: .touchUpInside)
        self.view?.addSubview(teslabtn)
        
        
        
        imagecharakter.size = self.size
        imagecharakter.anchorPoint = CGPoint.zero
        self.addChild(imagecharakter)
    }
    
    @objc func edisonbtnClicked(_: UIButton){
        charakter = "edison"
        print(charakter)
        switchtoIngame()
    }
    
    @objc func teslabtnClicked(_: UIButton){
        charakter = "tesla"
        print(charakter)
        switchtoIngame()
    }
    
    func switchtoIngame(){
        let ingame = ingame(size: self.size)
        let animation = SKTransition.fade(with: .red, duration: 2)
        self.view?.presentScene(ingame, transition: animation)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
}



//INGAME SCENE
class ingame: SKScene{
    
    var question = "test"
    var answer1 = "test1"
    var answer2 = "test 2"
    var answer3 = "test 3"
    
    var questions = [
        1 : "Wer ist so richtig lost?",
        2 : "Test2",
        3 : "Test3",
        4 : "Test4"
    ]
    
    var infos = [
        1 : "Beide sind gleich Drauf",
        2 : "antwort2",
        3 : "antwort 3",
        4 : "antwort 4"
    ]
    
    var answers = [
        1 : "Chris und Benny ≤ Benny ≤ Chris",
        2 : "antwort2",
        3 : "antwort 3",
        4 : "antwort 4"
    ]
    
    func initBackGround(){
        print(questions[1]!)
        let quizuiimg = SKSpriteNode(imageNamed: "quizui")
        quizuiimg.size = self.size
        quizuiimg.anchorPoint = CGPoint.zero
        self.addChild(quizuiimg)
    }
    
    func createLabelQuestionandAnswers(quest: String, answe1: String, answe2: String, answe3: String){
        let question = UILabel.init()
        question.text = quest
        question.frame = CGRect(x:150, y: 25, width: 625, height: 155)
        question.font = UIFont(name: "Avenir-Light", size: 25)
        question.textAlignment = .center
        self.view?.addSubview(question)
        
        let ans1 = UILabel.init()
        ans1.text = answe1
        ans1.textAlignment = .center
        ans1.frame = CGRect(x: 255, y: 200, width: 400, height: 55)
        ans1.font = UIFont(name: "Avenir-Light", size: 25)
        ans1.isUserInteractionEnabled = true
        let guestureRecognizerans1 = UITapGestureRecognizer(target: self, action: #selector(ans1labelclicked(_:)))
        ans1.addGestureRecognizer(guestureRecognizerans1)
        self.view?.addSubview(ans1)
        
        let ans2 = UILabel.init()
        ans2.text = answe2
        ans2.textAlignment = .center
        ans2.frame = CGRect(x: 255, y: 265, width: 400, height: 55)
        ans2.font = UIFont(name: "Avenir-Light", size: 25)
        ans2.isUserInteractionEnabled = true
        let guestureRecognizerans2 = UITapGestureRecognizer(target: self, action: #selector(ans2labelclicked(_:)))
        ans2.addGestureRecognizer(guestureRecognizerans2)
        self.view?.addSubview(ans2)
        
        let ans3 = UILabel.init()
        ans3.text = answe3
        ans3.textAlignment = .center
        ans3.frame = CGRect(x: 255, y: 330, width: 400, height: 55)
        ans3.font = UIFont(name: "Avenir-Light", size: 25)
        ans3.isUserInteractionEnabled = true
        let guestureRecognizerans3 = UITapGestureRecognizer(target: self, action: #selector(ans3labelclicked(_:)))
        ans3.addGestureRecognizer(guestureRecognizerans3)
        self.view?.addSubview(ans3)
        
    }
    
    @objc func ans1labelclicked(_ sender: Any){
        print("test clicked ans1")
    }
    
    @objc func ans2labelclicked(_ sender: Any){
        print("test clicked ans2")
    }
    
    @objc func ans3labelclicked(_ sender: Any){
        print("test clicked ans3")
    }
    
    override func didMove(to view: SKView) {
        //self.question = questions[1]!
        initBackGround()
        createLabelQuestionandAnswers(quest: "test12345", answe1: "Das ist ein Test", answe2: "Das ist ein test2", answe3: "das ist ein test3")
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    
}
