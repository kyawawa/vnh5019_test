// -*- mode: C++; coding: utf-8-unix; -*-
// Author: Tatsuya Ishikawa <itatsuya@vt.edu>

#include <ros.h>
#include <sensor_msgs/Joy.h>
#include "DualVNH5019MotorShield.h"

ros::NodeHandle nh;
DualVNH5019MotorShield md;

void joyCallback(const sensor_msgs::Joy& msg)
{
  float horizontal = msg.axes[2];
  float vertical = msg.axes[3];

  if (horizontal > 0) {
    digitalWrite(13, HIGH-digitalRead(13));   // blink the led
    chatter.publish(&str_msg);
  } else {
    digitalWrite(13, LOW-digitalRead(13));
    chatter.publish( &str_msg );
  }
}

// ros::Subscriber<sensor_msgs::Joy> joy_sub("move_motor", &joyCallback);
ros::Subscriber<sensor_msgs::Joy> joy_sub("cmd_key", &joyCallback);

void stopIfFault()
{
  if (md.getM1Fault())
  {
    Serial.println("M1 fault");
    while(1);
  }
  if (md.getM2Fault())
  {
    Serial.println("M2 fault");
    while(1);
  }
}

void setup()
{
  Serial.begin(115200);
  Serial.println("Dual VNH5019 Motor Shield");

  nh.initNode();
  nh.advertise(chatter);
  nh.subscribe(joy_sub);

  md.init();
}

void loop()
{
  Serial.print("hoge");
  nh.spinOnce();
  delay(0.5);
  // for (int i = 0; i <= 400; i++)
  // {
  //   md.setM1Speed(i);
  //   stopIfFault();
  //   if (i%200 == 100)
  //   {
  //     Serial.print("M1 current: ");
  //     Serial.println(md.getM1CurrentMilliamps());
  //   }
  //   delay(2);
  // }

  // for (int i = 400; i >= -400; i--)
  // {
  //   md.setM1Speed(i);
  //   stopIfFault();
  //   if (i%200 == 100)
  //   {
  //     Serial.print("M1 current: ");
  //     Serial.println(md.getM1CurrentMilliamps());
  //   }
  //   delay(2);
  // }

  // for (int i = -400; i <= 0; i++)
  // {
  //   md.setM1Speed(i);
  //   stopIfFault();
  //   if (i%200 == 100)
  //   {
  //     Serial.print("M1 current: ");
  //     Serial.println(md.getM1CurrentMilliamps());
  //   }
  //   delay(2);
  // }
}
