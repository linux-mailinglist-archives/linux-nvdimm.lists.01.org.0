Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBB728B483
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 14:21:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F37BD158D88F7;
	Mon, 12 Oct 2020 05:21:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.38.202.178; helo=cha4.chairmaneventsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@chairmaneventsummit.info; receiver=<UNKNOWN> 
Received: from cha4.chairmaneventsummit.info (ip178.ip-54-38-202.eu [54.38.202.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 487BC158D88F5
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=chairmaneventsummit.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@chairmaneventsummit.info;
 bh=En0r8G412vEBaFU2cxvtMNxmtPs=;
 b=GgZRZ7vAijVzeFkziIhrHkeRBFVA+Y8exNSw0X0w3+UaZtXvBzOgZdX3nMtc8nPxG96A3chaFKy+
   w3FNDMqG4OB0nAXwoAVttF5lND1XfVuWibSTOJndBA6EiTqrQ+pFpDCevxuUlr/wbqc8VH4UoIyG
   28D7Xfwi/clCyZRDwpvz8T52M5Qd/Hjl/LxYTVzLNf60oG2ExnIMSniYnuOUcs6o+LdZql6ybKJ1
   GXluzQpW6OIsjDmFvEo8sI7ZMB8TcsDh0T5lwY6P0MqEyUKEiFrhw6lGEyCdsHrX/Fefxmm+HU47
   +zmESiA025AyM2rhSgP19K+o4th/KtobZiRdyA==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=chairmaneventsummit.info;
 b=Oypvwx+2Cq12rr5kTUfzrTJXFmtCmcZ3yrFPHaUnes4qsw6YGs1CfxklPszIAPzjQzIb1EUb8FBj
   vqWR6heSMD5v3G13tKkLDGKz57Q9DQWWnPEESDUNQ6iGPeUvYgg1FIri+VD/8pB/DLyb/NcWyAVm
   tX2gv90likxNsu6qgDs4dXNZyMsj9Gd/DuGwM1cF1tyo11pVk2kTa8c1WsmDa3mD/CrkuMjVnSod
   WOcOi8BxeEkYOpimfij8sxnTa6QWEFXvsL2G8yWXebq3CpA3r07Rj8YG6YZnHO8GjrsEM2fIXtvT
   6kMN027y7lEQPbtx8Y252dbJswSkLCBeG4pnFA==;
Received: from chairmaneventsummit.info (51.83.131.67) by cha1.chairmaneventsummit.info id hgh52li19tkh for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 12:20:52 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info>)
Date: Mon, 12 Oct 2020 12:20:52 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Emma Johnson <info@chairmaneventsummit.info>
Subject: RE: did you get my email
Message-ID: <cea51631c3d5a3542c15b2fc805a207b@chairmaneventsummit.info>
X-Trgm-Campaign-Uid: rm030nqmfta3e
X-Trgm-Subscriber-Uid: vh937tpo5w327
X-Trgm-Customer-Uid: cl716wf5hl7c7
X-Trgm-Customer-Gid: 0
X-Trgm-Delivery-Sid: 1
X-Trgm-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://chairmaneventsummit.info/emm/index.php/campaigns/rm030nqmfta3e/report-abuse/vh543dkxdr339/vh937tpo5w327
Feedback-ID: rm030nqmfta3e:vh937tpo5w327:vh543dkxdr339:cl716wf5hl7c7
Precedence: bulk
X-Trgm-EBS: https://chairmaneventsummit.info/emm/index.php/lists/block-address
X-Sender: info@chairmaneventsummit.info
X-Receiver: linux-nvdimm@lists.01.org
X-Trgm-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: Q7WXCXYKNWAVQZMPR3VZTTZ4MAHBU63Y
X-Message-ID-Hash: Q7WXCXYKNWAVQZMPR3VZTTZ4MAHBU63Y
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Emma Johnson <emma@ceoeventsummit2020.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q7WXCXYKNWAVQZMPR3VZTTZ4MAHBU63Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXQgJDQ5OSBhcmUgeW91IGludGVyZXN0ZWQgdG8gZG8gRW1haWwgTWFya2V0aW5nIENhbXBhaWdu
IHdpdGgNCmFuYWx5dGljYWwgcmVwb3J0IHRvIGFueSBvZiB0aGUgZm9sbG93aW5nIGRhdGFiYXNl
cz8NCiogQ0VPLCBvd25lciwgUHJlc2lkZW50IGFuZCBDT08gZW1haWwgbGlzdA0KKiBDRk8sIENv
bnRyb2xsZXIsIFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgRmluYW5jZSwgQWNjb3VudHMgUGF5YWJs
ZSwNCkFjY291bnRzIFJlY2VpdmFibGUsIEF1ZGl0IGVtYWlsIGxpc3QNCiogUGh5c2ljaWFucywg
RG9jdG9ycywgTnVyc2VzLCBEZW50aXN0cywgVGhlcmFwaXN0cyBlbWFpbCBsaXN0DQoqIENoaWVm
IEh1bWFuIFJlc291cmNlcyBPZmZpY2VyLCBWUC9EaXJlY3Rvci9NYW5hZ2VyIG9mIEhSLCBFbXBs
b3llZQ0KQmVuZWZpdHMsIEVtcGxveWVlIENvbW11bmljYXRpb25zLCBFbXBsb3llZSBDb21wZW5z
YXRpb24sIEVtcGxveWVlDQpFbmdhZ2VtZW50LCBFbXBsb3llZSBFeHBlcmllbmNlIGFuZCBFbXBs
b3llZSBSZWxhdGlvbnMsIFRhbGVudA0KQWNxdWlzaXRpb24sIFRhbGVudCBEZXZlbG9wbWVudCwg
VGFsZW50IE1hbmFnZW1lbnQsIFJlY3J1aXRpbmcgZW1haWwNCmxpc3QNCiogQ0lPLENUTywgQ0lT
TywgVlAvRGlyZWN0b3IvTWFuYWdlciBvZiBJVCwgSVQgQ29tcGxpYW5jZSwgSVQgUmlzaywNCkJJ
LCBDbG91ZCwgRGF0YWJhc2UgYW5kIElUIFNlY3VyaXR5IGVtYWlsIGxpc3QNCiogQ01PLCBWUC9E
aXJlY3Rvci9NYW5hZ2VyIG9mIE1hcmtldGluZywgc29jaWFsIG1lZGlhLCBTYWxlcywgZGVtYW5k
DQpnZW5lcmF0aW9uLCBMZWFkIGdlbmVyYXRpb24sIGluc2lkZSBzYWxlcywgTWFya2V0aW5nIENv
bW11bmljYXRpb25zDQplbWFpbCBsaXN0DQoqIENvbXBsaWFuY2UgYW5kIFJpc2sgTWFuYWdlbWVu
dCBlbWFpbCBsaXN0DQoqIENQQSBhbmQgQm9va2tlZXBlcnMgZW1haWwgbGlzdA0KKiBEYXRhIEFu
YWx5dGljcyBhbmQgRGF0YWJhc2UgQWRtaW5pc3RyYXRvcnMgZW1haWwgbGlzdA0KKiBEaXNhc3Rl
ciBSZWNvdmVyeSBlbWFpbCBsaXN0DQoqIEUtY29tbWVyY2Ugb3Igb25saW5lIHJldGFpbGVycyBl
bWFpbCBsaXN0DQoqIEVkdWNhdGlvbiBpbmR1c3RyeSBleGVjdXRpdmVzIGVtYWlsIGxpc3QgLSBQ
cmluY2lwYWxzLCBEZWFuLA0KQWRtaW5zIGFuZCB0ZWFjaGVycyBmcm9tIFNjaG9vbHMsIENvbGxl
Z2VzIGFuZCBVbml2ZXJzaXRpZXMNCiogRW5naW5lZXJzIGVtYWlsIGxpc3QNCiogRXZlbnQgYW5k
IG1lZXRpbmcgcGxhbm5lcnMgZW1haWwgbGlzdA0KKiBGYWNpbGl0aWVzIGFuZCBvZmZpY2UgbWFu
YWdlciBDb250YWN0cw0KKiBHZW5lcmFsIGFuZCBjb3Jwb3JhdGUgY291bnNlbCBhcyB3ZWxsIGxl
Z2FsIHByb2Zlc3Npb25hbHMgZW1haWwNCmxpc3QNCiogR292ZXJubWVudCBjb250cmFjdG9ycyBl
bWFpbCBsaXN0DQoqIEhlYWx0aCAmIFNhZmV0eSBlbWFpbCBsaXN0DQoqIEhpZ2ggbmV0IHdvcnRo
IGluZGl2aWR1YWxzL2ludmVzdG9ycyBlbWFpbCBsaXN0DQoqIEhvc3BpdGFscywgY2xpbmljcywg
cHJpdmF0ZSBwcmFjdGljZXMsIFBoYXJtYWNldXRpY2FsIGFuZA0KYmlvdGVjaG5vbG9neSBjb21w
YW554oCZcyB0b3AgZGVjaXNpb24gbWFrZXJzIGVtYWlsIGxpc3QNCiogSHVtYW4gQ2FwaXRhbCBN
YW5hZ2VtZW50IGVtYWlsIGxpc3QNCiogSW5kaXZpZHVhbCBpbnN1cmFuY2UgYWdlbnRzIGVtYWls
IGxpc3QNCiogSVNWL1ZBUnMgZW1haWwgbGlzdA0KKiBBcmNoaXRlY3RzIGFuZCBpbnRlcmlvciBk
ZXNpZ25lcnMgZW1haWwgbGlzdA0KKiBMZWFybmluZyAmIERldmVsb3BtZW50IGVtYWlsIGxpc3QN
CiogTG9naXN0aWNzLCBzaGlwcGluZyBhbmQgc3VwcGx5IGNoYWluIG1hbmFnZXJzIGVtYWlsIGxp
c3QNCiogTWFudWZhY3R1cmluZyBJbmR1c3RyeSBleGVjdXRpdmVzIGxpc3QNCiogTmV0d29yayBt
YW5hZ2VyLCBTdXJ2ZWlsbGFuY2UsIFN5c3RlbSBBZG1pbmlzdHJhdG9yLCBUZWNobmljYWwNClN1
cHBvcnQgZW1haWwgbGlzdA0KKiBOZXcgJiBVc2VkIENhciBEZWFsZXJzIGVtYWlsIGxpc3QNCiog
T2lsLCBHYXMgYW5kIHV0aWxpdHkgaW5kdXN0cnkgZW1haWwgbGlzdA0KKiBQbGFudCBNYW5hZ2Vy
IGVtYWlsIGxpc3QNCiogUHJvZHVjdCBhbmQgcHJvamVjdCBtYW5hZ2VtZW50IGVtYWlsIGxpc3QN
CiogUHVyY2hhc2luZyBhbmQgUHJvY3VyZW1lbnQgZW1haWwgbGlzdA0KKiBTcGVjaWZpYyBFdmVu
dCBhdHRlbmRlZXMgbGlzdA0KKiBUZWxlY29tIG1hbmFnZXJzLCBWT0lQIG1hbmFnZXJzLCBDbG91
ZCBhcmNoaXRlY3QsIENsb3VkIG1hbmFnZXJzLA0KU3RvcmFnZSBtYW5hZ2VycyBlbWFpbCBsaXN0
DQoqIFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgQ3VzdG9tZXIgU2VydmljZSBhbmQgQ3VzdG9tZXIg
U3VjY2VzcyBlbWFpbA0KbGlzdA0KVGhhbmtzIGFuZCBsZXQgbWUga25vdy4NCkVtbWEgSm9obnNv
bg0KRGF0YWJhc2UgQ29uc3VsdGFudA0KNDJNaWwgQjJCIGFuZCAyMTBNaWwgQjJDIE9wdC1pbiBF
bWFpbCBhbmQgcGhvbmUgbGlzdCB3aXRoIG90aGVyIGRhdGENCmZpZWxkcw0KaHR0cHM6Ly9jaGFp
cm1hbmV2ZW50c3VtbWl0LmluZm8vZW1tL2luZGV4LnBocC9saXN0cy92aDU0M2RreGRyMzM5L3Vu
c3Vic2NyaWJlL3ZoOTM3dHBvNXczMjcvcm0wMzBucW1mdGEzZQ0KwqANCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcg
bGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4g
ZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
