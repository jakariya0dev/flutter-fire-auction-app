import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:auction_app/controllers/common_controller.dart';
import 'package:flutter/material.dart';

import '../models/chart_data.dart';
import '../widgets/dash_box.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {

    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {

    // find all active bid
    List runningBids = CommonController.data
        .where(
            (e) => DateTime.parse(e['lastDate']).compareTo(DateTime.now()) > 0)
        .toList();

    // find all completed bid
    List completedBids = CommonController.data
        .where(
            (e) => DateTime.parse(e['lastDate']).compareTo(DateTime.now()) < 0)
        .toList();

    
    int totalAmountOfCompletedBids = 0;
    List<BidData> dataForChart = [];

    // Calculating Total Amount Of Complete Bids
    for (var item in completedBids) {
      List<int> allBidsInSingleItem = [0];

      for (var i in item['bids']) {
        allBidsInSingleItem.add(int.parse(i['price']));
      }
      totalAmountOfCompletedBids = totalAmountOfCompletedBids + allBidsInSingleItem.reduce(max);

      // adding data for chart
      dataForChart.add(BidData(DateTime.parse(item['lastDate']), allBidsInSingleItem.reduce(max)));

      // print(allBidsInSingleItem);

    }



    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              BuildBoxContent(
                title: 'Total running bids',
                value: runningBids.length.toString(),
                color: Colors.brown,
                isLoading: false,
              ),
              BuildBoxContent(
                title: 'Total completed bids',
                value: completedBids.length.toString(),
                color: Colors.deepOrangeAccent,
                isLoading: false,
              )
            ],
          ),
          Row(
            children: [
              BuildBoxContent(
                title: 'total value of completed bids',
                value: totalAmountOfCompletedBids.toString(),
                color: Colors.purple,
                isLoading: false,
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<BidData, DateTime>(
                        dataSource: dataForChart,
                        xValueMapper: (BidData bidData, _) => bidData.date,
                        yValueMapper: (BidData bidData, _) => bidData.bid
                    )
                  ]
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> initData() async {
    await CommonController().fetchAllData();
    setState(() {});
  }
}
