Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEBC358E5A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Apr 2021 22:29:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3679D100EBBC0;
	Thu,  8 Apr 2021 13:29:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.127.179.132; helo=vis5.visionedmsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@visionedmsummit.info; receiver=<UNKNOWN> 
Received: from vis5.visionedmsummit.info (unknown [209.127.179.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BCF65100ED49E
	for <linux-nvdimm@lists.01.org>; Thu,  8 Apr 2021 13:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=visionedmsummit.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@visionedmsummit.info;
 bh=QBCueyIQ2JqzwNtZ26+Xmp0hGAg=;
 b=l0AvMUYiNhtFtyURiyJCYe6u0usfugoJbBmJPAftXByTopcsCNlgEWSL8IarMijkzPfnPlDA6B6L
   jOF5b9Bj9i7NWfXLjUj5em8wtcsLKLtt2JMNKpQpeIXB7VUWoTMpQQDfNV34x4Gyno5TtewL6dNa
   2+u/DBAJUl5WKm8ZGdP1cfCeaRL1eLllsarmODxFNu+G+7qNaCB8HOYqWoRaBnN0C2+brVmZAfUZ
   ThbnRmqle9GRuW51sGvluJmQEM1mhgjNeA18QYXwlEzvZMtGJfhwnKfsQ6DUctiHC0xtzbp31zzF
   zIo4NAhjqsrKBSVY/UhBjojh6H90e//H+PjI4A==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=visionedmsummit.info;
 b=sqGneXfycvZDlyj7Lrtfv7AH7v9p4cKzvfzBWDak8WHMkPgDl6SW5eNKfOgqrVidELYhKI+tHhls
   Pv8aVmOCOy14TthjTAqXh8PIvpLINTLt1bDOdMNSyMb+HXInAp3JRPbcwrr7KQLRKon4qxbhDPU1
   pRFnpZg/2bG1lt7hSFx/sr+56sosCXE6WAVQyJ4lEoRlvthe52ErQFMkJ13Mx+XFNXI4PLO37ozs
   MoNz5jvrMx8kNbwmcPPeKoWuZPCEeUgNCf3j8TcGrnW0G6NX8shg+8NqgfnkaYqpSqI7/1mpS/Ag
   22t6I2zxbptj1byk0DvSCERVxgVo4B+vMVxkpA==;
Received: from visionedmsummit.info (127.0.0.1) by vis1.visionedmsummit.info id hdtjqji19tk8 for <linux-nvdimm@lists.01.org>; Thu, 8 Apr 2021 21:09:09 +0200 (envelope-from <info-linux+2Dnvdimm=lists.01.org@visionedmsummit.info>)
Message-ID: <27334acb50f54f7e739b94dec8a65d3d@visionedmsummit.info>
Date: Thu, 08 Apr 2021 19:09:09 +0000
Subject: RE: business proposal
From: Olivia Miller <info@visionedmsummit.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@visionedmsummit.info
X-Report-Abuse: Please report abuse for this campaign here:
 https://visionedmsummit.info/emm/index.php/campaigns/xz7563oazf69c/report-abuse/rq535d20zra64/zc794ppvse116
X-Receiver: linux-nvdimm@lists.01.org
X-Kybl-Tracking-Did: 0
X-Kybl-Subscriber-Uid: zc794ppvse116
X-Kybl-Mailer: SwiftMailer - 5.4.x
X-Kybl-EBS: https://visionedmsummit.info/emm/index.php/lists/block-address
X-Kybl-Delivery-Sid: 1
X-Kybl-Customer-Uid: zj5322lg4s957
X-Kybl-Customer-Gid: 0
X-Kybl-Campaign-Uid: xz7563oazf69c
Precedence: bulk
Feedback-ID: xz7563oazf69c:zc794ppvse116:rq535d20zra64:zj5322lg4s957
Message-ID-Hash: JVPODPSERZDI7JPH7T2JZMC2LJXCQH3V
X-Message-ID-Hash: JVPODPSERZDI7JPH7T2JZMC2LJXCQH3V
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@visionedmsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Olivia Miller <olivia.millerbusiness21@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JVPODPSERZDI7JPH7T2JZMC2LJXCQH3V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXJlIHlvdSBpbnRlcmVzdGVkIHRvIHNlZSBhIHNhbXBsZSBvZiBMaW5rZWRJbiBWZXJpZmllZCAx
MDAlIGFjY3VyYXRlDQpkYXRhYmFzZSBpbiBleGNlbCBmaWxlIGZvciB1bmxpbWl0ZWQgdXNhZ2Vz
LiBFbWFpbCBDYW1wYWlnbiBvcHRpb24gaXMNCmFsc28gYXZhaWxhYmxlIHdpdGggdXMuDQoqIENF
T3MsIG93bmVycywgUHJlc2lkZW50cyBhbmQgTURzIGVtYWlsIGxpc3QNCiogQ0lPLCBDVE8sIENJ
U08sIFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgSVQsIElUIENvbXBsaWFuY2UsIElUIFJpc2ssDQpC
SSwgQ2xvdWQsIERhdGFiYXNlIGFuZCBJVCBTZWN1cml0eSBtYW5hZ2VycyBlbWFpbCBsaXN0DQoq
IENGTywgQ29udHJvbGxlciwgVlAvRGlyZWN0b3IvTWFuYWdlciBvZiBGaW5hbmNlLCBBY2NvdW50
cyBQYXlhYmxlLA0KQWNjb3VudHMgUmVjZWl2YWJsZSwgQXVkaXQgbWFuYWdlcnMgZW1haWwgbGlz
dA0KKiBWUC9EaXJlY3Rvci9NYW5hZ2VyIG9mIEN1c3RvbWVyIFNlcnZpY2UgYW5kIEN1c3RvbWVy
IFN1Y2Nlc3MNCm1hbmFnZXJzIGVtYWlsIGxpc3QNCiogVHJhZGVyL2ludmVzdG9ycyBlbWFpbCBs
aXN0DQoqIFRlbGVjb20gbWFuYWdlcnMsIFZPSVAgbWFuYWdlcnMsIENsb3VkIGFyY2hpdGVjdCwg
Q2xvdWQgbWFuYWdlcnMsDQpTdG9yYWdlIG1hbmFnZXJzIGVtYWlsIGxpc3QNCiogU21hbGwgQnVz
aW5lc3Mgb3duZXJzIGVtYWlsIGxpc3QNCiogUHVyY2hhc2luZyBhbmQgUHJvY3VyZW1lbnQgTWFu
YWdlcnMgZW1haWwgbGlzdA0KKiBQaHlzaWNpYW5zLCBEb2N0b3JzLCBOdXJzZXMsIERlbnRpc3Rz
LCBUaGVyYXBpc3RzIGVtYWlsIGxpc3QNCiogUGhhcm1hY2lzdCBhbmQgcGhhcm1hY3kgb3duZXJz
IGVtYWlsIGxpc3QNCiogT2lsLCBHYXMgYW5kIHV0aWxpdHkgaW5kdXN0cnkgZGVjaXNpb24gbWFr
ZXJzIGVtYWlsIGxpc3QNCiogTmV3ICYgVXNlZCBDYXIgRGVhbGVycyBlbWFpbCBsaXN0DQoqIE1h
cmtldGluZywgc29jaWFsIG1lZGlhLCBTYWxlcywgZGVtYW5kIGdlbmVyYXRpb24sIExlYWQgZ2Vu
ZXJhdGlvbg0KZGVjaXNpb24gbWFrZXJzIGVtYWlsIGxpc3QNCiogTWFudWZhY3R1cmluZyBJbmR1
c3RyeSBkZWNpc2lvbiBtYWtlcnMgZW1haWwgbGlzdA0KKiBMb2dpc3RpY3MsIHNoaXBwaW5nLCBh
bmQgc3VwcGx5IGNoYWluIG1hbmFnZXJzIGVtYWlsIGxpc3QNCiogSVNWL1ZBUnMvUmVzZWxsZXJz
IGVtYWlsIGxpc3QNCiogSW5kaXZpZHVhbCBpbnN1cmFuY2UgYWdlbnRzIGVtYWlsIGxpc3QNCiog
SFIsIFRyYWluaW5nLCBMZWFybmluZyAmIERldmVsb3BtZW50LCBFbXBsb3llZSBCZW5lZml0cywg
VGFsZW50DQpBY3F1aXNpdGlvbiwgUmVjcnVpdGluZyBkZWNpc2lvbiBtYWtlcnMgZW1haWwgbGlz
dA0KKiBIb3NwaXRhbHMsIGNsaW5pY3MsIHByaXZhdGUgcHJhY3RpY2VzLCBQaGFybWFjZXV0aWNh
bCBhbmQNCmJpb3RlY2hub2xvZ3kgY29tcGFueeKAmXMgdG9wIGRlY2lzaW9uIG1ha2VycyBlbWFp
bCBsaXN0DQoqIEhvbWVvd25lcnMsIEFwYXJ0bWVudCBvd25lcnMsIEJ1aWxkaW5nIG93bmVyIGVt
YWlsIGxpc3QNCiogSGlnaCBuZXQgd29ydGggaW5kaXZpZHVhbHMvaW52ZXN0b3JzIGVtYWlsIGxp
c3QNCiogSGVhbHRoLCBlbnZpcm9ubWVudCAmIFNhZmV0eSBtYW5hZ2VycyBlbWFpbCBsaXN0DQoq
IEdvdmVybm1lbnQgZGVjaXNpb24gbWFrZXJzIGVtYWlsIGxpc3QNCiogR2VuZXJhbCBhbmQgY29y
cG9yYXRlIGNvdW5zZWxzIGVtYWlsIGxpc3QNCiogRmxlZXQgbWFuYWdlcnMsIFRydWNraW5nIGNv
bXBhbnkgb3duZXJzIGVtYWlsIGxpc3QNCiogRmluYW5jaWFsIHBsYW5uZXIvYWR2aXNvcnMgZW1h
aWwgbGlzdA0KKiBGYWNpbGl0aWVzLCBvZmZpY2UgYW5kIG1haW50ZW5hbmNlIG1hbmFnZXJzIGVt
YWlsIGxpc3QNCiogRXZlbnQgYW5kIE1lZXRpbmcgcGxhbm5lcnMsIG9yZ2FuaXplcnMsIGFuZCBl
eGhpYml0b3JzIGVtYWlsIGxpc3QNCiogRW5naW5lZXJzIGVtYWlsIGxpc3QNCiogRWR1Y2F0aW9u
IGluZHVzdHJ5IGV4ZWN1dGl2ZXMgZW1haWwgbGlzdCAtIFByaW5jaXBhbHMsIERlYW4sDQpBZG1p
bnMgYW5kIHRlYWNoZXJzIGZyb20gU2Nob29scywgQ29sbGVnZXMgYW5kIFVuaXZlcnNpdGllcw0K
KiBFLWNvbW1lcmNlIG9yIG9ubGluZSByZXRhaWxlcnMgZW1haWwgbGlzdA0KKiBEYXRhIHNjaWVu
dGlzdCwgRGF0YSBBbmFseXRpY3MgYW5kIERhdGFiYXNlIEFkbWluaXN0cmF0b3JzIGVtYWlsDQps
aXN0DQoqIENQQSBhbmQgQm9va2tlZXBlcnMgZW1haWwgbGlzdA0KKiBDb21wbGlhbmNlIGFuZCBS
aXNrIE1hbmFnZW1lbnQgbWFuYWdlcnMgZW1haWwgbGlzdA0KKiBDb21tZXJjaWFsIHByb3BlcnR5
IG93bmVycyBlbWFpbCBsaXN0DQoqIEJ1aWxkZXJzLCBwcm9wZXJ0eSBkZXZlbG9wZXJzIGFuZCBj
b25zdHJ1Y3Rpb24gaW5kdXN0cnkgZGVjaXNpb24NCm1ha2VycyBlbWFpbCBsaXN0DQoqIEF0dG9y
bmV5cyBhbmQgTGF3eWVycyBlbWFpbCBsaXN0DQoqIEFyY2hpdGVjdHMgYW5kIGludGVyaW9yIGRl
c2lnbmVycyBlbWFpbCBsaXN0DQpQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4NCk9s
aXZpYSBNaWxsZXINCkVtYWlsIERhdGFiYXNlIFByb3ZpZGVyDQpVbnN1YnNjcmliZQ0KaHR0cHM6
Ly92aXNpb25lZG1zdW1taXQuaW5mby9lbW0vaW5kZXgucGhwL2xpc3RzL3JxNTM1ZDIwenJhNjQv
dW5zdWJzY3JpYmUvemM3OTRwcHZzZTExNi94ejc1NjNvYXpmNjljDQrCoA0KwqANCsKgDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0g
bWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUg
c2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
