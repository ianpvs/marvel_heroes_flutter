import 'package:flutter/material.dart';
import 'package:marvel_heroes/ui/theme/colors.dart';

class Paginate extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;
  final Function(int) onPageSelected;

  const Paginate({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPreviousPage,
    required this.onNextPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor.color),
          onPressed: currentPage == 1 ? null : onPreviousPage,
        ),
        ...List.generate(
          3,
          (index) {
            int page = currentPage + index;
            return page <= totalPages
                ? Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: AppColors.primaryColor.color, width: 1),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: page == currentPage
                            ? AppColors.whiteColor.color
                            : AppColors.primaryColor.color,
                        backgroundColor: page == currentPage
                            ? AppColors.primaryColor.color
                            : AppColors.whiteColor.color,
                      ),
                      onPressed: () => onPageSelected(page),
                      child: Text(page.toString()),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward, color: AppColors.primaryColor.color),
          onPressed: currentPage == totalPages ? null : onNextPage,
        ),
      ],
    );
  }
}
