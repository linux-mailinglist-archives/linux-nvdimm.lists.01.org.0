Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D042C4047
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Nov 2020 13:36:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 91B46100ED48A;
	Wed, 25 Nov 2020 04:36:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.68.149.166; helo=ceo10.openceotrendevent.info; envelope-from=info-linux+2dnvdimm=lists.01.org@openceotrendevent.info; receiver=<UNKNOWN> 
Received: from ceo10.openceotrendevent.info (ip166.ip-51-68-149.eu [51.68.149.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C5A8100ED489
	for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 04:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=openceotrendevent.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@openceotrendevent.info;
 bh=2Qd9v/9gdoAWY99G/pM+Zaz55lU=;
 b=qptXsdn4HALTlO5QNN6CGQjhn2y98wU0dt90vG3+WkqImU/KNEGGv4RU19Sz8ZoD12UxWFesJTRl
   d/vU23sheIpRbZcGP+S6+WDMewYosJB98kPs1sLcRnOvtCWXxBMrZ9goFIHI17VzIjX9ckj4xINV
   LJpDzTEXn0qeDAMiREFif5yo+2moN4w/6HvxBlUZzCqUkbd5DYeTTsf+rADPahVOekxALM5giyAJ
   uNj89Lq540Bk845FIQFRkA4E5djiGy01pzdwFwBMytoPoeFx0TOYFl3B8ThpkNhxotDhUk6U9U2x
   8D7ruSuBp0eUuiHqk3tXBWasmlqPAOLE4802Kg==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=openceotrendevent.info;
 b=wV4YnsrycQzDThaioEccKXG4J3GB721g8/SHRN2reNexz1XRTNHEU4oVsH2LN9CUJ5fveKy1OPah
   N9zFVyjmJ2/59yY/q03o9n6K2XNumQI3mWa9LC0KLBhIqYK/EEMySCbjRsdAsJTIB+apUnnEtVDa
   PVr7U9ZXDWTCyqKaQiROeCjJHJZXMomV0G/BUwPW8oF9LBEqxspYHcdeSkHJt+2Sx4xWZX/rrOcz
   VEAAylQFTDZ5tuloeCIV8aN8YQ9fyq4H7bfOrNmkVMVnRBRLYTe2beVkLHuQp60Ngl0cjAI2D7k7
   tKRMxFifx54ORGx1HhxM6kvVBEKfQnDYN/o6qw==;
Received: from openceotrendevent.info (127.0.0.1) by ceo1.openceotrendevent.info id hnp7tni19tk1 for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 11:17:07 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@openceotrendevent.info>)
Message-ID: <2d061f54dcc5b994e1bc10705fa5762a@openceotrendevent.info>
Date: Wed, 25 Nov 2020 11:17:07 +0000
Subject: RE: Follow up
From: Rachel Griffin <info@openceotrendevent.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@openceotrendevent.info
X-Report-Abuse: Please report abuse for this campaign here:
 https://openceotrendevent.info/latest/index.php/campaigns/mj80962b0jbd0/report-abuse/hz9812n0eqd9c/ty5527or2af9e
X-Receiver: linux-nvdimm@lists.01.org
X-Dggs-Tracking-Did: 0
X-Dggs-Subscriber-Uid: ty5527or2af9e
X-Dggs-Mailer: SwiftMailer - 5.4.x
X-Dggs-EBS: https://openceotrendevent.info/latest/index.php/lists/block-address
X-Dggs-Delivery-Sid: 1
X-Dggs-Customer-Uid: dl4746dylhbde
X-Dggs-Customer-Gid: 0
X-Dggs-Campaign-Uid: mj80962b0jbd0
Precedence: bulk
Feedback-ID: mj80962b0jbd0:ty5527or2af9e:hz9812n0eqd9c:dl4746dylhbde
Message-ID-Hash: AEHPVGBBJ5J67NNCFC35HVE5XL4HVERZ
X-Message-ID-Hash: AEHPVGBBJ5J67NNCFC35HVE5XL4HVERZ
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@openceotrendevent.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Rachel Griffin <rachelgriffinmail@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AEHPVGBBJ5J67NNCFC35HVE5XL4HVERZ/>
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
bWVyIFNlcnZpY2UgYW5kIEN1c3RvbWVyIFN1Y2Nlc3MNClRoYW5rcyBhbmQgbGV0IG1lIGtub3cu
DQpSYWNoZWwgR3JpZmZpbg0KRGF0YWJhc2UgQ29uc3VsdGFudA0KNDJNaWwgQjJCIGFuZCAyMTBN
aWwgQjJDIE9wdC1pbiBFbWFpbCBhbmQgcGhvbmUgbGlzdCB3aXRoIG90aGVyIGRhdGENCmZpZWxk
cw0KVW5zdWJzY3JpYmUNCmh0dHBzOi8vb3BlbmNlb3RyZW5kZXZlbnQuaW5mby9sYXRlc3QvaW5k
ZXgucGhwL2xpc3RzL2h6OTgxMm4wZXFkOWMvdW5zdWJzY3JpYmUvdHk1NTI3b3IyYWY5ZS9tajgw
OTYyYjBqYmQwDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcK
VG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMu
MDEub3JnCg==
