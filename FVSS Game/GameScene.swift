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
    
    public var labelloadingtext = UILabel.init()
    
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
    var infotext = "Kein Info Text"
        
    var questions = [
        1 : "When was the war of currents? ",
        2 : "Between which 2 persons did the quarrel take place?",
        3 : "Who favoured the alternating voltage? ",
        4 : "Who favoured the DC voltage? ",
        5 : "Who Discussed the about alternating voltage?",
        6 : "What was the safety of electricity compared to?",
        7 : "On which animal were experiments frequently carried out? ",
        8 : "Who had the patent rights for the light bulb? ",
        9 : "Carbon filament lamps were often used in hotels, offices and? ",
        10 : "Was chosen in 1891 for DC voltage or alternating voltage? ",
        11 : "Looking back, what does Edison call his favourite DC voltage? ",
        12 : "What did General Electric and Westinghouse found in 1896? ",
        13 : "When did the New York power utility finally discontinue DC power? ",
        14 : "When was Thomas Alva Edison born? ",
        15 : "When did Thomas Alva Edison die? ",
        16 : "When did George Westinghouse die? ",
        17 : "When was George Westinghouse born? "
    ]
    
    var infos = [
        1 : "10 years after the completion of the Cologne Cathedral, the Electricity War took place. The construction of Cologne Cathedral began around 1240 and lasted 630 years.",
        2 : "Werner Heisenberg gave the first mathematical formulation of quantum mechanics in 1925, Albert Einstein developed the special theory of relativity in 1905 and Thomas Alva Edison invented the light bulb in 1879.",
        3 : "Thomas Alva Edison favoured direct current.",
        4 : "?",
        5 : "Tv show´s have never commented on this issue.",
        6 : "The safety of electricity was not compared to dangerous animals.",
        7 : "It was tested on large massive animals.",
        8 : "Thomas Alva Edison invented the light bulb.",
        9 : "Many private individuals bought carbon filament lamps.",
        10 :"In 2007, the New York power utility Consolidated Edison finally discontinued the supply of DC voltage.",
        11 : "He made little money with it and regrets having favoured DC voltage.",
        12 : "He didn't start a big company.",
        13 : "?",
        14 : "He died in 1931 and lived for more than 30 years.",
        15 : "?",
        16 : "He was born in 1846 and lived in the 19th century.",
        17 : "?"
    ]
    
    var answers1 = [
        1 : "It was in 1890 =",
        2 : "It was between Albert Einstein and Max Planck",
        3 : "Thomas Alva Edison",
        4 : "Donald Trump",
        5 : "Politicians and Newspaper=",
        6 : "It has been compared with Water",
        7 : "It was tested on elephants=",
        8 : "Max Planck",
        9 : "Private households=",
        10 : "DC voltage",
        11 : "Good earned money",
        12 : "The Board of Patent Control=",
        13 : "2017",
        14 : "17 april 1907 in Texas",
        15 : "9 November 1989",
        16 : "12 March 1914 in New York=",
        17 : "3 December 1967 in Texas"

    ]
    
    var answers2 = [
        1 : "It was in 1979",
        2 : "It was between Niels Bohr and Werner Heisenberg",
        3 : "George Westinghouse=",
        4 : "Thomas Alva Edison=",
        5 : "TV shows",
        6 : "It has been compared with gas=",
        7 : "It was tested on pigs",
        8 : "Albert Einstein",
        9 : "Police stations",
        10 : "alternating voltage=",
        11 : "At the best business",
        12 : "A big company",
        13 : "2004",
        14 : "11 February 1847 in Ohio=",
        15 : "12 Mach 1877",
        16 : "3 April 1899 in Ohio",
        17 : "22 January 2002 in Arizona"
    ]
    
    var answers3 = [
        1 : "It was in 2002",
        2 : "It was between Thomas Alva Edison and George Westinghouse=",
        3 : "Galileo Galilei",
        4 : "Stephen Hawking",
        5 : "Thomas Alva Edison and George Westinghouse",
        6 : "It has been compared with dangerous animals",
        7 : "It was tested on dogs",
        8 : "Thomas Alva Edison=",
        9 : "Hospitals",
        10 : "Monster Energy",
        11 : "At the biggest mistake of his career=",
        12 : "A social media network",
        13 : "2007=",
        14 : "25 Mai 1798 in New York",
        15 : "18 October 1931",
        16 : "24 October 1965 in Florida",
        17 : "6 October 1846 in NewYork="
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
        self.infotext = "This Question has not helptext"
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
        self.questionLabel.numberOfLines = 0
        self.view?.addSubview(self.questionLabel)
        
        //let ans1 = UILabel.init()
        self.ans1Label.text = answer1
        self.ans1Label.textAlignment = .center
        self.ans1Label.frame = CGRect(x: 255, y: 200, width: 400, height: 55)
        self.ans1Label.font = UIFont(name: "Avenir-Light", size: 15)
        self.ans1Label.font = UIFont.boldSystemFont(ofSize: 15)
        self.ans1Label.textColor = .white
        self.ans1Label.isUserInteractionEnabled = true
        self.ans1Label.numberOfLines = 0
        let guestureRecognizerans1 = UITapGestureRecognizer(target: self, action: #selector(ans1labelclicked(_:)))
        self.ans1Label.addGestureRecognizer(guestureRecognizerans1)
        self.view?.addSubview(self.ans1Label)
        
        //let ans2 = UILabel.init()
        self.ans2Label.text = answer2
        self.ans2Label.textAlignment = .center
        self.ans2Label.numberOfLines = 0
        self.ans2Label.frame = CGRect(x: 255, y: 265, width: 400, height: 55)
        self.ans2Label.font = UIFont(name: "Avenir-Light", size: 15)
        self.ans2Label.font = UIFont.boldSystemFont(ofSize: 15)
        self.ans2Label.textColor = .white
        self.ans2Label.isUserInteractionEnabled = true
        let guestureRecognizerans2 = UITapGestureRecognizer(target: self, action: #selector(ans2labelclicked(_:)))
        self.ans2Label.addGestureRecognizer(guestureRecognizerans2)
        self.view?.addSubview(self.ans2Label)
        
        //let ans3 = UILabel.init()
        self.ans3Label.text = answer3
        self.ans3Label.textAlignment = .center
        self.ans3Label.numberOfLines = 0
        self.ans3Label.frame = CGRect(x: 255, y: 330, width: 400, height: 55)
        self.ans3Label.font = UIFont(name: "Avenir-Light", size: 15)
        self.ans3Label.font = UIFont.boldSystemFont(ofSize: 15)
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
        if infos[numberquiz] != "?" {
            showAlert(withTitle: "Help", message: infos[numberquiz]!)
            helptextused = true
        } else {
            showAlert(withTitle: "Help", message: self.infotext)
            self.helptextused = false
        }
    }
    
    @objc func scorebtnclicked(_ sender: Any){
        showAlert(withTitle: "Score", message: "Highscore: " + String(highscore) + " \nScore: " + String(score))
    }
    
    func pickQuestNumber() -> Int{
        let randomInt = Int.random(in: 1..<17)
        let num: Int = randomInt
        return num
    }
    
    func nextquest(){
        let number = pickQuestNumber()
        self.numberquiz = number
        self.infotext = "This Question has no help text"
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.nextquest()
                }
            } else {
                self.showAlert(withTitle: "Wrong", message: "This was the wrong answer")
                score = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.nextquest()
                }
            } else {
                self.showAlert(withTitle: "Wrong", message: "This was the wrong answer")
                score = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.nextquest()
                }
            } else {
                self.showAlert(withTitle: "Wrong", message: "This was the wrong answer")
                score = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
        
        let highscoredefault = UserDefaults.standard
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
