
import 'package:call_log/call_log.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../custom_colors.dart';
import '../widgets/call_log_item.dart';

class RecentsCallLogScreen extends StatefulWidget {
  final Iterable<CallLogEntry> allCallLogs;
  final List<CallLogEntry> entry;

  RecentsCallLogScreen({Key? key, required this.allCallLogs
    ,required this.entry
  }) : super(key: key);

  @override
  State<RecentsCallLogScreen> createState() => _RecentsCallLogScreenState();
}

class _RecentsCallLogScreenState extends State<RecentsCallLogScreen> {
  TextEditingController _searchController = TextEditingController();
  // List<Contact> allContacts = [];
  // List<Contact> filteredAllContacts = [];
  List<CallLogEntry> entries = [];
  List<CallLogEntry> filteredEntries = [];

  getAllCallLogEntries()async{
    Iterable<CallLogEntry> callLogEntries =
    await CallLog.get();
    setState(() {
      entries = callLogEntries.toList();
    });
  }
  /* void filteredContacts() {
    List<CallLogEntry> callLogEntries = entries.toList();
    if (_searchController.text.isNotEmpty) {
      callLogEntries = callLogEntries.where((log) {
        String searchTerm = _searchController.text.toLowerCase();
        String logName = log.name?.toLowerCase() ?? '';
        return logName.contains(searchTerm);
      }).toList();

      setState(() {
        filteredEntries = callLogEntries;
      });
    } else {
      setState(() {
        filteredEntries = [];
      });
    }
  }*/
  void filteredContacts() async{
    List<CallLogEntry> callLogEntries = entries.toList();
    if (_searchController.text.isNotEmpty) {
      callLogEntries = callLogEntries.where((log) {
        String searchTerm = _searchController.text.toLowerCase();
        String logName = log.name?.toLowerCase() ?? '';
        return logName.contains(searchTerm);
      }).toList();
    }

    else {
      Iterable<CallLogEntry> callLogEntries =
      await CallLog.get();
      setState(() {
        entries = callLogEntries.toList();
      });
    }

    setState(() {
      filteredEntries = callLogEntries;
    });
  }






  @override
  void initState() {
    // TODO: implement initState

    print('entries ${entries.length}');
    print('filtered entries $filteredEntries');
    getAllCallLogEntries();
    filteredContacts();
    _searchController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = _searchController.text.isNotEmpty;
    print('234-> $isSearching');
    // Use allCallLogs here to display the recent call logs
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(appBarColor),
        title: const Text('Recents'),),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              label: Text(
                'Search',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              border: OutlineInputBorder(
                borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onChanged: (value){
              filteredContacts ;
            },
            onSubmitted: (_) {
              filteredContacts();
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount:  isSearching == true ? filteredEntries.length : widget.entry.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => CallLogItem(
                currentCallLog: isSearching == true ? filteredEntries.elementAt(index) : widget.entry.elementAt(index),


              ),

            ),
          ),

        ],
      ),
    );
  }
}
