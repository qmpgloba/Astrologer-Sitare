import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0.5,
        title: const Text('Profile'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.all(size.width / 16),
          child: Column(
            children: [

              AutoSizeText('Athul prakash',minFontSize: 18,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,),
              SizedBox(height: 18,),
              Stack(
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundColor: redColor,
            ),
           Positioned(
            // height: 25,
            // width: 20,
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap:() {
                
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor.withOpacity(0.4)
                ),
                child: const Icon(Icons.edit,size: 30,)),
            )),
          ],
        ),
             
              AstrologerProfileDetailsWidget(
                  size: size,
                  feildName: 'Mobile number',
                  astrologerDetail: '0000000000'),
              AstrologerProfileDetailsWidget(
                  size: size,
                  feildName: 'Date of Birth',
                  astrologerDetail: '22/04/1990'),
              AstrologerProfileDetailsWidget(
                  size: size,
                  feildName: 'Address',
                  astrologerDetail:
                      'aisdnkandjaisdnkandjjnsdknajjnsaaisdnkandjjnsdknajjnsajnsdknajjnsa'),
              AstrologerProfileDetailsWidget(
                  size: size,
                  feildName: 'Experience',
                  astrologerDetail: '5 Years'),
                  const SizedBox(height: 20,),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.circular(3)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Center(
                      child: Text(
                        'Edit Profile',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18,
                            color: whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height:  15,
              ),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      // color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(3)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Center(
                      child: Text(
                        'Delete',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18,
                            color: blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class AstrologerProfileDetailsWidget extends StatelessWidget {
  const AstrologerProfileDetailsWidget({
    super.key,
    required this.feildName,
    required this.astrologerDetail,
    required this.size,
  });
  final String feildName;
  final String astrologerDetail;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Text(
              feildName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
              width: size.width * .5,
              child: AutoSizeText(
                astrologerDetail,
                style: const TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.end,
                maxLines: 3,
                maxFontSize: 16,
              ))
        ],
      ),
    );
  }
}
