import 'package:twilio_flutter/twilio_flutter.dart';

class TwilioService
{
  late TwilioFlutter twilioFlutter;
  void setAccount(){
    twilioFlutter = TwilioFlutter(accountSid: "88799", authToken: "987789", twilioNumber: "18383848512");
  }
  void verifyPhoneNumber(){

  }
  void sendSms(int z, String idline, String idName)async{

      await twilioFlutter.sendSMS(toNumber: "919834136328",
          messageBody: "Hey There, you are the leader of the queue #${idline}, ${idName}");
  }
}
