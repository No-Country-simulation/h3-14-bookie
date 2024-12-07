import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

class BookNavigation extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final bool adding;
  final VoidCallback? addingAction;
  final Function(int page) changePage;
  final bool thirdOption;
  final VoidCallback? thirdOptionAction;
  const BookNavigation({
    super.key,
    required this.totalPages,
    required this.currentPage,
    this.adding = false,
    this.addingAction,
    required this.changePage,
    this.thirdOption = false,
    this.thirdOptionAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: thirdOption ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: (){
              if((currentPage - 1) >= 0){
                  changePage(currentPage-1);
                }
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.accentColor,
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                currentPage == 0
                ? AppColors.secondaryColor 
                :AppColors.primaryColor
              )
            )
          ),
          if(!thirdOption)
          ...[
            const SizedBox(width: 20,),
            Expanded(
              child: LinearProgressIndicator(
                backgroundColor: const Color(0xFFDADADA),
                value: (currentPage+1) / totalPages,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                minHeight: 5,
              )
            ),
            const SizedBox(width: 20,),
          ],
          if(thirdOption)
          IconButton(
            onPressed: thirdOptionAction != null ? ()=>thirdOptionAction!() : null,
            icon: const Icon(
              Icons.add,
              color: AppColors.accentColor,
              ),
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AppColors.primaryColor
              )
            )
          ),
          IconButton(
            onPressed: totalPages == (currentPage + 1)
              ? adding
                ? () {
                  if(addingAction!=null){
                    addingAction!();
                  }
                }
                : null 
              : (){
                if((currentPage + 1) <= totalPages){
                  changePage(currentPage+1);
                }
              },
            icon: Icon(
              adding && totalPages == (currentPage + 1)? Icons.add :Icons.arrow_forward_rounded,
              color: AppColors.accentColor,
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                (currentPage / totalPages) == 1 && !adding
                ? AppColors.secondaryColor 
                :AppColors.primaryColor,)
            ),
          )
        ],
      ),
    );
  }
}