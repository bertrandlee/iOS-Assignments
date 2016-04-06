//
//  ViewController.swift
//  iOS-Lesson8-Blackjack
//
//  Created by Bertrand Lee on 6/4/16.
//  Copyright © 2016 Bertrand Lee. All rights reserved.
//

import UIKit

// This class represents a single card
public class Card
{
    private var value:Int
    private var suit:Int
    
    private let suitNames:[String] = ["Clubs", "Diamonds", "Hearts", "Spades"]
    private let cardNames:[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
    private let cardValues:[Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1]
    
    init()
    {
        value = Int(arc4random_uniform(14))
        suit = Int(arc4random_uniform(4))
    }
    
    // This returns the name of the card (eg. "K-Spades")
    public func getName() -> String
    {
        return cardNames[value] + "-" + suitNames[suit]
    }
    
    // This returns the actual value of the card (eg. Ace is 1)
    public func getActualValue() -> Int
    {
        return cardValues[value]
    }
    
    // This comparator method returns whether the passed in card param has the same value/suit as this object
    public func isEqual(card:Card) -> Bool
    {
        return (card.value == value) && (card.suit == suit)
    }
}

// This class represents a deck of cards
public class CardDeck
{
    private var dealtCards:[Card] = []
    
    // This helper function returns whether the passed in card has been previously dealt
    private func hasCardBeenDealt(newCard:Card) -> Bool
    {
        for card in dealtCards
        {
            if (card.isEqual(newCard))
            {
                return true
            }
        }
        
        return false
    }
    
    // This resets the card deck (emptying dealt card array)
    public func Reset()
    {
        dealtCards.removeAll()
    }
    
    // This deals a unique card (and adds it to the dealt card array)
    public func dealCard() -> Card
    {
        var uniqueCardFound:Bool = false
        var newCard:Card = Card()
        
        while (!uniqueCardFound)
        {
            if (hasCardBeenDealt(newCard))
            {
                // Card was previously dealt - continue searching
                newCard = Card()
            }
            else
            {
                // Card is unique - deal it
                uniqueCardFound = true
            }
        }
        
        // Add new unique card to dealt cards array
        dealtCards.append(newCard)
        
        return newCard
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var card1Label: UILabel!
    @IBOutlet weak var card2Label: UILabel!
    @IBOutlet weak var card3Label: UILabel!
    @IBOutlet weak var card4Label: UILabel!
    
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var walkButton: UIButton!
    @IBOutlet weak var retryButton: UIButton!
    
    var totalScore:Int = 0
    var averageScore:Int = 0
    var round:Int = 1
    var cardIndex:Int = 0
    
    var cardDeck:CardDeck = CardDeck()
    
    
    @IBAction func onHitButtonPressed(sender: AnyObject)
    {
        let card:Card = cardDeck.dealCard()
        
        // Update total score and played card labels
        walkButton.hidden = false
        totalScore += card.getActualValue()
        totalLabel.text = String(totalScore)
        updateCardLabel(card)

        // Update UI elements if we have busted
        if (totalScore > 21)
        {
            statusLabel.text = "BUST"
            statusLabel.hidden = false
            hitButton.hidden = true
            walkButton.hidden = true
            retryButton.hidden = false
            updateAverageScore()
        }
    }
    
    @IBAction func onWalkButtonPressed(sender: AnyObject)
    {
        if (totalScore < 21)
        {
            // Update UI elements if user decides to walk
            statusLabel.text = "Walked with " + String(totalScore)
            statusLabel.hidden = false
            hitButton.hidden = true
            walkButton.hidden = true
            retryButton.hidden = false
            updateAverageScore()
        }
    }
    
    @IBAction func onRetryButtonPressed(sender: AnyObject)
    {
        // Increment round counter and reset UI elements if user starts another round
        round += 1
        initUI()
        hitButton.hidden = false
        walkButton.hidden = true
        cardDeck.Reset()
    }
    
    
    // Computes average score based on running average
    func updateAverageScore()
    {
        averageScore = ((averageScore * (round - 1)) + totalScore) / round
        averageLabel.text = String(averageScore)
    }
    
    // Update played card labels and increments card label index
    func updateCardLabel(card:Card)
    {
        switch cardIndex
        {
        case 0:
            card1Label.text = card.getName()
            card1Label.hidden = false
            
        case 1:
            card2Label.text = card.getName()
            card2Label.hidden = false
            
        case 2:
            card3Label.text = card.getName()
            card3Label.hidden = false
            
        case 3:
            card4Label.text = card.getName()
            card4Label.hidden = false
            
        default:
            print("Warning: Overran card labels with card of value " + card.getName())
        }
        
        cardIndex += 1
    }

    // Hide all card labels
    func hideAllCards()
    {
        card1Label.hidden = true
        card2Label.hidden = true
        card3Label.hidden = true
        card4Label.hidden = true
    }
    
    // Initialize UI elements - used during app start and new round
    func initUI()
    {
        roundLabel.text = String(round)
        totalLabel.text = String(0)
        totalScore = 0
        cardIndex = 0
        hideAllCards()
        statusLabel.hidden = true
        retryButton.hidden = true
        walkButton.hidden = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI()
        averageLabel.text = String(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

