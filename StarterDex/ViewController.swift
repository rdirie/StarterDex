//
//  ViewController.swift
//  StarterDex
//
//  Created by Rayyan Dirie on 10/28/24.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var starterDexView: UIView!
    @IBOutlet weak var starterImage: UIImageView!
    
    @IBOutlet weak var starterFact1: UITextView!
    @IBOutlet weak var starterFact2: UITextView!
    @IBOutlet weak var starterFact3: UITextView!
    @IBOutlet weak var starterMove: UIButton!
    @IBOutlet weak var starterEvolutionLevel: UILabel!
    @IBOutlet weak var starterType: UILabel!
    @IBOutlet weak var starterTitle: UILabel!
    @IBOutlet weak var starterRegion: UILabel!
    @IBOutlet weak var movesUsed: UILabel!
    var moveCount = 0
    var looper = 0
    var moveSound = "Placeholder"
    let gen1Starters = ["Bulbasaur", "Charmander", "Squirtle"]
    let gen2Starters = ["Chikorita", "Cyndaquil", "Totodile"]
    let gen3Starters = ["Treecko", "Torchic", "Mudkip"]
    let gen4Starters = ["Turtwig", "Chimchar", "Piplup"]
    let gen5Starters = ["Snivy", "Tepig", "Oshawott"]
    let gen6Starters = ["Chespin", "Fennekin", "Froakie"]
    let gen7Starters = ["Rowlet", "Litten", "Popplio"]
    
    var randomIndex = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    
    var myMoveSound: AVAudioPlayer!
    
    var starters = [StarterMon]()
    var aStarter = StarterMon()
    
    var soundURL = URL(string: "")
    
//    @IBAction func randomMon(_ sender: Any) {
////        looper = randomIndex.randomElement()!
//        setLabels()
//    }
    func setLabels(){
        if (starterDexView.backgroundColor != UIColor(white: 1, alpha: 1)){
            switch starters[looper].StarterType {
            case "Fire":
                starterDexView.backgroundColor = UIColor(red: 255/255, green: 32/255, blue: 0, alpha: 1)
            case "Water":
                starterDexView.backgroundColor = UIColor(red: 0, green: 100/255, blue: 255/255, alpha: 1)
            default:
                starterDexView.backgroundColor = UIColor(red: 30/255, green: 255/255, blue: 0, alpha: 1)
            }
        }
        starterNameLabel.text = aStarter.StarterName
        starterTitle.text = aStarter.StarterTitle
        starterType.text = aStarter.StarterType
        starterEvolutionLevel.text = "\(aStarter.StarterEvolutionLevel)"
        starterFact1.text = aStarter.StarterFact1
        starterFact2.text = aStarter.StarterFact2
        starterFact3.text = aStarter.StarterFact3
        //Researched this line to change the move button
        starterImage.image = PullImage(imagePath: aStarter.StarterImage)
        starterImage.layer.cornerRadius = 45
        starterImage.layer.borderWidth = 2
        starterImage.layer.borderColor = UIColor.darkGray.cgColor
        starterImage.layer.backgroundColor = UIColor.white.cgColor
        
        print(aStarter.StarterName)
        
        switch aStarter.StarterName {
        case "Bulbasaur":
            moveSound = "Vine Whip"
        case "Charmander":
            moveSound = "Ember"
        case "Squirtle":
            moveSound = "Water Gun"
        case "Cyndaquil":
            moveSound = "Ember"
        case "Totodile":
            moveSound = "Water Gun"
        case "Chikorita":
            moveSound = "Razor Leaf"
        case "Mudkip":
            moveSound = "Water Gun"
        case "Treecko":
            moveSound = "Absorb"
        case "Torchic":
            moveSound = "Ember"
        case "Turtwig":
            moveSound = "Razor Leaf"
        case "Chimchar":
            moveSound = "Ember"
        case "Piplup":
            moveSound = "Bubble"
        case "Snivy":
            moveSound = "Vine Whip"
        case "Tepig":
            moveSound = "Ember"
        case "Oshawott":
            moveSound = "Water Gun"
        case "Chespin":
            moveSound = "Leafage"
        case "Fennekin":
            moveSound = "Ember"
        case "Froakie":
            moveSound = "Bubble"
        case "Popplio":
            moveSound = "Water Gun"
        case "Rowlet":
            moveSound = "Leafage"
        case "Litten":
            moveSound = "Ember"
        default:
            moveSound = "Fail"
        }

        
        switch aStarter.StarterName {
        case let name where gen1Starters.contains(name):
            starterRegion.text = "Starter Region: Kanto"
        case let name where gen2Starters.contains(name):
            starterRegion.text = "Starter Region: Johto"
        case let name where gen3Starters.contains(name):
            starterRegion.text = "Starter Region: Hoenn"
        case let name where gen4Starters.contains(name):
            starterRegion.text = "Starter Region: Sinnoh"
        case let name where gen5Starters.contains(name):
            starterRegion.text = "Starter Region: Unova"
        case let name where gen6Starters.contains(name):
            starterRegion.text = "Starter Region: Kalos"
        case let name where gen7Starters.contains(name):
            starterRegion.text = "Starter Region: Alola"
        default:
            starterRegion.text = "Fail"
        }
        
        starterMove.setTitle(moveSound, for: .normal)
        
        print(moveSound)

        soundURL = URL(fileURLWithPath: Bundle.main.path(forResource: "\(moveSound)", ofType: "mp3")!)
        myMoveSound = try?AVAudioPlayer(contentsOf: soundURL!)
        }
    
    @IBAction func starterMoveBtn(_ sender: Any) {
        myMoveSound.play()
        moveCount += 1

        UserDefaults.standard.set(moveCount, forKey: "count")

        movesUsed.text = "\(moveCount)"
    }
    @IBAction func prevStarter(_ sender: Any) {
        if(looper > 0){
                    looper = looper - 1
                    setLabels()
                }
                else{
                    looper = starters.count-1
                    setLabels()
                }
    }
    
    @IBAction func nextStarter(_ sender: Any) {
        if(looper < starters.count-1){
                    looper += 1
                    setLabels()
                }
                else{
                    looper = 0
                    setLabels()
                }
    }
    @IBAction func starterInfo(_ sender: Any) {
        let browserApp = UIApplication.shared
                
        let url = URL(string:
                        aStarter.StarterSite)
                
        browserApp.open(url!)
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if (starterDexView.backgroundColor == UIColor(white: 1, alpha: 1)){
            switch aStarter.StarterType {
            case "Fire":
                starterDexView.backgroundColor = UIColor(red: 255/255, green: 32/255, blue: 0, alpha: 1)
            case "Water":
                starterDexView.backgroundColor = UIColor(red: 0, green: 100/255, blue: 255/255, alpha: 1)
            default:
                starterDexView.backgroundColor = UIColor(red: 30/255, green: 255/255, blue: 0, alpha: 1)
            }
        }
        else{
            starterDexView.backgroundColor = UIColor(white: 1, alpha: 1)
        }
    }
    
    
    @IBOutlet weak var starterNameLabel: UILabel!
    
    func populateStarters(){
        var charmander = StarterMon()
        charmander.StarterName = "Charmander"
        charmander.StarterTitle = "Lizard Pokémon"
        charmander.StarterType = "Fire"
        charmander.StarterEvolutionLevel = 16
        charmander.StarterFact1 = "Charmander’s flame is an indication of its health."
        charmander.StarterFact2 = "If the flame goes out, it dies."
        charmander.StarterFact3 = "Charmander is known for its tail flame."
        charmander.StarterMove = "Ember"
        charmander.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Charmander"
        charmander.StarterImage = "charmander.png"

        
        var bulbasaur = StarterMon()
        bulbasaur.StarterName = "Bulbasaur"
        bulbasaur.StarterTitle = "Seed Pokémon"
        bulbasaur.StarterType = "Grass/Poison"
        bulbasaur.StarterEvolutionLevel = 16
        bulbasaur.StarterFact1 = "Bulbasaur can be seen napping in bright sunlight."
        bulbasaur.StarterFact2 = "It uses the energy from the sun to grow."
        bulbasaur.StarterFact3 = "Bulbasaur is the first Pokémon in the National Pokédex."
        bulbasaur.StarterMove = "Vine Whip"
        bulbasaur.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Bulbasaur"
        bulbasaur.StarterImage = "bulbasaur.png"
        
        var squirtle = StarterMon()
        squirtle.StarterName = "Squirtle"
        squirtle.StarterTitle = "Tiny Turtle Pokémon"
        squirtle.StarterType = "Water"
        squirtle.StarterEvolutionLevel = 16
        squirtle.StarterFact1 = "Squirtle's shell is hard, which protects it."
        squirtle.StarterFact2 = "It can spray water from its mouth."
        squirtle.StarterFact3 = "Squirtle is popular due to its cute appearance."
        squirtle.StarterMove = "Water Gun"
        squirtle.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Squirtle"
        squirtle.StarterImage = "squirtle.png"
        
        var cyndaquil = StarterMon()
        cyndaquil.StarterName = "Cyndaquil"
        cyndaquil.StarterTitle = "Fire Mouse Pokémon"
        cyndaquil.StarterType = "Fire"
        cyndaquil.StarterEvolutionLevel = 17
        cyndaquil.StarterFact1 = "Cyndaquil protects its back with fire."
        cyndaquil.StarterFact2 = "When it's happy, its back flame burns brightly."
        cyndaquil.StarterFact3 = "Cyndaquil can create intense heat."
        cyndaquil.StarterMove = "Ember"
        cyndaquil.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Cyndaquil"
        cyndaquil.StarterImage = "cyndaquil.png"
        
        var totodile = StarterMon()
        totodile.StarterName = "Totodile"
        totodile.StarterTitle = "Big Jaw Pokémon"
        totodile.StarterType = "Water"
        totodile.StarterEvolutionLevel = 18
        totodile.StarterFact1 = "Totodile's bite is strong."
        totodile.StarterFact2 = "It loves to splash around."
        totodile.StarterFact3 = "Totodile is playful and likes to show off."
        totodile.StarterMove = "Water Gun"
        totodile.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Totodile"
        totodile.StarterImage = "totodile.png"
        
        var chikorita = StarterMon()
        chikorita.StarterName = "Chikorita"
        chikorita.StarterTitle = "Leaf Pokémon"
        chikorita.StarterType = "Grass"
        chikorita.StarterEvolutionLevel = 16
        chikorita.StarterFact1 = "Chikorita loves to bask in the sunlight."
        chikorita.StarterFact2 = "Its scent can soothe tired people."
        chikorita.StarterFact3 = "Chikorita can be used to track its trainers."
        chikorita.StarterMove = "Razor Leaf"
        chikorita.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Chikorita"
        chikorita.StarterImage = "chikorita.png"
        
        var mudkip = StarterMon()
        mudkip.StarterName = "Mudkip"
        mudkip.StarterTitle = "Mud Fish Pokémon"
        mudkip.StarterType = "Water"
        mudkip.StarterEvolutionLevel = 16
        mudkip.StarterFact1 = "Mudkip can sense water."
        mudkip.StarterFact2 = "It can swim in the mud."
        mudkip.StarterFact3 = "Mudkip’s fins can absorb water."
        mudkip.StarterMove = "Water Gun"
        mudkip.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Mudkip"
        mudkip.StarterImage = "mudkip.png"
        
        var treecko = StarterMon()
        treecko.StarterName = "Treecko"
        treecko.StarterTitle = "Tree Pokémon"
        treecko.StarterType = "Grass"
        treecko.StarterEvolutionLevel = 16
        treecko.StarterFact1 = "Treecko can scale trees with ease."
        treecko.StarterFact2 = "It has excellent agility."
        treecko.StarterFact3 = "Treecko can detect rain."
        treecko.StarterMove = "Absorb"
        treecko.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Treecko"
        treecko.StarterImage = "treecko.png"
        
        var torchic = StarterMon()
        torchic.StarterName = "Torchic"
        torchic.StarterTitle = "Chick Pokémon"
        torchic.StarterType = "Fire"
        torchic.StarterEvolutionLevel = 16
        torchic.StarterFact1 = "Torchic can spit fire."
        torchic.StarterFact2 = "It’s warm and cuddly."
        torchic.StarterFact3 = "Torchic is known for its tenacity."
        torchic.StarterMove = "Ember"
        torchic.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Torchic"
        torchic.StarterImage = "torchic.png"

        var turtwig = StarterMon()
        turtwig.StarterName = "Turtwig"
        turtwig.StarterTitle = "Tiny Leaf Pokémon"
        turtwig.StarterType = "Grass"
        turtwig.StarterEvolutionLevel = 18
        turtwig.StarterFact1 = "Turtwig is known to be very determined."
        turtwig.StarterFact2 = "It can photosynthesize."
        turtwig.StarterFact3 = "Turtwig has a sturdy shell."
        turtwig.StarterMove = "Razor Leaf"
        turtwig.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Turtwig"
        turtwig.StarterImage = "turtwig.png"

        var chimchar = StarterMon()
        chimchar.StarterName = "Chimchar"
        chimchar.StarterTitle = "Chimp Pokémon"
        chimchar.StarterType = "Fire"
        chimchar.StarterEvolutionLevel = 14
        chimchar.StarterFact1 = "Chimchar has a flame on its rear."
        chimchar.StarterFact2 = "It can create flames by rubbing its hands."
        chimchar.StarterFact3 = "Chimchar is energetic and playful."
        chimchar.StarterMove = "Ember"
        chimchar.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Chimchar"
        chimchar.StarterImage = "chimchar.png"

        var piplup = StarterMon()
        piplup.StarterName = "Piplup"
        piplup.StarterTitle = "Penguin Pokémon"
        piplup.StarterType = "Water"
        piplup.StarterEvolutionLevel = 16
        piplup.StarterFact1 = "Piplup loves to swim."
        piplup.StarterFact2 = "It can walk on its two feet."
        piplup.StarterFact3 = "Piplup is proud and does not like to be dirty."
        piplup.StarterMove = "Bubble"
        piplup.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Piplup"
        piplup.StarterImage = "piplup.png"

        var tepig = StarterMon()
        tepig.StarterName = "Tepig"
        tepig.StarterTitle = "Fire Pig Pokémon"
        tepig.StarterType = "Fire"
        tepig.StarterEvolutionLevel = 17
        tepig.StarterFact1 = "Tepig loves to eat."
        tepig.StarterFact2 = "It can create fire from its back."
        tepig.StarterFact3 = "Tepig is playful and loves to play in the mud."
        tepig.StarterMove = "Ember"
        tepig.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Tepig"
        tepig.StarterImage = "tepig.png"

        var snivy = StarterMon()
        snivy.StarterName = "Snivy"
        snivy.StarterTitle = "Grass Snake Pokémon"
        snivy.StarterType = "Grass"
        snivy.StarterEvolutionLevel = 17
        snivy.StarterFact1 = "Snivy is elegant and moves gracefully."
        snivy.StarterFact2 = "It can take in sunlight to increase its energy."
        snivy.StarterFact3 = "Snivy is known for its cunning."
        snivy.StarterMove = "Vine Whip"
        snivy.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Snivy"
        snivy.StarterImage = "snivy.png"

        var oshawott = StarterMon()
        oshawott.StarterName = "Oshawott"
        oshawott.StarterTitle = "Sea Otter Pokémon"
        oshawott.StarterType = "Water"
        oshawott.StarterEvolutionLevel = 17
        oshawott.StarterFact1 = "Oshawott is known for its playful nature."
        oshawott.StarterFact2 = "It can use its shell as a weapon."
        oshawott.StarterFact3 = "Oshawott loves to play in the water."
        oshawott.StarterMove = "Water Gun"
        oshawott.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Oshawott"
        oshawott.StarterImage = "oshawott.png"

        var chespin = StarterMon()
        chespin.StarterName = "Chespin"
        chespin.StarterTitle = "Spiny Nut Pokémon"
        chespin.StarterType = "Grass"
        chespin.StarterEvolutionLevel = 16
        chespin.StarterFact1 = "Chespin is protective of its friends."
        chespin.StarterFact2 = "It can curl into a ball to protect itself."
        chespin.StarterFact3 = "Chespin loves to forage for food."
        chespin.StarterMove = "Leafage"
        chespin.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Chespin"
        chespin.StarterImage = "chespin.png"

        var fennekin = StarterMon()
        fennekin.StarterName = "Fennekin"
        fennekin.StarterTitle = "Fox Pokémon"
        fennekin.StarterType = "Fire"
        fennekin.StarterEvolutionLevel = 16
        fennekin.StarterFact1 = "Fennekin's ears can detect sound."
        fennekin.StarterFact2 = "It loves to eat twigs."
        fennekin.StarterFact3 = "Fennekin can produce fire from its ears."
        fennekin.StarterMove = "Ember"
        fennekin.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Fennekin"
        fennekin.StarterImage = "fennekin.png"

        var froakie = StarterMon()
        froakie.StarterName = "Froakie"
        froakie.StarterTitle = "Bubble Frog Pokémon"
        froakie.StarterType = "Water"
        froakie.StarterEvolutionLevel = 16
        froakie.StarterFact1 = "Froakie is agile in the water."
        froakie.StarterFact2 = "It can produce bubbles to defend itself."
        froakie.StarterFact3 = "Froakie has a strong sense of smell."
        froakie.StarterMove = "Bubble"
        froakie.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Froakie"
        froakie.StarterImage = "froakie.png"

        var popplio = StarterMon()
        popplio.StarterName = "Popplio"
        popplio.StarterTitle = "Sea Lion Pokémon"
        popplio.StarterType = "Water"
        popplio.StarterEvolutionLevel = 17
        popplio.StarterFact1 = "Popplio loves to perform tricks."
        popplio.StarterFact2 = "It can create balloons from water."
        popplio.StarterFact3 = "Popplio enjoys playing in the waves."
        popplio.StarterMove = "Water Gun"
        popplio.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Popplio"
        popplio.StarterImage = "popplio.png"
        
        var rowlet = StarterMon()
        rowlet.StarterName = "Rowlet"
        rowlet.StarterTitle = "Grass Quill Pokémon"
        rowlet.StarterType = "Grass/Flying"
        rowlet.StarterEvolutionLevel = 17
        rowlet.StarterFact1 = "Rowlet can silently fly."
        rowlet.StarterFact2 = "It can shoot its feathers like arrows."
        rowlet.StarterFact3 = "Rowlet sleeps while it is perched."
        rowlet.StarterMove = "Leafage"
        rowlet.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Rowlet"
        rowlet.StarterImage = "rowlet.png"

        var litten = StarterMon()
        litten.StarterName = "Litten"
        litten.StarterTitle = "Fire Cat Pokémon"
        litten.StarterType = "Fire"
        litten.StarterEvolutionLevel = 17
        litten.StarterFact1 = "Litten is known for its independence."
        litten.StarterFact2 = "It prefers to stay alone."
        litten.StarterFact3 = "Litten’s fur can be used to create flames."
        litten.StarterMove = "Ember"
        litten.StarterSite = "https://bulbapedia.bulbagarden.net/wiki/Litten"
        litten.StarterImage = "litten.png"

        starters.append(charmander)
        starters.append(squirtle)
        starters.append(bulbasaur)
        starters.append(cyndaquil)
        starters.append(totodile)
        starters.append(chikorita)
        starters.append(torchic)
        starters.append(mudkip)
        starters.append(treecko)
        starters.append(chimchar)
        starters.append(piplup)
        starters.append(turtwig)
        starters.append(tepig)
        starters.append(oshawott)
        starters.append(snivy)
        starters.append(fennekin)
        starters.append(froakie)
        starters.append(chespin)
        starters.append(litten)
        starters.append(popplio)
        starters.append(rowlet)
        
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        starterImage.alpha = 0
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        UIView.animate(withDuration: 2, animations: {
            self.starterImage.alpha = 1
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        populateStarters()
        setLabels()
        if let savedCount = UserDefaults.standard.value(forKey: "count") as? Int {
            moveCount = savedCount
        }
        movesUsed.text = "\(moveCount)"
    }
    
    func PullImage(imagePath:String) -> UIImage {
        var downloadedImage = UIImage()
        
        let imageURL = URL(string:imagePath)
        
        let imgBytes = try? Data(contentsOf: imageURL!)
        
        print(imgBytes ?? "Error! Image doesn't exist at the URL \(imageURL!)")
        
        downloadedImage = UIImage(data:imgBytes!)!
        
        return downloadedImage
    }

}

