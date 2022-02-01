import 'package:flutter/material.dart';
import 'package:flutter_estudos_mvvm/infrastructure/dal/sembast/entities/sembast_pessoa_entity.dart';
import 'package:flutter_estudos_mvvm/presentation/view_model/home_view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  final String title = 'HomeView';
  const HomeView({Key? key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.getListaPessoa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () async {},
          icon: Icon(Icons.all_inbox),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              homeViewModel.deleteAll();
            },
            icon: Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () async {
              homeViewModel.addAll();
            },
            icon: Icon(Icons.add),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<List<SembastPessoaEntity>>(
                valueListenable: homeViewModel.listaPessoa,
                builder: (context, listaPessoas, widget) {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.blue.withAlpha(120),
                        thickness: 1.3,
                        height: 0,
                      );
                    },
                    itemCount: homeViewModel.listaPessoa.value.length,
                    itemBuilder: (context, index) {
                      return ValueListenableBuilder<List<int>>(
                        valueListenable: homeViewModel.selectedItem,
                        builder: (context, selectedItem, widget) {
                          return InkWell(
                            onTap: () {
                              homeViewModel.setSelectedIten(index);
                            },
                            child: Container(
                              height: 85,
                              color: selectedItem.contains(index) ? Colors.blue.withAlpha(80) : Colors.transparent,
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        listaPessoas[index].id.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        listaPessoas[index].nome ?? '',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
