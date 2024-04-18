import 'package:flutter/material.dart';
import 'package:marvel_heroes/data/services/get_heroes_service.dart';
import 'package:marvel_heroes/domain/entities/hero.dart';
import 'package:marvel_heroes/ui/theme/colors.dart';
import 'package:marvel_heroes/ui/widgets/list_heroes.dart';
import 'package:marvel_heroes/ui/widgets/paginate.dart';
import 'package:marvel_heroes/ui/widgets/search_form_heroes.dart';

class HeroesView extends StatefulWidget {
  const HeroesView({super.key});

  @override
  HeroesViewState createState() => HeroesViewState();
}

class HeroesViewState extends State<HeroesView> {
  final TextEditingController _controller = TextEditingController();
  final MarvelGetHeroesService _apiService = MarvelGetHeroesService();
  List<HeroEntity> _heroes = [];
  List<HeroEntity> _paginateList = [];
  int _currentPage = 1;
  final int _itemsPerPage = 4;

  void _search() {
    _apiService.fetchHeroes(_controller.text).then((heroes) {
      setState(() {
        _heroes = heroes;
        _paginateList = heroes.sublist(0, 4);
        _currentPage = 1;
      });
    });
  }

  void _nextPage() {
    int currentPage = _currentPage + 1;
    int start = currentPage * _itemsPerPage - 4;
    int end = currentPage * _itemsPerPage;
    setState(() {
      _currentPage = currentPage;
      _paginateList = _currentPage == ((_heroes.length / _itemsPerPage).ceil())
          ? _heroes.sublist(start, _heroes.length)
          : _heroes.sublist(start, end);
    });
  }

  void _previousPage() {
    int currentPage = _currentPage - 1;
    int start = currentPage * _itemsPerPage - 4;
    int end = currentPage * _itemsPerPage;
    setState(() {
      _currentPage = currentPage;
      _paginateList = _currentPage == ((_heroes.length / _itemsPerPage).ceil())
          ? _heroes.sublist(start, _heroes.length)
          : _heroes.sublist(start, end);
    });
  }

  void _onPage(int page) {
    int currentPage = page;
    int start = currentPage * _itemsPerPage - 4;
    int end = currentPage * _itemsPerPage;
    setState(() {
      _currentPage = currentPage;
      _paginateList = _currentPage == ((_heroes.length / _itemsPerPage).ceil())
          ? _heroes.sublist(start, _heroes.length)
          : _heroes.sublist(start, end);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.primaryColor.color,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      'BUSCA',
                      style: TextStyle(
                        color: AppColors.primaryColor.color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text('MARVEL',
                      style: TextStyle(
                        color: AppColors.primaryColor.color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(width: 3),
                  Text('TESTE FRONT-END',
                      style: TextStyle(
                        color: AppColors.primaryColor.color,
                        fontSize: 16,
                      )),
                ],
              ),
            ),
            SearchFormHeroes(controller: _controller, onSearch: _search),
            Expanded(child: ListHeroesListView(heroes: _paginateList)),
            Paginate(
                currentPage: _currentPage,
                totalPages: (_heroes.length / _itemsPerPage).ceil(),
                onPreviousPage: _previousPage,
                onNextPage: _nextPage,
                onPageSelected: _onPage),
          ],
        ),
      ),
    );
  }
}
