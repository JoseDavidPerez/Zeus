//
//  ChartView.swift
//  Zeus
//
//  Created by osx on 30/07/22.
//

import Foundation
import UIKit
import Charts

class ChartView : UIViewController {
    
    var presenter : ChartPresenter?
    
    private var chartViewReport: PieChartView?
    
    private var chartViewCompanies: PieChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        
    
    }
    func setupChart(){
        
        let chartView = PieChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.chartDescription.enabled = false
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        chartView.drawCenterTextEnabled = true
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: "Esta limpia la sucursal?")
        chartView.centerAttributedText = centerText;
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        
        chartView.delegate = self
        
        chartViewReport = chartView
    }
    
    func setupChartCompany(){
        let chartView = PieChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.chartDescription.enabled = false
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        chartView.drawCenterTextEnabled = true
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: "Que empresa cuenta con medidas de seguridad")
        
        
        chartView.centerAttributedText = centerText;
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        
        chartView.delegate = self
        
        chartViewCompanies = chartView
    }
    func setupUI(){
        
        setupChart()
        setupChartCompany()
        self.view.addSubview(chartViewReport!)
        self.view.addSubview(chartViewCompanies!)
        self.presenter?.getInformation()
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
        self.chartViewReport!.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
        self.chartViewReport!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
        self.chartViewReport!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        self.chartViewReport!.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4),
        
        
        self.chartViewCompanies!.topAnchor.constraint(equalTo: self.chartViewReport!.bottomAnchor, constant: 20),
        self.chartViewCompanies!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
        self.chartViewCompanies!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        self.chartViewCompanies!.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        ])
        
    }
    func setupReport(data:[Report]){
        let entries = data.map { item -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(item.quantity) ?? 0, label: item.value)
        }
        let set = PieChartDataSet(entries:entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        set.colors = ChartColorTemplates.vordiplom()
                    + ChartColorTemplates.joyful()
                    + ChartColorTemplates.colorful()
                    + ChartColorTemplates.liberty()
                    + ChartColorTemplates.pastel()
                    + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        let data = PieChartData(dataSet: set)
        chartViewReport!.data = data
    }
    
    func setupCompany(data:[Company]){
        
        let entries = data.map { item -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(item.percentage) ?? 0, label: item.name)
        }
        let set = PieChartDataSet(entries:entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        set.colors = ChartColorTemplates.vordiplom()
                    + ChartColorTemplates.joyful()
                    + ChartColorTemplates.colorful()
                    + ChartColorTemplates.liberty()
                    + ChartColorTemplates.pastel()
                    + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        let data = PieChartData(dataSet: set)
        chartViewCompanies!.data = data
    }
    
}

extension ChartView : ChartViewDelegate {
    
}

extension ChartView : ChartViewProtocol {
    
    func showError() {
        print("alert")
    }
    
    func reloadData(response: ResponseTest) {
        setupReport(data: response.reports)
        setupCompany(data: response.companies)
        
    }
    
    
}
