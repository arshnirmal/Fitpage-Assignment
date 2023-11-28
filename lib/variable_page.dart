import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fitpage_assignment/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VariablesPage extends StatelessWidget {
  final Map<String, dynamic> variable;
  const VariablesPage({super.key, required this.variable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          color: Theme.of(context).primaryColor,
          child: variable['type'] == 'value'
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: variable['values'].length,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  itemBuilder: (context, index) {
                    final values = List.from(variable['values']);
                    values.sort((a, b) => a.abs().compareTo(b.abs()));

                    // debugPrint("Values: $values variable: $variable");

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${values[index]}',
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: DottedDecoration(
                            shape: Shape.line,
                            linePosition: LinePosition.bottom,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                )
              : variable['type'] == 'indicator'
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${variable['study_type']}'.toUpperCase(),
                            style: Theme.of(context).textTheme.titleMedium!,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Set Parameters',
                            style: Theme.of(context).textTheme.bodySmall!,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: Colors.white,
                            height: 100,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '${variable['parameter_name'].toString()[0].toUpperCase()}${variable['parameter_name'].toString().substring(1)}',
                                    style: Theme.of(context).textTheme.bodySmall!.merge(
                                          const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 150,
                                  child: TextFormField(
                                    initialValue: '${variable['default_value']}',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      NumericalRangeFormatter(
                                        min: int.parse(variable['min_value'].toString()),
                                        max: int.parse(variable['max_value'].toString()),
                                      )
                                    ],
                                    cursorHeight: 16,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    style: Theme.of(context).textTheme.bodySmall!.merge(
                                          const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
