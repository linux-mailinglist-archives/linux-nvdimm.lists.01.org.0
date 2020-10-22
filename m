Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50CB295949
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Oct 2020 09:35:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E20AB151D34D8;
	Thu, 22 Oct 2020 00:35:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.38.202.176; helo=cha1.chairmaneventsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@chairmaneventsummit.info; receiver=<UNKNOWN> 
Received: from cha1.chairmaneventsummit.info (ip176.ip-54-38-202.eu [54.38.202.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D3FE151D34D7
	for <linux-nvdimm@lists.01.org>; Thu, 22 Oct 2020 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=chairmaneventsummit.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@chairmaneventsummit.info;
 bh=J00K1riW8ElKkqkcUg6ta67GiYs=;
 b=Kd85o8y+Rkej+mVzptFKdqXKYfJGDHd7t1Gb0v+8fgzOzR9f6FRJoshqz8luhGF3xm00GEVSul1r
   tFpAY/lmr/ZEyEePOmFOKIZp7cRtyIgElzqqCg1MXXjY12jyHUmFqAJRtO5CBnd90oDTX0FJqaQ3
   0gXVkyCpzwqxHWG7rHKtFkWSfzzCt6mHKEflnslA7M2CwdngyM5dS01ja28rEt7QxMSFaxGM2x1W
   AHYJdNglpJDD1uMWp/nzRhdEX7u0pTd/agoEY/4gLs+gRQ7Cy0KLltd1J2/BmKKJrG8Pq522ZyE+
   +d5dAaLEAAZWlgCjAu/AJverrtcGQkz3whxjbQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=chairmaneventsummit.info;
 b=LsbRcQPUp5x3WutLsS6GjqMK60w2rtNKbXfLTufUsdsnKyAxunFMtgSicIz76UPaQJCkjAGZXtzN
   ME7zABvzMCMlwC2BbgyCBBpJ71X1kCkmtIgwKqHGd8gzIiEIn1SPmCjP5LJwGZrln6veGJpRGlcH
   w0+hi/NKCX4ugqYIYdbMPbN4gESR1dRpkw8sLx5tYbfMQ2Lep8oVUc24zJbKCepnCAOS2TaJjtE7
   q3ynDGQ7/+EJSNXEiVf1hssP98i9TGQToWdz9JH6UpQky+1jl9/swNmY9oJTt5HJPsO5f2gZ/1DQ
   QyZA2KzOxo2ze8on01qx40M5VYk9ZYRJpM/UpQ==;
Received: from chairmaneventsummit.info (51.83.131.67) by cha1.chairmaneventsummit.info id hi4r39i19tk5 for <linux-nvdimm@lists.01.org>; Thu, 22 Oct 2020 07:35:13 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info>)
Date: Thu, 22 Oct 2020 07:35:13 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Emma Johnson <info@chairmaneventsummit.info>
Subject: RE: Conference call
Message-ID: <1ceac7b56fe5e3c3dd3f6b387a46501d@chairmaneventsummit.info>
X-Trgm-Campaign-Uid: pe626fbgsn51a
X-Trgm-Subscriber-Uid: xj9408r1qtf27
X-Trgm-Customer-Uid: cl716wf5hl7c7
X-Trgm-Customer-Gid: 0
X-Trgm-Delivery-Sid: 1
X-Trgm-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://chairmaneventsummit.info/emm/index.php/campaigns/pe626fbgsn51a/report-abuse/tr3842wxgefa2/xj9408r1qtf27
Feedback-ID: pe626fbgsn51a:xj9408r1qtf27:tr3842wxgefa2:cl716wf5hl7c7
Precedence: bulk
X-Trgm-EBS: https://chairmaneventsummit.info/emm/index.php/lists/block-address
X-Sender: info@chairmaneventsummit.info
X-Receiver: linux-nvdimm@lists.01.org
X-Trgm-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: HIABMBPP3AQ7Y5L23POSJIQELBNYK3GW
X-Message-ID-Hash: HIABMBPP3AQ7Y5L23POSJIQELBNYK3GW
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Emma Johnson <emma@ceoeventsummit2020.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HIABMBPP3AQ7Y5L23POSJIQELBNYK3GW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

V291bGQgeW91IGxpa2UgdG8gcHVyY2hhc2Ugb3IgZG8gZW1haWwgbWFya2V0aW5nIHRvwqBhbnkg
b2YgdGhlDQpmb2xsb3dpbmcgY29udGFjdCBkYXRhYmFzZXM/DQoqIENFTywgb3duZXIsIFByZXNp
ZGVudCBhbmQgQ09PIGVtYWlsIGxpc3QNCiogQ0ZPLCBDb250cm9sbGVyLCBWUC9EaXJlY3Rvci9N
YW5hZ2VyIG9mIEZpbmFuY2UsIEFjY291bnRzIFBheWFibGUsDQpBY2NvdW50cyBSZWNlaXZhYmxl
LCBBdWRpdCBlbWFpbCBsaXN0DQoqIFBoeXNpY2lhbnMsIERvY3RvcnMsIE51cnNlcywgRGVudGlz
dHMsIFRoZXJhcGlzdHMgZW1haWwgbGlzdA0KKiBDaGllZiBIdW1hbiBSZXNvdXJjZXMgT2ZmaWNl
ciwgVlAvRGlyZWN0b3IvTWFuYWdlciBvZiBIUiwgRW1wbG95ZWUNCkJlbmVmaXRzLCBFbXBsb3ll
ZSBDb21tdW5pY2F0aW9ucywgRW1wbG95ZWUgQ29tcGVuc2F0aW9uLCBFbXBsb3llZQ0KRW5nYWdl
bWVudCwgRW1wbG95ZWUgRXhwZXJpZW5jZSBhbmQgRW1wbG95ZWUgUmVsYXRpb25zLCBUYWxlbnQN
CkFjcXVpc2l0aW9uLCBUYWxlbnQgRGV2ZWxvcG1lbnQsIFRhbGVudCBNYW5hZ2VtZW50LCBSZWNy
dWl0aW5nIGVtYWlsDQpsaXN0DQoqIENJTyxDVE8sIENJU08sIFZQL0RpcmVjdG9yL01hbmFnZXIg
b2YgSVQsIElUIENvbXBsaWFuY2UsIElUIFJpc2ssDQpCSSwgQ2xvdWQsIERhdGFiYXNlIGFuZCBJ
VCBTZWN1cml0eSBlbWFpbCBsaXN0DQoqIENNTywgVlAvRGlyZWN0b3IvTWFuYWdlciBvZiBNYXJr
ZXRpbmcsIHNvY2lhbCBtZWRpYSwgU2FsZXMsIGRlbWFuZA0KZ2VuZXJhdGlvbiwgTGVhZCBnZW5l
cmF0aW9uLCBpbnNpZGUgc2FsZXMsIE1hcmtldGluZyBDb21tdW5pY2F0aW9ucw0KZW1haWwgbGlz
dA0KKiBDb21wbGlhbmNlIGFuZCBSaXNrIE1hbmFnZW1lbnQgZW1haWwgbGlzdA0KKiBDUEEgYW5k
IEJvb2trZWVwZXJzIGVtYWlsIGxpc3QNCiogRGF0YSBBbmFseXRpY3MgYW5kIERhdGFiYXNlIEFk
bWluaXN0cmF0b3JzIGVtYWlsIGxpc3QNCiogRGlzYXN0ZXIgUmVjb3ZlcnkgZW1haWwgbGlzdA0K
KiBFLWNvbW1lcmNlIG9yIG9ubGluZSByZXRhaWxlcnMgZW1haWwgbGlzdA0KKiBFZHVjYXRpb24g
aW5kdXN0cnkgZXhlY3V0aXZlcyBlbWFpbCBsaXN0IC0gUHJpbmNpcGFscywgRGVhbiwNCkFkbWlu
cyBhbmQgdGVhY2hlcnMgZnJvbSBTY2hvb2xzLCBDb2xsZWdlcyBhbmQgVW5pdmVyc2l0aWVzDQoq
IEVuZ2luZWVycyBlbWFpbCBsaXN0DQoqIEV2ZW50IGFuZCBtZWV0aW5nIHBsYW5uZXJzIGVtYWls
IGxpc3QNCiogRmFjaWxpdGllcyBhbmQgb2ZmaWNlIG1hbmFnZXIgQ29udGFjdHMNCiogR2VuZXJh
bCBhbmQgY29ycG9yYXRlIGNvdW5zZWwgYXMgd2VsbCBsZWdhbCBwcm9mZXNzaW9uYWxzIGVtYWls
DQpsaXN0DQoqIEdvdmVybm1lbnQgY29udHJhY3RvcnMgZW1haWwgbGlzdA0KKiBIZWFsdGggJiBT
YWZldHkgZW1haWwgbGlzdA0KKiBIaWdoIG5ldCB3b3J0aCBpbmRpdmlkdWFscy9pbnZlc3RvcnMg
ZW1haWwgbGlzdA0KKiBIb3NwaXRhbHMsIGNsaW5pY3MsIHByaXZhdGUgcHJhY3RpY2VzLCBQaGFy
bWFjZXV0aWNhbCBhbmQNCmJpb3RlY2hub2xvZ3kgY29tcGFueeKAmXMgdG9wIGRlY2lzaW9uIG1h
a2VycyBlbWFpbCBsaXN0DQoqIEh1bWFuIENhcGl0YWwgTWFuYWdlbWVudCBlbWFpbCBsaXN0DQoq
IEluZGl2aWR1YWwgaW5zdXJhbmNlIGFnZW50cyBlbWFpbCBsaXN0DQoqIElTVi9WQVJzIGVtYWls
IGxpc3QNCiogQXJjaGl0ZWN0cyBhbmQgaW50ZXJpb3IgZGVzaWduZXJzIGVtYWlsIGxpc3QNCiog
TGVhcm5pbmcgJiBEZXZlbG9wbWVudCBlbWFpbCBsaXN0DQoqIExvZ2lzdGljcywgc2hpcHBpbmcg
YW5kIHN1cHBseSBjaGFpbiBtYW5hZ2VycyBlbWFpbCBsaXN0DQoqIE1hbnVmYWN0dXJpbmcgSW5k
dXN0cnkgZXhlY3V0aXZlcyBsaXN0DQoqIE5ldHdvcmsgbWFuYWdlciwgU3VydmVpbGxhbmNlLCBT
eXN0ZW0gQWRtaW5pc3RyYXRvciwgVGVjaG5pY2FsDQpTdXBwb3J0IGVtYWlsIGxpc3QNCiogTmV3
ICYgVXNlZCBDYXIgRGVhbGVycyBlbWFpbCBsaXN0DQoqIE9pbCwgR2FzIGFuZCB1dGlsaXR5IGlu
ZHVzdHJ5IGVtYWlsIGxpc3QNCiogUGxhbnQgTWFuYWdlciBlbWFpbCBsaXN0DQoqIFByb2R1Y3Qg
YW5kIHByb2plY3QgbWFuYWdlbWVudCBlbWFpbCBsaXN0DQoqIFB1cmNoYXNpbmcgYW5kIFByb2N1
cmVtZW50IGVtYWlsIGxpc3QNCiogU3BlY2lmaWMgRXZlbnQgYXR0ZW5kZWVzIGxpc3QNCiogVGVs
ZWNvbSBtYW5hZ2VycywgVk9JUCBtYW5hZ2VycywgQ2xvdWQgYXJjaGl0ZWN0LCBDbG91ZCBtYW5h
Z2VycywNClN0b3JhZ2UgbWFuYWdlcnMgZW1haWwgbGlzdA0KKiBWUC9EaXJlY3Rvci9NYW5hZ2Vy
IG9mIEN1c3RvbWVyIFNlcnZpY2UgYW5kIEN1c3RvbWVyIFN1Y2Nlc3MgZW1haWwNCmxpc3QNClRo
YW5rcyBhbmQgbGV0IG1lIGtub3cuDQpFbW1hIEpvaG5zb24NCkRhdGFiYXNlIENvbnN1bHRhbnQN
CjQyTWlsIEIyQiBhbmQgMjEwTWlsIEIyQyBPcHQtaW4gRW1haWwgYW5kIHBob25lIGxpc3Qgd2l0
aCBvdGhlciBkYXRhDQpmaWVsZHMNCmh0dHBzOi8vY2hhaXJtYW5ldmVudHN1bW1pdC5pbmZvL2Vt
bS9pbmRleC5waHAvbGlzdHMvdHIzODQyd3hnZWZhMi91bnN1YnNjcmliZS94ajk0MDhyMXF0ZjI3
L3BlNjI2ZmJnc241MWENCsKgDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1s
ZWF2ZUBsaXN0cy4wMS5vcmcK
