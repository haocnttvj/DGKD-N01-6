import 'package:flutter_email_sender/flutter_email_sender.dart';

sendEmail(String recipientEmail) async {
  final Email email = Email(
    body: 'Bạn chưa nộp tiền điện tháng này',
    subject: 'Nộp tiền điện',
    recipients: [recipientEmail],
    isHTML: false,
  );

  await FlutterEmailSender.send(email);
}
