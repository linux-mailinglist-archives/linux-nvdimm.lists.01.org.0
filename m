Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E603430CDDC
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 22:22:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A48A100EB34D;
	Tue,  2 Feb 2021 13:22:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.191.220; helo=app1.appendleadedm.info; envelope-from=contact-linux+2dnvdimm=lists.01.org@appendleadedm.info; receiver=<UNKNOWN> 
Received: from app1.appendleadedm.info (ip220.ip-51-83-191.eu [51.83.191.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 729DE100EB342
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 13:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=appendleadedm.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=contact@appendleadedm.info;
 bh=lLpF42ASyBQyu1/zt5FTz6QYcpE=;
 b=ct1QPKrm6v6rj6xKXxMHlWJ0obZSuHVLSSGxHydEbF3jKTdfJKvOJ1cZ3OpgHmu5JrL7DwKcU0c8
   iBejNGSuWM88JnfrwOLBLBIubYtShLJnigd+nSNP6ArG4zcIJuIK8UGObRl26nFgB1uzRXtUh+rN
   CYi7gT03bDFL3qILB/5AQxmA8JzXPElurhlREXED6mlBqdPQIsGpWPAvddkGWEfgI0Hs5/+LxvhS
   TmfJA/2r6imGETmt0lqBrfZlgJAPwGVAlAAARCU2Ub9x5wykMI3NrWmu+OLNA6CHAC29aqc/ytl3
   Y6N0cq3Akp8tYLMRihguO2kd+FGqLOBNP8J85w==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=appendleadedm.info;
 b=LlUwsnKVOk/f+oLOdo0pDjGBimME7f0leXbdPIzV6cjRg+Pcpn6xADTCkjcZKa0Hm42oBVHY2+eX
   DIY7u3cTMeFvbEOs+DWrsfeH8RMxJvR6AnQd5RzL4fXd6pXKIUDlCwHgOVL6PPkt3GakZoyjCWz8
   OiCnK3iQAe1CQA0zg6m+DTjNWvfrQReXX++H9lRm3xo/PFZZWvSpiNppyNHFD9iSgnSkV9G5X4n9
   wjNTzU2nod9btatDrooSWXE6RC7kE1jJiBrQLYV4fHAew0uemFYf8hP9LSRbAi9tQG3pr5Fmxm1y
   p1yUYJc0g9fAyJy7SoyWdm8+rj3I5VxIQAhc+g==;
Received: from appendleadedm.info (127.0.0.1) by app1.appendleadedm.info id h371ani19tkq for <linux-nvdimm@lists.01.org>; Tue, 2 Feb 2021 21:15:53 +0000 (envelope-from <contact-linux+2Dnvdimm=lists.01.org@appendleadedm.info>)
Date: Tue, 2 Feb 2021 21:15:53 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Susan Taylor <contact@appendleadedm.info>
Subject: RE: Conference call
Message-ID: <04d4897633ce40a995c47b182c2a9afc@appendleadedm.info>
X-Ooqx-Campaign-Uid: pm05337we6e03
X-Ooqx-Subscriber-Uid: al733opd9n292
X-Ooqx-Customer-Uid: fv107j3jh8cf0
X-Ooqx-Customer-Gid: 0
X-Ooqx-Delivery-Sid: 1
X-Ooqx-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: http://appendleadedm.info/emm/index.php/campaigns/pm05337we6e03/report-abuse/tm309l31m36a2/al733opd9n292
Feedback-ID: pm05337we6e03:al733opd9n292:tm309l31m36a2:fv107j3jh8cf0
Precedence: bulk
X-Ooqx-EBS: http://appendleadedm.info/emm/index.php/lists/block-address
X-Sender: contact@appendleadedm.info
X-Receiver: linux-nvdimm@lists.01.org
X-Ooqx-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: DKJW6YAWUQT6XLWMDRMQJUAXDIIT5WVQ
X-Message-ID-Hash: DKJW6YAWUQT6XLWMDRMQJUAXDIIT5WVQ
X-MailFrom: contact-linux+2Dnvdimm=lists.01.org@appendleadedm.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Susan Taylor <susan.taylordata@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DKJW6YAWUQT6XLWMDRMQJUAXDIIT5WVQ/>
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
bmRsZWFkZWRtLmluZm8vZW1tL2luZGV4LnBocC9saXN0cy90bTMwOWwzMW0zNmEyL3Vuc3Vic2Ny
aWJlL2FsNzMzb3BkOW4yOTIvcG0wNTMzN3dlNmUwMw0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxp
bnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBs
aW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
