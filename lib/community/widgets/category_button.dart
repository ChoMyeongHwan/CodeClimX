import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({super.key});

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  String selectedButtonText = 'All';
  List<String> buttonTexts = [
    'All',
    'Full stack',
    'Frontend',
    'Backend',
    'AI',
    'Data Science'
  ];

  void onClick(int index) {
    setState(() {
      selectedButtonText = buttonTexts[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 15),
          height: 150,
          margin: const EdgeInsets.only(bottom: 0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
            itemCount: buttonTexts.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 30),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  onClick(index);
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: selectedButtonText == buttonTexts[index]
                            ? const Color(0xFF9283FF)
                            : const Color(0xFFC6BEFF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      buttonTexts[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 70, 70, 70),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
