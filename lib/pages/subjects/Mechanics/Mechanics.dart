import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'Equlibrium.dart';
// import 'Kinematics.dart';
// import 'Kinetics.dart';
// import 'Structure.dart';
// import 'friction.dart';

class Mechanics extends StatefulWidget {
  const Mechanics({Key? key}) : super(key: key);

  @override
  State<Mechanics> createState() => _MechanicsState();
}

class _MechanicsState extends State<Mechanics> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: appbarName("Mechanics", context),
          body: Container(
            padding: EdgeInsets.all(2),
            child: ListView(physics: const BouncingScrollPhysics(), children: [
              Subparts("Equilibrium", context, Equilibrium()),
              //   Subparts("Friction", context, Friction()),
              //   Subparts("Structure: Truss And Frames", context, Structure()),
              // Subparts(
              // "Distributed Forces System ", context, DistributedForces()),
              //   Subparts("Kinematics of Particle", context, Kinematics()),
              //   Subparts("Kinetics of Particle", context, Kinetics()),
            ]),
          )),
    );
  }
}
