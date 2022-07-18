import 'package:flutter/material.dart';

class Next7DaysView extends StatefulWidget {
  const Next7DaysView({Key? key}) : super(key: key);

  @override
  State<Next7DaysView> createState() => _Next7DaysViewState();
}

class _Next7DaysViewState extends State<Next7DaysView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: () {},
            color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Text('Next 7 Days', style: TextStyle(color: Colors.black.withOpacity(0.8),
                    fontSize: 30, fontWeight: FontWeight.w500),),
              ),
              ListView.builder(
                    shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: (context, i) =>
                          Container(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sunday', style: TextStyle(color: Colors.black.withOpacity(0.8),
                                    fontSize: 20, fontWeight: FontWeight.w500),),
                                Row(
                                  children: const [
                                    Icon(Icons.cloud, size: 30,),
                                    SizedBox(width: 30,),
                                    Text('12°', style: TextStyle(color: Colors.black,
                                        fontSize: 20, fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ],
                            ),
                          )
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
