import 'package:flutter/material.dart';

import '../data/animal_data.dart';
import '../model/animal.dart';
import '../view/detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Animal> _foundAnimalData = animalDataList;

  void _onSearch(String keyword) {
    List<Animal> result = [];

    if (keyword.isEmpty) {
      result = animalDataList;
    } else {
      result = animalDataList
          .where(
              (data) => data.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundAnimalData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Animal Encyclopedia'),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    border: UnderlineInputBorder(),
                    labelText: 'Search'),
                onChanged: (value) {
                  _onSearch(value);
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final Animal animal = _foundAnimalData[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(animal: animal),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Image.asset(
                                animal.photo[0],
                                width: 200,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 4.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      animal.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(animal.tag.join(', ')),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _foundAnimalData.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
