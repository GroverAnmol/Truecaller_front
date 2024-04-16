import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled36/custom_colors.dart';
import 'package:untitled36/widgets/contacts_item.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';



class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> allContacts = [];
  List<Contact> filteredAllContacts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllContacts();
    _searchController.addListener(() {
      filteredContacts();
    });
  }

  getAllContacts() async {
    List<Contact> contacts =
    await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      allContacts = contacts;
    });
  }

  void filteredContacts() {
    List<Contact> contacts = [];
    contacts.addAll(allContacts);
    if (_searchController.text.isNotEmpty) {
      contacts.retainWhere(
            (contact) {
          String searchTerm = _searchController.text.toLowerCase();
          String contactName = contact.displayName!.toLowerCase();
          return contactName.contains(searchTerm);
        },
      );

      setState(() {
        filteredAllContacts = contacts;
      });
    }
  }
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    bool isSearching = _searchController.text.isNotEmpty;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(appBarColor),
          title: const Text('Contacts'),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
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
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: isSearching == true
                      ? filteredAllContacts.length
                      : allContacts.length,
                  itemBuilder: (context, index) => ContactsItem(
                    currentCallLog: null,
                      currentContact: isSearching == true
                          ? filteredAllContacts[index]
                          : allContacts[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}