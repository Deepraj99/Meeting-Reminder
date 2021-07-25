import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  MultiSelectDialog({required this.items, required this.initialSelectedValues});

  final List<MultiSelectDialogItem<V>> items;
  final Set<V> initialSelectedValues;

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = Set<V>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Days',
        style: GoogleFonts.lato(fontWeight: FontWeight.w700),
      ),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        InkWell(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "Cancle",
              style: GoogleFonts.lato(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          onTap: () => _onCancelTap,
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "OK",
              style: GoogleFonts.lato(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          onTap: () => _onSubmitTap,
        ),
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked!),
    );
  }
}

// ===================

class MultiSelecting extends StatefulWidget {
  @override
  _MultiSelectingState createState() => _MultiSelectingState();
}

class _MultiSelectingState extends State<MultiSelecting> {
  String value = "";
  List<DropdownMenuItem<String>> menuitems = [];
  bool disabledropdown = true;

  void secondselected(_value) {
    setState(() {
      value = _value;
    });
  }

  List<MultiSelectDialogItem<int>> multiItem = [];

  final valuestopopulate = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday",
  };

  void populateMultiselect() {
    for (int v in valuestopopulate.keys) {
      multiItem.add(MultiSelectDialogItem(v, valuestopopulate[v].toString()));
    }
  }

  void _showMultiSelect(BuildContext context) async {
    multiItem = [];
    populateMultiselect();
    final items = multiItem;

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: [1].toSet(),
        );
      },
    );

    print(selectedValues);
    getvaluefromkey(selectedValues!);
  }

  void getvaluefromkey(Set selection) {
    if (selection != null) {
      for (int x in selection.toList()) {
        print(valuestopopulate[x]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
      ),
      onTap: () => _showMultiSelect(context),
    );
  }
}
