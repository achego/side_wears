import 'package:building_ui/exports/exports.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 15.0.h, vertical: 30.0.h),
              child: CustomTextField(
              labelText: 'Search',
                controller: searchController,
                obscureText: false,
                suffixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const Align(
                alignment: Alignment.bottomCenter, child: Text('NO Item Found'))
          ],
        ),
      ),
    );
  }
}
