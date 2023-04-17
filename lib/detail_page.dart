import 'package:flutter/material.dart';
import 'package:pert6/api_data_source.dart';
import 'package:pert6/detail_user_model.dart';

class DetailPageUsers extends StatefulWidget {
  final int idUser;
  const DetailPageUsers({ Key? key, required this.idUser}) : super(key: key);

  @override
  State<DetailPageUsers> createState() => _DetailPageUsersState();
}

class _DetailPageUsersState extends State<DetailPageUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User $idUser'),
      ),
      body: Container(
        child: FutureBuilder(
          future: ApiDataSource.instance.loadDetailUser(idUser),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.hasData){
              return Text('Error');
            }
            if(snapshot.hasData){
              DetailUserModel usersModel = DetailUserModel.fromJson(snapshot.data);
              return _buildSuccessSection(context, usersModel);
            }
            return _buildLoadingSection();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(BuildContext context, DetailUserModel user) {
    final usersData = user.data!;
    return Container(
      child: _buildItemUsers(context, usersData),
    );
  }

  Widget _buildItemUsers(BuildContext context, Data usersData) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Container(
              width: 100,
              child: Image.network(usersData.avatar!),
            ),
            SizedBox(height: 20,),
            Text(usersData.firstName! + " " + usersData.lastName!),
            Text(usersData.email!),
          ],
        ),
      ),
    );
  }
}