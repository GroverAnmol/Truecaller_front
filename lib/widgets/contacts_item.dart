import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:untitled36/custom_colors.dart';
import 'package:untitled36/screens/call_log_details_screen.dart';
import 'package:untitled36/widgets/call_log_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:call_log/call_log.dart';

import '../helpers.dart';

class ContactsItem extends StatelessWidget {
  const ContactsItem({Key? key, required this.currentContact, required this.currentCallLog});

  final Contact? currentContact;
  final CallLogEntry? currentCallLog;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(circleAvatarColor),
        child: Text(
          currentContact!.initials(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color:Colors.black,
              fontWeight: FontWeight.w300

          ),
        ),
      ),
      title: Text(
        currentContact?.displayName ?? "",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        currentContact?.phones?.isEmpty ?? true
            ? 'No Number'
            : currentContact?.phones?.elementAt(0).value.toString() ??
            'No Number',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing:PopupMenuButton(
        color: Color(threeDotBGColor),
        itemBuilder: (context)=>[
          PopupMenuItem(child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  final Uri url = Uri(
                    scheme: 'tel',
                    path: currentContact?.phones?.elementAt(0).value.toString(),
                  );
                  if (await canLaunchUrl(url)){
                    await launchUrl(url);
                  }else{
                    print('cannot launch');
                  }
                },
                child: Text("Call",style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w300
                )),
              ),trailing:  IconButton(
              onPressed: () async {
                final Uri url = Uri(
                  scheme: 'tel',
                  path: currentContact?.phones?.elementAt(0).value.toString(),
                );
                if (await canLaunchUrl(url)){
                  await launchUrl(url);
                }else{
                  print('cannot launch');
                }
              },
                icon: const Icon(
                  Icons.call,
                  color:  Colors.white,
                ),
              ),),
          )),
          PopupMenuItem(child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ListTile(
              leading:GestureDetector(
                onTap: () async {
                  final Uri url = Uri(
                    scheme: 'sms',
                    path: currentContact?.phones?.elementAt(0).value.toString(),
                  );
                  if (await canLaunchUrl(url)){
                    await launchUrl(url);
                  }else{
                    print('cannot launch');
                  }
                },

                child: Text("SMS",style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w300
                )),
              ),trailing: IconButton(
                onPressed: () async {
                  final Uri url = Uri(
                    scheme: 'sms',
                    path: currentContact?.phones?.elementAt(0).value.toString(),
                  );
                  if (await canLaunchUrl(url)){
                    await launchUrl(url);
                  }else{
                    print('cannot launch');
                  }
                },
                icon: const Icon(
                  Icons.message,
                  color:  Colors.white,
                ),
              ),),
          )),
          PopupMenuItem(child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ListTile(
              leading:Text("Block",style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w300
              )),trailing: IconButton(
                onPressed: () {

                },
                icon: const Icon(
                  Icons.block,
                  color:  Colors.white,
                ),
              ),),
          )),
          PopupMenuItem(child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ListTile(
              leading:Text("Details",style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w300
              )),trailing: IconButton(
                onPressed: () {

                },
                icon: const Icon(
                  Icons.info_outline_rounded,
                  color:  Colors.white,
                ),
              ),),
          )),

        ],
        child: Icon(Icons.more_vert,
          color:  Color(threeDotColor),
        ),
      ),
    );
  }
}
