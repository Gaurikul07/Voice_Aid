import 'package:flutter/material.dart';

/// Maps the icon keys used in the content data to Material icons.
/// (Generic Material icons, not custom illustrations - see KNOWN_LIMITATIONS.)
IconData iconFor(String key) {
  switch (key) {
    case 'burn':
      return Icons.local_fire_department;
    case 'bleeding':
      return Icons.bloodtype;
    case 'choking':
      return Icons.air;
    case 'snake':
      return Icons.pest_control;
    case 'bone':
      return Icons.accessibility_new;
    case 'safe':
      return Icons.shield_outlined;
    case 'water':
      return Icons.water_drop;
    case 'ring':
      return Icons.watch;
    case 'bandage':
      return Icons.healing;
    case 'no':
      return Icons.block;
    case 'hospital':
      return Icons.local_hospital;
    case 'press':
      return Icons.back_hand;
    case 'rest':
      return Icons.airline_seat_flat;
    case 'phone':
      return Icons.phone_in_talk;
    case 'splint':
      return Icons.accessibility_new;
    case 'vehicle':
      return Icons.directions_car;
    case 'warning':
      return Icons.warning_amber_rounded;
    case 'listen':
      return Icons.hearing;
    case 'back':
      return Icons.back_hand;
    case 'abdomen':
      return Icons.compress;
    case 'chest':
      return Icons.favorite_border;
    case 'repeat':
      return Icons.repeat;
    case 'adult':
      return Icons.person;
    case 'child':
      return Icons.child_care;
    case 'infant':
      return Icons.baby_changing_station;
    default:
      return Icons.info_outline;
  }
}
