import UIKit

struct Play {
    let contents: [String: PlayContent] = [
        "hamlet": PlayContent(name: "Hamlet", type: "tragedy"),
        "asLike": PlayContent(name: "As You Like It", type: "comedy"),
        "othello": PlayContent(name: "Othello", type: "tragedy")
    ]
}

struct PlayContent {
    let name: String
    let type: String
}

struct Invoice {
    let customer: String = "BigCo"
    let performances: [Performances] = [Performances(playID: "hamlet", audience: 55),
                                        Performances(playID: "asLike", audience: 35),
                                        Performances(playID: "othello", audience: 40)]
}

struct Performances {
    let playID: String
    let audience: Int
}

let result = statement(invoice: Invoice(), plays: Play())
print(result)

/*
func statement(invoice: Invoice, plays: Play) -> String {
    var totalAmount = 0
    var volumeCredits = 0
    var result = "청구 내역 (고객명: \(invoice.customer))\n"

    let format = NumberFormatter()
    format.numberStyle = .currency
    format.currencyCode = "USD"
    format.minimumFractionDigits = 2

    for performance in invoice.performances {
        guard let play = plays.contents[performance.playID] else { continue }
        var thisAmount = 0

        switch play.type {
        case "tragedy": // 비극
            thisAmount = 40000
            if performance.audience > 30 {
                thisAmount += 1000 * (performance.audience - 30)
            }
        case "comedy":  // 희극
            thisAmount = 30000
            if performance.audience > 20 {
                thisAmount += 1000 + 500 * (performance.audience - 20)
            }
            thisAmount += 300 * performance.audience
        default:
            print("Error: 알수 없는 장르 \(play.type)")
        }

        volumeCredits += max(performance.audience - 30, 0)

        if "comedy" == play.type {
            let credit = floor(Float(performance.audience) / 5.0)
            volumeCredits += Int(credit)
        }

        result += " \(play.name): \(format.string(from: NSNumber(value: thisAmount/100)) ?? "") (\(performance.audience) 석)\n"
        totalAmount += thisAmount
    }

    result += "총액: \(format.string(from: NSNumber(value: totalAmount/100)) ?? "")\n"
    result += "적립 포인트: \(volumeCredits) 점\n"
    return result
}
*/



/// 1. HTLM로 청구 내역을 출력 하는 기능 추가
///     - 청구 결과에 문자열을 추가하는 문장 각각을 조건문으로 감싸야 함.
/// 2. 더 많은 장르의 연기 추가


// 함수 쪼개기
// 변수 이름 변경

func statement(invoice: Invoice, plays: Play) -> String {

    func amountFor(aPerformance: Performances, play: PlayContent) -> Int {
        var result = 0

        switch play.type {
        case "tragedy": // 비극
            result = 40000
            if aPerformance.audience > 30 {
                result += 1000 * (aPerformance.audience - 30)
            }
        case "comedy":  // 희극
            result = 30000
            if aPerformance.audience > 20 {
                result += 1000 + 500 * (aPerformance.audience - 20)
            }
            result += 300 * aPerformance.audience
        default:
            print("Error: 알수 없는 장르 \(play.type)")
        }

        return result // 함수 안에서 값이 바뀌는 변수 반환
    }

    var totalAmount = 0
    var volumeCredits = 0
    var result = "청구 내역 (고객명: \(invoice.customer))\n"

    let format = NumberFormatter()
    format.numberStyle = .currency
    format.currencyCode = "USD"
    format.minimumFractionDigits = 2

    for performance in invoice.performances {
        guard let play = plays.contents[performance.playID] else { continue }

        let thisAmount = amountFor(performance: performance, play: play)

        volumeCredits += max(performance.audience - 30, 0)

        if "comedy" == play.type {
            let credit = floor(Float(performance.audience) / 5.0)
            volumeCredits += Int(credit)
        }

        result += " \(play.name): \(format.string(from: NSNumber(value: thisAmount/100)) ?? "") (\(performance.audience) 석)\n"
        totalAmount += thisAmount
    }

    result += "총액: \(format.string(from: NSNumber(value: totalAmount/100)) ?? "")\n"
    result += "적립 포인트: \(volumeCredits) 점\n"
    return result
}
