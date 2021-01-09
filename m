Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 479AB2EFE58
	for <lists+linux-nvdimm@lfdr.de>; Sat,  9 Jan 2021 08:47:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 291C4100EA908;
	Fri,  8 Jan 2021 23:47:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.68.149.155; helo=ceo6.trendeduedmsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@trendeduedmsummit.info; receiver=<UNKNOWN> 
Received: from ceo6.trendeduedmsummit.info (ip155.ip-51-68-149.eu [51.68.149.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 81604100EAB43
	for <linux-nvdimm@lists.01.org>; Fri,  8 Jan 2021 23:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=trendeduedmsummit.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@trendeduedmsummit.info;
 bh=oePxvky4O92cGRmKySl0Riudlko=;
 b=CWrkAcfUBVins/OnjfgY15PLiN+qJOKN217gakVHVxT0Sq/u1qTohNJOZQTiIoY+SnFK4LHyC+lQ
   WNo1KxaCLNUaHgsm9q/LsOqcyPdxYi9B7cLnbT6WS/QZbNil/sUZx1BYTERVYKI0kNsfqWx8FO6i
   Gb4lzgn7mtzTFSkgkfMBrGdyBVClR/ESOcR8kCy3ZT/vXOoEOA9e5oZEH9MOGd1kzqk3eGOOuNKz
   UNpnm95/+it7tEJVwg6Qoi3rtwkHjsNJZYyrjWwlzb3DxV7OpulZJHzcZlj5k8vTPAlywmdHHbuS
   mthPWlspyaEyaKri5VFo91C2xc1n/dHf0NOGSg==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=trendeduedmsummit.info;
 b=Hxza9JBkmACuVCy3EkwGA2+Y59WW/90aOCmawUzJ/FPfKZ07B7xDY81L75m6dVnZxqrnFqS0TxmB
   GaMRHyZnNNEfyllJa5mBYN6sZqzwQyH9zt8Rg8d/Y6zY9yteawdeNK21XcB6AD9fR5d6v/pg4CbI
   rs10MsJ8Iitjoq3Zu2981+d5M+4gYTTk49xt5Kp/QTSeFG+lfRkDPn73ZOeCg0f0oZy0f9YD7U2R
   DBJqEjaKVRduDvIL9Q78TsnLIt8/BTcs3nd0EBtYtq05DWbjU5M9E7lzLixM2Hyl6hDO9aQ6gksj
   4zT7T/Il+yAL2KNulxEkMyIRXr3BzSCHzPln1Q==;
Received: from trendeduedmsummit.info (127.0.0.1) by ceo1.trendeduedmsummit.info id hv5fq9i19tk4 for <linux-nvdimm@lists.01.org>; Sat, 9 Jan 2021 07:41:19 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@trendeduedmsummit.info>)
Message-ID: <e274c7863c1c9d2988eaae392488f2f4@trendeduedmsummit.info>
Date: Sat, 09 Jan 2021 07:41:19 +0000
Subject: RE: did you get my email
From: Susan Taylor <info@trendeduedmsummit.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@trendeduedmsummit.info
X-Report-Abuse: Please report abuse for this campaign here:
 http://trendeduedmsummit.info/emm/index.php/campaigns/ot892hsylgc91/report-abuse/ld6539y3c9508/pk094zp7ov0b2
X-Receiver: linux-nvdimm@lists.01.org
X-Ffws-Tracking-Did: 0
X-Ffws-Subscriber-Uid: pk094zp7ov0b2
X-Ffws-Mailer: SwiftMailer - 5.4.x
X-Ffws-EBS: http://trendeduedmsummit.info/emm/index.php/lists/block-address
X-Ffws-Delivery-Sid: 1
X-Ffws-Customer-Uid: ws867mym7e562
X-Ffws-Customer-Gid: 0
X-Ffws-Campaign-Uid: ot892hsylgc91
Precedence: bulk
Feedback-ID: ot892hsylgc91:pk094zp7ov0b2:ld6539y3c9508:ws867mym7e562
Message-ID-Hash: MC2T6YPAWZ3RXOCHWYKEQZX3O4TM6PMS
X-Message-ID-Hash: MC2T6YPAWZ3RXOCHWYKEQZX3O4TM6PMS
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@trendeduedmsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Susan Taylor <susan.taylordata@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MC2T6YPAWZ3RXOCHWYKEQZX3O4TM6PMS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXJlIHlvdSBsb29raW5nIGZvciBhbnkgb2YgdGhlIGZvbGxvd2luZyBlbWFpbCBhbmQgcGhvbmUg
bGlzdCBnYXRoZXJlZA0KZnJvbSBMaW5rZWRJbiwgZXZlbnRzIGFuZCBtYXJrZXQgcmVzZWFyY2g/
DQpQbGVhc2Ugc3BlY2lmeSB5b3VyIHRhcmdldCBhdWRpZW5jZSBzbyB0aGF0IHdlIGNhbiBzaGFy
ZSBhIHNhbXBsZQ0Kd2l0aCB5b3UuDQoxLiBBcmNoaXRlY3RzIGFuZCBpbnRlcmlvciBkZXNpZ25l
cnMgZW1haWwgbGlzdA0KMi4gQ0VPLCBvd25lciwgUHJlc2lkZW50IGFuZCBDT08gY29udGFjdHMg
ZW1haWwgbGlzdA0KMy4gQ0ZPLCBDb250cm9sbGVyLCBWUC9EaXJlY3Rvci9NYW5hZ2VyIG9mIEZp
bmFuY2UsIEFjY291bnRzIFBheWFibGUsDQpBY2NvdW50cyBSZWNlaXZhYmxlLCBBdWRpdCBDb250
YWN0cw0KNC4gSFIsIEVtcGxveWVlLCBUYWxlbnQgYW5kIFJlY3J1aXRpbmcgQ29udGFjdHMNCjUu
IElUIGRlY2lzaW9uIG1ha2VycyBlbWFpbCBsaXN0DQo2LiBNYXJrZXRpbmcgZGVjaXNpb24gbWFr
ZXJzIGVtYWlsIGxpc3QNCjcuIENvbXBsaWFuY2UgYW5kIFJpc2sgbWFuYWdlcnMgZW1haWwgbGlz
dA0KOC4gQ1BBIGFuZCBCb29ra2VlcGVycyBlbWFpbCBsaXN0DQo5LiBEYXRhIEFuYWx5dGljcyBh
bmQgRGF0YWJhc2UgQWRtaW5pc3RyYXRvcnMgZW1haWwgbGlzdA0KMTAuIEUtY29tbWVyY2Ugb3Ig
b25saW5lIHJldGFpbGVycyBlbWFpbCBsaXN0DQoxMS4gRWR1Y2F0aW9uIGluZHVzdHJ5IGRlY2lz
aW9uIG1ha2VycyBlbWFpbCBsaXN0IC0gUHJpbmNpcGFscywgRGVhbiwNCkFkbWlucyBhbmQgdGVh
Y2hlcnMgZnJvbSBTY2hvb2xzLCBDb2xsZWdlcyBhbmQgVW5pdmVyc2l0aWVzDQoxMi4gRW5naW5l
ZXJzIGVtYWlsIGxpc3QNCjEzLiBFdmVudCBhbmQgbWVldGluZyBwbGFubmVycyBlbWFpbCBsaXN0
DQoxNC4gRmFjaWxpdGllcyBhbmQgb2ZmaWNlIG1hbmFnZXIgZW1haWwgbGlzdA0KMTUuIEdlbmVy
YWwgYW5kIGNvcnBvcmF0ZSBjb3Vuc2VsIGFzIHdlbGwgbGVnYWwgcHJvZmVzc2lvbmFscyBsaXN0
DQoxNi4gR292ZXJubWVudCBjb250cmFjdG9ycyBlbWFpbCBsaXN0DQoxNy4gSGVhbHRoICYgU2Fm
ZXR5IG1hbmFnZXJzIGVtYWlsIGxpc3QNCjE4LiBIaWdoIG5ldCB3b3J0aCBpbmRpdmlkdWFscy9p
bnZlc3RvcnMgZW1haWwgbGlzdA0KMTkuIMKgTWVkaWNhbC9IZWFsdGhjYXJlIGluZHVzdHJ5IGRl
Y2lzaW9uIG1ha2VycyBlbWFpbCBsaXN0IC0NCkhvc3BpdGFscywgY2xpbmljcywgcHJpdmF0ZSBw
cmFjdGljZXMsIFBoYXJtYWNldXRpY2FsIGFuZA0KYmlvdGVjaG5vbG9neSBjb21wYW554oCZcyB0
b3AgZGVjaXNpb24gbWFrZXJzIGVtYWlsIGxpc3QNCjIwLiBJbmRpdmlkdWFsIGluc3VyYW5jZSBh
Z2VudHMgZW1haWwgbGlzdA0KMjEuIElTVi9WQVJzIGVtYWlsIGxpc3QNCjIyLiBMZWFybmluZyAm
IERldmVsb3BtZW50IG1hbmFnZXJzIGVtYWlsIGxpc3QNCjIzLiBMb2dpc3RpY3MsIHNoaXBwaW5n
IGFuZCBzdXBwbHkgY2hhaW4gbWFuYWdlcnMgZW1haWwgbGlzdA0KMjQuIE1hbnVmYWN0dXJpbmcg
SW5kdXN0cnkgZGVjaXNpb24gbWFrZXJzIGVtYWlsIGxpc3QNCjI1LiBOZXR3b3JrIG1hbmFnZXIs
IFN1cnZlaWxsYW5jZSwgU3lzdGVtIEFkbWluaXN0cmF0b3IsIFRlY2huaWNhbA0KU3VwcG9ydCBl
bWFpbCBsaXN0DQoyNi4gTmV3ICYgVXNlZCBDYXIgRGVhbGVycyBlbWFpbCBsaXN0DQoyNy4gT2ls
LCBHYXMgYW5kIHV0aWxpdHkgaW5kdXN0cnkgY29udGFjdHMNCjI4LiBQaHlzaWNpYW5zLCBEb2N0
b3JzLCBOdXJzZXMsIERlbnRpc3RzLCBUaGVyYXBpc3RzIGVtYWlsIGxpc3QNCjI5LiBQbGFudCBN
YW5hZ2VyIENvbnRhY3RzDQozMC4gUHJvZHVjdCBhbmQgcHJvamVjdCBtYW5hZ2VtZW50IGxpc3QN
CjMxLiBQdXJjaGFzaW5nIGFuZCBQcm9jdXJlbWVudCBDb250YWN0cw0KMzIuIFNwZWNpZmljIEV2
ZW50IGF0dGVuZGVlcyBsaXN0DQozMy4gVGVsZWNvbSAvVk9JUCBtYW5hZ2VycywgQ2xvdWQgYXJj
aGl0ZWN0LCBDbG91ZCBtYW5hZ2VycywgU3RvcmFnZQ0KbWFuYWdlcnMgZW1haWwgbGlzdA0KMzQu
IFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgQ3VzdG9tZXIgU2VydmljZSBhbmQgQ3VzdG9tZXIgU3Vj
Y2Vzcw0KZGVjaXNpb24gbWFrZXJzIGVtYWlsIGxpc3QNClRoYW5rcyBhbmQgbGV0IG1lIGtub3cu
DQpTdXNhbiBUYXlsb3INCkVtYWlsIExpc3QgfCBFbWFpbCBDYW1wYWlnbiB8IEVtYWlsIEFwcGVu
ZGluZyB8IFRlbGVtYXJrZXRpbmcgfCBMZWFkDQpnZW5lcmF0aW9uIHwgU0VPIHwgU29jaWFsIG1l
ZGlhIENhbXBhaWduIHwgVmlkZW8gTWFya2V0aW5nIHwgQ29tcGxldGUNCkRpZ2l0YWwgTWFya2V0
aW5nDQpVbnN1YnNjcmliZQ0KaHR0cDovL3RyZW5kZWR1ZWRtc3VtbWl0LmluZm8vZW1tL2luZGV4
LnBocC9saXN0cy9sZDY1Mzl5M2M5NTA4L3Vuc3Vic2NyaWJlL3BrMDk0enA3b3YwYjIvb3Q4OTJo
c3lsZ2M5MQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRv
IHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAx
Lm9yZwo=
