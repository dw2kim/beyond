import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beyond/ui/home/home_view_model.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomePage(this.viewModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildCurrentPlace(),
              SizedBox(height: 10),
              _buildParks(),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLogoutButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParks() {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Observer(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Nearby Parks",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                if (viewModel.isPointsOfInterestLoading) ...[
                  _buildLoadingShimmer(verticalPadding: 5, shimmerWidth: 200),
                  _buildLoadingShimmer(verticalPadding: 5, shimmerWidth: 200),
                  _buildLoadingShimmer(verticalPadding: 5, shimmerWidth: 200),
                  _buildLoadingShimmer(verticalPadding: 5, shimmerWidth: 200),
                ] else
                  ...viewModel.nearbyParks
                      .map(
                        (x) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(x.nameAndDistance),
                        ),
                      )
                      .toList(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCurrentPlace() {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Current Location",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Observer(
              builder: (_) {
                return viewModel.isCurrentLocationLoading
                    ? _buildLoadingShimmer()
                    : Text(viewModel.currentLocation);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer(
      {double verticalPadding = 0, double shimmerWidth = 100}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Shimmer.fromColors(
        child: Container(
          color: Colors.white,
          width: shimmerWidth,
          height: 17,
        ),
        baseColor: Colors.grey[200],
        highlightColor: Colors.white,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: viewModel.logout,
      color: Colors.blue,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        "LOGOUT",
        textAlign: TextAlign.center,
      ),
    );
  }
}