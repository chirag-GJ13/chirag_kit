import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CKApiDropDown<T> extends StatelessWidget {
  final String? label;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  final String? hint;
  final bool isRequired;
  final FutureOr<List<T>> Function(String, LoadProps?)? items;
  final T? selectedItem;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? itemAsString;
  final Widget Function(BuildContext, T)? itemBuilder;

  final bool showSearchBox;
  final bool Function(T, T)? compareFn;
  final String? Function(T?)? validator;

  const CKApiDropDown({
    super.key,
    required this.label,
    this.labelStyle,
    this.hintStyle,
    this.hint, //
    this.isRequired = false, //

    required this.items,
    this.selectedItem,
    this.onChanged,
    this.itemAsString,
    this.showSearchBox = true,
    this.compareFn,
    this.validator,
    this.itemBuilder,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Label ─────────────────────────────────────────
        if (label != null && label!.trim().isNotEmpty) ...[
          Text(
            isRequired ? '$label *' : label!,
            style:
                labelStyle ??
                TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 1.h),
        ],

        /// ---------- DROPDOWN ----------
        DropdownSearch<T>(
          items: items,
          selectedItem: selectedItem,
          compareFn: compareFn,
          popupProps: PopupProps.menu(
            showSearchBox: showSearchBox,
            fit: FlexFit.loose,
            itemBuilder: (context, item, isDisabled, isSelected) {
              if (itemBuilder != null) {
                return itemBuilder!(context, item);
              }

              // fallback
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Text(
                  itemAsString?.call(item) ?? item.toString(),
                  style: TextStyle(
                    // ✅ Project specific nahi
                    fontSize: 13,
                    fontWeight:
                        isSelected // ✅ isSelected use kar sakte ho
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              );
            },
          ),
          itemAsString: itemAsString,
          onChanged: (v) {
            FocusScope.of(context).unfocus();
            onChanged?.call(v);
          },
          validator: validator,
        ),

        if (label != null && label!.trim().isNotEmpty) ...[
          SizedBox(height: 2.h),
        ],
      ],
    );
  }
}
