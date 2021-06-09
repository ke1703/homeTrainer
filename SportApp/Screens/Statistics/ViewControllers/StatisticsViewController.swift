import Foundation
import UIKit
import RealmSwift
import Charts

final class StatisticsViewController: ViewController<StatisticsView> {
    
    // MARK: - Properties.
    
    var statistics = [ProfileStatisticModel]()
    var lineChartEntry = [ChartDataEntry]()
    var lineChartEntryWorkoutInDay = [ChartDataEntry]()
    var models = [SortedStaticsticModel]()
    
    // MARK: - Lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        convertSatisticToModel()
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - User Interaction
    
    func convertSatisticToModel() {
        models.removeAll()
        let realm = try! Realm()
        // берем список статистики из базы и сортируем по дате по убыванию
        statistics = Array(realm.objects(ProfileStatisticModel.self)).sorted(by: { $0.endTime > $1.endTime})

        guard !statistics.isEmpty else {
            ui.stackView.isHidden = false
            ui.graphicView.isHidden = true
            ui.tableView.isHidden = true
            return
        }
        var dataArray = [String]()
        // проходим по всему списку статистики
        for item in statistics {
            // форматируем дату начала к строке число месяц год
            let date = Date(timeIntervalSince1970: TimeInterval(item.startTime))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd MMM yyyy"
            let strDate = dateFormatter.string(from: date)
            dateFormatter.dateFormat = "dd"
            let number = dateFormatter.string(from: date)
            
            // проверяем есть ли в модели статистики такая как в дате и добавляемм тренировку в нее
            if let index = models.firstIndex(where: {$0.sectionName == strDate}) {
                models[index].statisticsModel.append(item)
            } else { // есили нет создаем и добавляем в массив
                let newModel = SortedStaticsticModel(sectionName: strDate, number: number, statisticsModel: [item])
                models.append(newModel)
                dataArray.append(number)
            }
        }
        
        for model in models.sorted(by: {$0.number < $1.number}) {
            let value = ChartDataEntry(x: Double(model.number) ?? 0, y: Double(round(Double(100*model.statisticsModel.first!.weight))/100) )
            lineChartEntry.append(value)
        }
        
        ui.tableView.reloadData()
        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Вес")
        line1.circleColors = [UIColor.textBordo]
        line1.colors = [UIColor.textBordo]

        let data = LineChartData()
        data.addDataSet(line1)
        let marker = BalloonMarker(color: #colorLiteral(red: 0.7256732583, green: 0.1117082015, blue: 0.08233308047, alpha: 1),
                                   font: .systemFont(ofSize: 14),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = ui.graphicView
        marker.minimumSize = CGSize(width: 80, height: 40)
        ui.graphicView.marker = marker
        ui.graphicView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataArray)
        ui.graphicView.xAxis.setLabelCount(dataArray.count, force: true)

        let leftAxis = ui.graphicView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        ui.graphicView.rightAxis.enabled = false
        ui.graphicView.data = data
    }
}

extension StatisticsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].statisticsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // настройка ячейки
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTableViewCell.reuseID) as! StatisticsTableViewCell
        // достали и прописали название тренировки (статистика тип + "перенос строки" + статистика имя тренировки)
        cell.workoutNameLabel.text = models[indexPath.section].statisticsModel[indexPath.row].type + "\n" + models[indexPath.section].statisticsModel[indexPath.row].workoutName
        // вес пользователя statistics.
        cell.weightTextLabel.text = String( models[indexPath.section].statisticsModel[indexPath.row].weight) + " кг"
        //заполняем картинку
        cell.iconImageView.image = getImage(name: models[indexPath.section].statisticsModel[indexPath.row].workoutName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].sectionName
    }

    private func getImage(name: String) -> UIImage? {
        switch name {
        case "Пресс":
            return UIImage(named: "icons8-пресс-96")
        case "Грудь":
            return UIImage(named: "icons8-грудь-96")
        case "Руки":
            return UIImage(named: "icons8-fit-96")
        case "Ноги":
            return UIImage(named: "icons8-четырехглавая-мышца-96")
        case "Плечи и спина":
            return UIImage(named: "icons8-плечи-96")
        default:
            return nil
        }
    }
}

