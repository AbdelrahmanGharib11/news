import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/theme/apptheme.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchEditingController = TextEditingController();
  bool ischanged = false;

  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 21, right: 16, left: 16),
          child: Column(
            children: [
              SizedBox(
                height: screendim.height * 0.08,
                child: TextFormField(
                  style: textTheme.labelSmall,
                  cursorColor: AppTheme.secondary,
                  controller: searchEditingController,
                  onChanged: (query) {
                    // context.read<SearchMovieCubit>().searchMovies(query);
                    // ischanged = query.isNotEmpty;
                    // if (query.length <= 1) {
                    //   setState(() {});
                    // }
                  },
                  maxLines: 2,
                  onTapOutside:
                      (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: textTheme.labelSmall,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppTheme.secondary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppTheme.secondary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppTheme.secondary,
                      ),
                    ),

                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: AppTheme.secondary,
                    ),
                    suffixIcon: Icon(
                      CupertinoIcons.multiply,
                      color: AppTheme.secondary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                    child: Text('No Results..!', style: textTheme.displaySmall),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
