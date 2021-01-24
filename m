Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6752B301F01
	for <lists+linux-nvdimm@lfdr.de>; Sun, 24 Jan 2021 22:50:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B188100EC1D5;
	Sun, 24 Jan 2021 13:50:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.191.225; helo=app10.appendleadedm.info; envelope-from=contact-linux+2dnvdimm=lists.01.org@appendleadedm.info; receiver=<UNKNOWN> 
Received: from app10.appendleadedm.info (ip225.ip-51-83-191.eu [51.83.191.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 41B83100EC1D4
	for <linux-nvdimm@lists.01.org>; Sun, 24 Jan 2021 13:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=appendleadedm.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=contact@appendleadedm.info;
 bh=f+XfpKeh75AZ5T5+VtCf8Uc2U/c=;
 b=Lriqmo8pMyqoiHBC2113wNwxZcJMyBGe9VAin4f1xuE65dKxtrB6ktI2+9DFVy+M1UsF+vzV91X+
   mp8a4iHUtVutYCj4M3mDAktdOpnTtKAg7+rjIs79379IodGIxolW8c3RxngLm0PkfDV6CD2NtyFu
   veFaKGNksQrnpHdGRAp88dFXEKo5QzOPvlK7Ayxw3tdUU9oiYHUacQrVvFWGB8Bhc3dim2rEjCqr
   FfJu53y/yXajcwyfhflZAKYhNWbAWJ7xlfPXqDC/WuQPKLPAM3dTKNWH91APZSfGnvEKjZH78z0y
   fFaq7TIy+9pHrH8pHBqQHHtLTBBrW2Bb8Swpjw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=appendleadedm.info;
 b=eDa84RMwMlc4nIx6/RDeSuC8qCv5nbNpYTTFuzEg1pQMJEwOhqGPvR5kFHa66cUOlSoeW4WZ8BnS
   nug1osdGVMTtyT2x6C3u1xbW7UAxIm8UrQ0Ip//GWPMSVB0WO/M7lLoKTapFD4+pc+lkSfBVtAW9
   7yHGRbbluygKJ5MQbWw/w4Mp1lhHWIAzmhyVc8LdiVvfRwW5KX/cDjYyxzdW9mUEWZ8Vk8S4aCpc
   u6qZtoKkD1DPQ9EbfqV1G1l530MMC6CfGFD2ybGt7mecgayLExoNsx0gEtj/T/+Qy3I9/5D7Wxtp
   rHFl6khVB3ESlNesvS8+6KNaa7Ez9Y0yRbtHqg==;
Received: from appendleadedm.info (127.0.0.1) by app1.appendleadedm.info id h1nloji19tka for <linux-nvdimm@lists.01.org>; Sun, 24 Jan 2021 21:49:56 +0000 (envelope-from <contact-linux+2Dnvdimm=lists.01.org@appendleadedm.info>)
Date: Sun, 24 Jan 2021 21:49:56 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Susan Taylor <contact@appendleadedm.info>
Subject: RE: Follow up
Message-ID: <d412809aca32e45ada6dd268c18c4970@appendleadedm.info>
X-Ooqx-Campaign-Uid: jv576yfz6o1fe
X-Ooqx-Subscriber-Uid: rp659hnss9052
X-Ooqx-Customer-Uid: fv107j3jh8cf0
X-Ooqx-Customer-Gid: 0
X-Ooqx-Delivery-Sid: 1
X-Ooqx-Tracking-Did: 0
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-Report-Abuse: Please report abuse for this campaign here: http://appendleadedm.info/emm/index.php/campaigns/jv576yfz6o1fe/report-abuse/fc852ksheaa89/rp659hnss9052
Feedback-ID: jv576yfz6o1fe:rp659hnss9052:fc852ksheaa89:fv107j3jh8cf0
Precedence: bulk
X-Ooqx-EBS: http://appendleadedm.info/emm/index.php/lists/block-address
X-Sender: contact@appendleadedm.info
X-Receiver: linux-nvdimm@lists.01.org
X-Ooqx-Mailer: PHPMailer - 6.x
MIME-Version: 1.0
Message-ID-Hash: 5RJOIRRSAFST5XN3EMBQB2IJBWA6XX7Q
X-Message-ID-Hash: 5RJOIRRSAFST5XN3EMBQB2IJBWA6XX7Q
X-MailFrom: contact-linux+2Dnvdimm=lists.01.org@appendleadedm.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Susan Taylor <susan.taylordata@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5RJOIRRSAFST5XN3EMBQB2IJBWA6XX7Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXJlIHlvdSBsb29raW5nIGZvciBhbnkgb2YgdGhlIGZvbGxvd2luZyBFbWFpbCBhbmQgcGhvbmUg
bGlzdCBnYXRoZXJlZA0KZnJvbSBMaW5rZWRJbiwgRXZlbnRzIGFuZCBtYXJrZXQgcmVzZWFyY2g/
IFBsZWFzZSBzcGVjaWZ5IHlvdXIgdGFyZ2V0DQphdWRpZW5jZSBzbyB0aGF0IHdlIGNhbiBzaGFy
ZSBhIHNhbXBsZSB3aXRoIHlvdS4NCiogQXJjaGl0ZWN0cyBhbmQgaW50ZXJpb3IgZGVzaWduZXJz
IGVtYWlsIGxpc3QNCiogQ0VPLCBvd25lciwgUHJlc2lkZW50IGFuZCBDT08gY29udGFjdHMNCiog
Q0ZPLCBDb250cm9sbGVyLCBWUC9EaXJlY3Rvci9NYW5hZ2VyIG9mIEZpbmFuY2UsIEFjY291bnRz
IFBheWFibGUsDQpBY2NvdW50cyBSZWNlaXZhYmxlLCBBdWRpdCBDb250YWN0cw0KKiBDaGllZiBI
dW1hbiBSZXNvdXJjZXMgT2ZmaWNlciwgVlAvRGlyZWN0b3IvTWFuYWdlciBvZiBIUiwgRW1wbG95
ZWUNCkJlbmVmaXRzLCBFbXBsb3llZSBDb21tdW5pY2F0aW9ucywgRW1wbG95ZWUgQ29tcGVuc2F0
aW9uLCBFbXBsb3llZQ0KRW5nYWdlbWVudCwgRW1wbG95ZWUgRXhwZXJpZW5jZSBhbmQgRW1wbG95
ZWUgUmVsYXRpb25zLCBUYWxlbnQNCkFjcXVpc2l0aW9uLCBUYWxlbnQgRGV2ZWxvcG1lbnQsIFRh
bGVudCBNYW5hZ2VtZW50LCBSZWNydWl0aW5nDQpDb250YWN0cw0KKiBDSU8sQ1RPLCBDSVNPLCBW
UC9EaXJlY3Rvci9NYW5hZ2VyIG9mIElULCBJVCBDb21wbGlhbmNlLCBJVCBSaXNrLA0KQkksIENs
b3VkLCBEYXRhYmFzZSBhbmQgSVQgU2VjdXJpdHkgQ29udGFjdHMNCiogQ01PLCBWUC9EaXJlY3Rv
ci9NYW5hZ2VyIG9mIE1hcmtldGluZywgc29jaWFsIG1lZGlhLCBTYWxlcywgZGVtYW5kDQpnZW5l
cmF0aW9uLCBMZWFkIGdlbmVyYXRpb24sIGluc2lkZSBzYWxlcywgTWFya2V0aW5nIENvbW11bmlj
YXRpb25zDQpjb250YWN0cyBldGMuDQoqIENvbXBsaWFuY2UgYW5kIFJpc2sgTWFuYWdlbWVudCBD
b250YWN0cw0KKiBDUEEgYW5kIEJvb2trZWVwZXJzIGVtYWlsIGxpc3QNCiogRGF0YSBBbmFseXRp
Y3MgYW5kIERhdGFiYXNlIEFkbWluaXN0cmF0b3JzIGNvbnRhY3RzDQoqIERpc2FzdGVyIFJlY292
ZXJ5IENvbnRhY3RzDQoqIEUtY29tbWVyY2Ugb3Igb25saW5lIHJldGFpbGVycyBlbWFpbCBsaXN0
DQoqIEVkdWNhdGlvbiBpbmR1c3RyeSBleGVjdXRpdmVzIGVtYWlsIGxpc3QgLSBQcmluY2lwYWxz
LCBEZWFuLA0KQWRtaW5zIGFuZCB0ZWFjaGVycyBmcm9tIFNjaG9vbHMsIENvbGxlZ2VzIGFuZCBV
bml2ZXJzaXRpZXMNCiogRW5naW5lZXJzIGVtYWlsIGxpc3QNCiogRXZlbnQgYW5kIG1lZXRpbmcg
cGxhbm5lcnMgZW1haWwgbGlzdA0KKiBGYWNpbGl0aWVzIGFuZCBvZmZpY2UgbWFuYWdlciBDb250
YWN0cw0KKiBHZW5lcmFsIGFuZCBjb3Jwb3JhdGUgY291bnNlbCBhcyB3ZWxsIGxlZ2FsIHByb2Zl
c3Npb25hbHMgbGlzdA0KKiBHb3Zlcm5tZW50IGNvbnRyYWN0b3JzIGVtYWlsIGxpc3QNCiogSGVh
bHRoICYgU2FmZXR5IENvbnRhY3RzDQoqIEhpZ2ggbmV0IHdvcnRoIGluZGl2aWR1YWxzL2ludmVz
dG9ycyBlbWFpbCBsaXN0DQoqIEhvc3BpdGFscywgY2xpbmljcywgcHJpdmF0ZSBwcmFjdGljZXMs
IFBoYXJtYWNldXRpY2FsIGFuZA0KYmlvdGVjaG5vbG9neSBjb21wYW554oCZcyB0b3AgZGVjaXNp
b24gbWFrZXJzIGVtYWlsIGxpc3QNCiogSHVtYW4gQ2FwaXRhbCBNYW5hZ2VtZW50IENvbnRhY3Rz
DQoqIEluZGl2aWR1YWwgaW5zdXJhbmNlIGFnZW50cyBsaXN0DQoqIElTVi9WQVJzIGxpc3QNCiog
TGVhcm5pbmcgJiBEZXZlbG9wbWVudCBDb250YWN0cw0KKiBMb2dpc3RpY3MsIHNoaXBwaW5nIGFu
ZCBzdXBwbHkgY2hhaW4gbWFuYWdlcnMgZW1haWwgbGlzdA0KKiBNYW51ZmFjdHVyaW5nIEluZHVz
dHJ5IGV4ZWN1dGl2ZXMgbGlzdA0KKiBOZXR3b3JrIG1hbmFnZXIsIFN1cnZlaWxsYW5jZSwgU3lz
dGVtIEFkbWluaXN0cmF0b3IsIFRlY2huaWNhbA0KU3VwcG9ydCBDb250YWN0cw0KKiBOZXcgJiBV
c2VkIENhciBEZWFsZXJzIGVtYWlsIGxpc3QNCiogT2lsLCBHYXMgYW5kIHV0aWxpdHkgaW5kdXN0
cnkgY29udGFjdHMNCiogUGh5c2ljaWFucywgRG9jdG9ycywgTnVyc2VzLCBEZW50aXN0cywgVGhl
cmFwaXN0cyBlbWFpbCBsaXN0DQoqIFBsYW50IE1hbmFnZXIgQ29udGFjdHMNCiogUHJvZHVjdCBh
bmQgcHJvamVjdCBtYW5hZ2VtZW50IGxpc3QNCiogUHVyY2hhc2luZyBhbmQgUHJvY3VyZW1lbnQg
Q29udGFjdHMNCiogU3BlY2lmaWMgRXZlbnQgYXR0ZW5kZWVzIGxpc3QNCiogVGVsZWNvbSBtYW5h
Z2VycywgVk9JUCBtYW5hZ2VycywgQ2xvdWQgYXJjaGl0ZWN0LCBDbG91ZCBtYW5hZ2VycywNClN0
b3JhZ2UgbWFuYWdlcnMgZW1haWwgbGlzdA0KKiBWUC9EaXJlY3Rvci9NYW5hZ2VyIG9mIEN1c3Rv
bWVyIFNlcnZpY2UgYW5kIEN1c3RvbWVyIFN1Y2Nlc3MNClN1c2FuIFRheWxvcg0KRGF0YWJhc2Ug
Q29uc3VsdGFudA0KNDJNaWwgQjJCIGFuZCAyMTBNaWwgQjJDIE9wdC1pbiBFbWFpbCBhbmQgcGhv
bmUgbGlzdCB3aXRoIG90aGVyIGRhdGENCmZpZWxkcw0KVW5zdWJzY3JpYmUNCmh0dHA6Ly9hcHBl
bmRsZWFkZWRtLmluZm8vZW1tL2luZGV4LnBocC9saXN0cy9mYzg1MmtzaGVhYTg5L3Vuc3Vic2Ny
aWJlL3JwNjU5aG5zczkwNTIvanY1NzZ5Zno2bzFmZQ0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51
eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGlu
dXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
