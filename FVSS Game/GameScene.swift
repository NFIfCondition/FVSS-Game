//
//  GameScene.swift
//  FVSS Game
//
//  Created by Benjamin Nierlich on 25.03.21.
//

import SpriteKit
import GameplayKit
import UIKit


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
class ingame: SKScene, Alertable{
    
    public var questionLabel = UILabel.init()
    public var ans1Label = UILabel.init()
    public var ans2Label = UILabel.init()
    public var ans3Label = UILabel.init()
    public var helpTextBtn = UILabel.init()
    public var scoreBtn = UILabel.init()
    
    public var score = 0
    public var highscore = 0
    
    public var helptextused = false
    
    var numberquiz: Int = 0
    
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
        1 : "Beide sind gleich Drauf=",
        2 : "antwort2",
        3 : "antwort 3",
        4 : "antwort 4"
    ]
    
    var answers1 = [
        1 : "Chris und Benny ",
        2 : "antwort2",
        3 : "antwort 3",
        4 : "antwort 4"
    ]
    
    var answers2 = [
        1 : "Chris und Benny =",
        2 : "antwort2 =",
        3 : "antwort 3 =",
        4 : "antwort 4 ="
    ]
    
    var answers3 = [
        1 : "Chris und Benny ",
        2 : "antwort2",
        3 : "antwort 3",
        4 : "antwort 4"
    ]
    
    func initBackGround(){
        let quizuiimg = SKSpriteNode(imageNamed: "quizui")
        quizuiimg.size = self.size
        quizuiimg.anchorPoint = CGPoint.zero
        self.addChild(quizuiimg)
    }
    
    

    
    
     func createLabelQuestionandAnswers(quest: String, answe1: String, answe2: String, answe3: String){
        
        let answer1 = String(answe1).replacingOccurrences(of: "=", with: " ")
        let answer2 = String(answe2).replacingOccurrences(of: "=", with: " ")
        let answer3 = String(answe3).replacingOccurrences(of: "=", with: " ")
        
        
        
        self.helpTextBtn.frame = CGRect(x: 760, y: 25, width: 75, height: 75)
        self.helpTextBtn.isUserInteractionEnabled = true
        let guestureRecognizeransbtn = UITapGestureRecognizer(target: self, action: #selector(helptextbtnclicked(_:)))
        self.helpTextBtn.addGestureRecognizer(guestureRecognizeransbtn)
        self.view?.addSubview(self.helpTextBtn)
        
        self.scoreBtn.frame = CGRect(x: 80, y: 25, width: 75, height: 75)
        self.scoreBtn.isUserInteractionEnabled = true
        let gestureRecognizerscorebtn = UITapGestureRecognizer(target: self, action: #selector(scorebtnclicked(_:)))
        self.scoreBtn.addGestureRecognizer(gestureRecognizerscorebtn)
        self.view?.addSubview(scoreBtn)
        
        //let question = UILabel.init()
        self.questionLabel.textColor = .white
        self.questionLabel.text = quest
        //self.questionLabel.backgroundColor = .white
        self.questionLabel.frame = CGRect(x:150, y: 25, width: 625, height: 155)
        self.questionLabel.font = UIFont(name: "Avenir-Light", size: 25)
        self.questionLabel.font = UIFont.boldSystemFont(ofSize: 25)
        self.questionLabel.textAlignment = .center
        self.view?.addSubview(self.questionLabel)
        
        //let ans1 = UILabel.init()
        self.ans1Label.text = answer1
        self.ans1Label.textAlignment = .center
        self.ans1Label.frame = CGRect(x: 255, y: 200, width: 400, height: 55)
        self.ans1Label.font = UIFont(name: "Avenir-Light", size: 25)
        self.ans1Label.font = UIFont.boldSystemFont(ofSize: 25)
        self.ans1Label.textColor = .white
        self.ans1Label.isUserInteractionEnabled = true
        let guestureRecognizerans1 = UITapGestureRecognizer(target: self, action: #selector(ans1labelclicked(_:)))
        self.ans1Label.addGestureRecognizer(guestureRecognizerans1)
        self.view?.addSubview(self.ans1Label)
        
        //let ans2 = UILabel.init()
        self.ans2Label.text = answer2
        self.ans2Label.textAlignment = .center
        self.ans2Label.frame = CGRect(x: 255, y: 265, width: 400, height: 55)
        self.ans2Label.font = UIFont(name: "Avenir-Light", size: 25)
        self.ans2Label.font = UIFont.boldSystemFont(ofSize: 25)
        self.ans2Label.textColor = .white
        self.ans2Label.isUserInteractionEnabled = true
        let guestureRecognizerans2 = UITapGestureRecognizer(target: self, action: #selector(ans2labelclicked(_:)))
        self.ans2Label.addGestureRecognizer(guestureRecognizerans2)
        self.view?.addSubview(self.ans2Label)
        
        //let ans3 = UILabel.init()
        self.ans3Label.text = answer3
        self.ans3Label.textAlignment = .center
        self.ans3Label.frame = CGRect(x: 255, y: 330, width: 400, height: 55)
        self.ans3Label.font = UIFont(name: "Avenir-Light", size: 25)
        self.ans3Label.font = UIFont.boldSystemFont(ofSize: 25)
        self.ans3Label.textColor = .white
        self.ans3Label.isUserInteractionEnabled = true
        let guestureRecognizerans3 = UITapGestureRecognizer(target: self, action: #selector(ans3labelclicked(_:)))
        self.ans3Label.addGestureRecognizer(guestureRecognizerans3)
        self.view?.addSubview(self.ans3Label)
        
    }
    
    @objc func ans1labelclicked(_ sender: Any){
        checkifansweristrue(labelnmb: 1, answernmb: numberquiz)
    }
    
    @objc func ans2labelclicked(_ sender: Any){
        checkifansweristrue(labelnmb: 2, answernmb: numberquiz)
    }
    
    @objc func ans3labelclicked(_ sender: Any){
        checkifansweristrue(labelnmb: 3, answernmb: numberquiz)
    }
    
    @objc func helptextbtnclicked(_ sender: Any){
        showAlert(withTitle: "Help", message: infos[numberquiz]!)
        helptextused = true
    }
    
    @objc func scorebtnclicked(_ sender: Any){
        showAlert(withTitle: "Score", message: "Highscore: " + String(highscore) + " \nScore: " + String(score))
    }
    
    func pickQuestNumber() -> Int{
        let randomInt = Int.random(in: 1..<4)
        let num: Int = randomInt
        return num
    }
    
    func nextquest(){
        let number = pickQuestNumber()
        self.numberquiz = number
        createLabelQuestionandAnswers(quest: questions[Int(number)]!, answe1: answers1[Int(number)]!, answe2: answers2[Int(number)]!, answe3: answers3[Int(number)]!)
    }
    
    
    func checkifansweristrue(labelnmb: Int, answernmb: Int){
        switch labelnmb {
        case 1:
            let answer : String = String(answers1[answernmb]!)
            if answer.contains("=") {
                print(answer + "1111111")
                self.showAlert(withTitle: "Right", message: "This was the right answer")
                
                if helptextused != true {
                    addPointstoScore(points: 5)
                    print("test")
                } else {
                    addPointstoScore(points: 2)
                    helptextused = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.nextquest()
                }
            } else {
                self.showAlert(withTitle: "Wrong", message: "This was the wrong answer")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.nextquest()
                }
            }
            
        case 2:
            let answer : String = String(answers2[answernmb]!)
            if answer.contains("=") {
                print(answer + "222222")
                self.showAlert(withTitle: "Right", message: "This was the right answer")
                
                if helptextused != true {
                    addPointstoScore(points: 5)
                    print("test")
                } else {
                    addPointstoScore(points: 2)
                    helptextused = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.nextquest()
                }
            } else {
                self.showAlert(withTitle: "Wrong", message: "This was the wrong answer")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.nextquest()
                }
            }
        case 3:
            let answer : String = String(answers3[answernmb]!)
            if answer.contains("=") {
                print(answer + "333333")
                self.showAlert(withTitle: "Right", message: "This was the right answer")
                
                if helptextused != true {
                    addPointstoScore(points: 5)
                    print("test")
                } else {
                    addPointstoScore(points: 2)
                    helptextused = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.nextquest()
                }
            } else {
                self.showAlert(withTitle: "Wrong", message: "This was the wrong answer")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.nextquest()
                }
            }
        default:
            print("FEHLER")
        }
        
    }
    
    override func didMove(to view: SKView) {
        self.numberquiz = pickQuestNumber()
        initBackGround()
        
        var highscoredefault = UserDefaults.standard
        
        if (highscoredefault.value(forKey: "highscore" + charakter) != nil) {
            highscore = highscoredefault.integer(forKey: "highscore" + charakter)
        }
        
        createLabelQuestionandAnswers(quest: questions[Int(self.numberquiz)]!, answe1: answers1[Int(self.numberquiz)]!, answe2: answers2[Int(self.numberquiz)]!, answe3: answers3[Int(self.numberquiz)]!)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    func addPointstoScore(points: Int){
        score += points
        if (score > highscore){
            highscore = score
            
            var highscoredefault = UserDefaults.standard
            highscoredefault.set(highscore, forKey: "highscore" + charakter)
            highscoredefault.synchronize()
        }
        
    }
    
    
    
}

protocol Alertable { }
extension Alertable where Self: SKScene {

    func showAlert(withTitle title: String, message: String) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in }
        alertController.addAction(okAction)        

        view?.window?.rootViewController?.present(alertController, animated: true)
    }

    func showAlertWithSettings(withTitle title: String, message: String) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alertController.addAction(okAction)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in

            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        alertController.addAction(settingsAction)

        view?.window?.rootViewController?.present(alertController, animated: true)
    }
}
