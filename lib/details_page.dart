import 'package:fitpage_assignment/data_model.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Items item;
  const DetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          item.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: const Color.fromRGBO(15, 76, 117, 1),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          color: const Color.fromRGBO(27, 38, 44, 1),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: const Color.fromRGBO(15, 76, 117, 1),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Text(
                      item.tag,
                      style: TextStyle(
                        color: item.color == 'red'
                            ? const Color.fromRGBO(255, 0, 0, 1)
                            : item.color == 'green'
                                ? const Color.fromRGBO(0, 255, 0, 1)
                                : const Color.fromRGBO(0, 0, 255, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.separated(
                itemCount: item.criteria.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'and',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                itemBuilder: (context, index) {
                  final criteria = item.criteria[index];

                  return RichText(
                    text: TextSpan(
                      children: getCriteria(criteria, context),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
