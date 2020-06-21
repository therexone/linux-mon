import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linux_mon/utils/dark_theme_script.dart';
import 'package:linux_mon/utils/data_parser.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class CpuPage extends StatefulWidget {
  CpuPage(this.stream);
  final Stream stream;

  @override
  _CpuPageState createState() => _CpuPageState();
}

class _CpuPageState extends State<CpuPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List _data = [
    {'name': DateTime.now().millisecondsSinceEpoch, 'value': 0}
  ];

  String jsonData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          double clockspeed = dataParserFromJson(snapshot.data).cpuFreq[0];

          if (_data.length > 20) {
            _data.removeAt(0);
          }
          _data.add({
            'name': DateTime.now().millisecondsSinceEpoch,
            'value': clockspeed.round()
          });
          // print(jsonData);
          // print(_data);
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: snapshot.hasData
              ? Center(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                        padding: EdgeInsets.all(8.0),
                        child: Echarts(
                          extensions: [darkThemeScript],
                          theme: 'dark',
                          option: '''
                                 {
                      dataset: {
                        dimensions: ['name', 'value'],
                        source: ${jsonEncode(_data)},
                      },
                    grid: {
                        left: '15%',
                        right: '0%',
                        bottom: '15%',
                        top: '15%'
                      },

                          xAxis: {
                              type: 'time',
                              splitLine: {
                                  show: false
                              },
                              axisLine: {
                                  lineStyle: {
                                  color: '#ffffffa0'
                                }
                              }
                          },
                          yAxis: {
                              type: 'value',
                              boundaryGap: [0, '10%'],
                              splitLine: {
                                  show: false
                              },
                              name: 'MHz',
                                axisLine: {
                                  lineStyle: {
                                  color: 'rgba(255, 255, 255, 0.6)'
                                }
                              },


                          },
                          series: [{
                              type: 'line',
                              showSymbol: false,
                              hoverAnimation: false,
                              name: 'data',
                              type: 'line',
                              itemStyle: {
                                  color: '#FB4A4A'
                              },
                                areaStyle: {
                                  color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                      offset: 0,
                                      color: 'rgba(255, 158, 68, 0.2)'
                                  }, {
                                      offset: 1,
                                      color: 'rgba(255, 70, 131, 0.2)'
                                  }])
                              },
                             
                          }]
                    }

                  ''',
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 250,
                      ),
                      Text(
                        dataParserFromJson(snapshot.data).cpuFreq.toString(),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text('No data'),
                ),
        );
      },
    );
  }
}
