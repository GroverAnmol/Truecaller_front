import 'dart:developer';
import 'package:untitled36/custom_colors.dart';
import 'package:untitled36/helpers.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:untitled36/screens/call_log_details_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CallLogItem extends StatefulWidget {
  const CallLogItem(
      {super.key, required this.currentCallLog ,
      });

  final CallLogEntry? currentCallLog;


  @override
  State<CallLogItem> createState() => _CallLogItemState();
}

class _CallLogItemState extends State<CallLogItem> {


  @override
  Widget build(BuildContext context) {
    log('19>> ${widget.currentCallLog}');
    return ListTile(

      leading:( widget.currentCallLog?.name !=null) && (widget.currentCallLog?.name !='') ?
      CircleAvatar(
        backgroundColor: Color(circleAvatarColor),
        radius: 24,
        child: Text('${widget.currentCallLog?.name?.substring(0,2)}',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color:Colors.black,
              fontWeight: FontWeight.w300

          ),
        ),
      ):CircleAvatar(
        backgroundColor: Color(circleAvatarColor),
        radius: 24,
        child: Text('+91',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color:Colors.black,
              fontWeight: FontWeight.w300

          ),
        ),
      ),
      title: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: (widget.currentCallLog!.name == null || widget.currentCallLog!.name!.isEmpty) ? GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return CallLogDetailsScreen(callLog: widget.currentCallLog!);
              }));
            },
            child: Text(
              "${widget.currentCallLog!.number}",
            ),
          ):
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CallLogDetailsScreen(callLog: widget.currentCallLog!);
                }));
              },
              child: Text("${widget.currentCallLog!.name}",style: Theme.of(context).textTheme.bodyLarge,))
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          getCallTypeIcon(widget.currentCallLog!.callType!),
          const SizedBox(
            width: 3,
          ),
          Text(
            formatDate(widget.currentCallLog!.timestamp!),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11
            ),
          )
        ],
      ),
      trailing:PopupMenuButton(
        color :  Color(threeDotBGColor),
        itemBuilder: (context)=>[
          PopupMenuItem(child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  final Uri url = Uri(
                    scheme: 'tel',
                    path: "${(widget.currentCallLog!.number!.toString())}",
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
                ),),
              ),trailing:  IconButton(
              onPressed: () async {
                final Uri url = Uri(
                  scheme: 'tel',
                  path: "${(widget.currentCallLog!.number!.toString())}",
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
                    path: "${(widget.currentCallLog!.number!.toString())}",
                  );
                  if (await canLaunchUrl(url)){
                    await launchUrl(url);
                  }else{
                    print('cannot launch');
                  }
                },

                child: Text("SMS",style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,

                    fontWeight: FontWeight.w300
                ),),
              ),trailing: IconButton(
              onPressed: () async {
                final Uri url = Uri(
                  scheme: 'sms',
                  path: "${(widget.currentCallLog!.number!.toString())}",
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
              ),),trailing: IconButton(
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
              leading:GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return CallLogDetailsScreen(callLog: widget.currentCallLog!);
                  }));
                },
                child: Text("Details",style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,

                    fontWeight: FontWeight.w300
                ),),
              ),trailing: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CallLogDetailsScreen(callLog: widget.currentCallLog!);
                }));
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
