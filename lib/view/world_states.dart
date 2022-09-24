import 'package:corona_project/Model/WorlsStatsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/states_services.dart';
import 'countries_list.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              FutureBuilder(
                  future: statsServices.fecthWorldStatsRecords(),
                  builder: (context, AsyncSnapshot<WorlsStatsModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: _controller,
                          ));
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total":
                                  double.parse(snapshot.data!.cases!.toString()),
                              "Recovered":
                                  double.parse(snapshot.data!.cases!.toString()),
                              "Death":
                                  double.parse(snapshot.data!.cases!.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .05),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                    title: 'total',
                                    value: snapshot.data!.cases.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Death',
                                    value: snapshot.data!.deaths.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Active Cases',
                                    value: snapshot.data!.active.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Critical cases',
                                    value: snapshot.data!.critical.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Today Death',
                                    value: snapshot.data!.todayDeaths.toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                            GestureDetector(
                              onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesList()));
                    },

                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text("Track Countries"),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 20),
      child: Column(
        children: [
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
