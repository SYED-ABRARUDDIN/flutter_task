import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newstask/controllers/data_controller.dart';
import 'package:newstask/models/constants/cardview.dart';
import 'package:newstask/models/constants/colors.dart';
import 'package:newstask/models/constants/myfonts.dart';
import 'package:newstask/models/data_model.dart';
import 'package:newstask/utils/http_utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   FirebaseRemoteConfig? remoteConfig;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
   // context.read<DataProvider>().setDataList(list);
  }
  fetchdata(country)async{
  List<DataListModel>dataList= await HttpUtils.fetchallnews("$country");
    context.read<DataProvider>().setDataList(dataList);



  }
  Future<FirebaseRemoteConfig> setupRemoteConfig() async {
 
   remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig!.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  await remoteConfig!.setDefaults(<String, dynamic>{
    'countrycode': 'in',
  
  });
  RemoteConfigValue(null, ValueSource.valueStatic);
  fetchconfig();
  return remoteConfig!;
}
  fetchconfig()async{
     try {
            // Using zero duration to force fetching from remote server.
            await remoteConfig!.setConfigSettings(RemoteConfigSettings(
              fetchTimeout: const Duration(seconds: 10),
              minimumFetchInterval: Duration.zero,
            ));
            await remoteConfig!.fetchAndActivate();
         var tempcode=   remoteConfig!.getString("countrycode");
         setState(() {
           
         });
         fetchdata(tempcode);
          } on PlatformException catch (exception) {
            // Fetch exception.
            print(exception);
          } catch (exception) {
            print(
                'Unable to fetch remote config. Cached or default values will be '
                'used');
            print(exception);
          }

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greycolor,
      appBar: AppBar(
        backgroundColor: AppColors.bluecolor,
        title:const Text("MyNews",style: TextStyle(fontFamily: AppFonts.large),),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            child: GestureDetector(
              onTap:(){
                fetchconfig();
              },child:Row(
                children: [
                  FutureBuilder<FirebaseRemoteConfig>(
        future: setupRemoteConfig(),
        builder: (BuildContext context,
                  AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
                 return snapshot.hasData
                    ? Text("${snapshot.requireData.getString('countrycode').toUpperCase()}",style: TextStyle(fontFamily: AppFonts.medium,fontSize: 18),)
                    : Container();
       
  }),
  Icon(Icons.navigation,color: AppColors.whitecolor,)
                ],
              )),
          )
        ],
      ),
      body:Consumer<DataProvider>(
                    builder: (context, dataprovider, child) {
                      return dataprovider.dataList.isEmpty?Center(child: CircularProgressIndicator(
                        color: AppColors.bluecolor,
                      )):getListWidget(dataprovider.dataList);
                    })
        
    );
  }
  getListWidget(List<DataListModel> list){
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: ((BuildContext context, index) {
        return ItemWidget(
          title: list[index].name,
          description: list[index].description,
          url: list[index].urlToImage,
          time: list[index].publishedAt,

        );
      
    }));

  }
}