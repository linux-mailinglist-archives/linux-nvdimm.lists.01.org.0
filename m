Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA5B3056B2
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 Jan 2021 10:20:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 88523100EB321;
	Wed, 27 Jan 2021 01:20:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.191.214; helo=ecow3.brandceosummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@brandceosummit.info; receiver=<UNKNOWN> 
Received: from ecow3.brandceosummit.info (ecow4.brandceosummit.info [51.83.191.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BB6D5100EBB9B
	for <linux-nvdimm@lists.01.org>; Wed, 27 Jan 2021 01:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=brandceosummit.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@brandceosummit.info;
 bh=wefPiqvNIBKpdZSZdB2qed6vM9g=;
 b=tSLXKtGjfLg6DkZ4Py3O+oQpvQ2oZjGdER9g/hs7LdhBDkMEbmMbCAjKHn1a+x9UXk1swQgxkL9P
   CDch/H7GSYEIev+Z4AHPs6Ye+k5iwmEyqxhgrmkmTbYuk3znXbC40/AbmfT3/SuJEvDt07AWofKk
   m/pPY1w+jc8sOxh/N+A8J4UEfGWu+/zUhtwfrG4pAY5+gtiskyOm7bf+99elYG0KgDMq3PeE6Fh3
   OQd05bw6byG/jj25fAmb1WwVu8AzYsnNZKrojq9ImvppsG8UuwcU1mtLTBOBWZnDH6y7sIgB+LwB
   sgebHMGQZ5GXsy01YKVxdVbU44j9riwTCTL9ig==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=brandceosummit.info;
 b=kRjN5erZ0GH0pweiF/Ir2Uzbb3uIe6k8ypZTTXJDFvTcIXeN0jUzsgn2rl9FlXDXWypc3J/FTKsz
   F9SkYKxgUGufs5AbFgVTETBSn5ls/YzqIJmkJtKisv/uVOcBAWA1HQNhrveJz2BQY7wc4gzAj76/
   gWtWvq+gfn+U5vmmmAIgGKtrb8p/v0QQqjiIi0Jp0hSkl3ixaJrkcqNMxxtT4R4EC8EMpjQuqQ4d
   EiwaFRj8TruUB/n5AkkNFz7aAk+KWZg8E4PjPDM4LA4Umct7duW/DZKkmm/6Zk2HH2CzJOCbxn00
   hr1Btt5RhPFUvcIKJkw3VVMTHYO1ZRVEvqoIfw==;
Received: from brandceosummit.info (127.0.0.1) by ecow1.brandceosummit.info id h24o75i19tku for <linux-nvdimm@lists.01.org>; Tue, 26 Jan 2021 23:53:43 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@brandceosummit.info>)
Date: Tue, 26 Jan 2021 23:53:43 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Susan Taylor <info@brandceosummit.info>
Subject: RE: did you see this email
Message-ID: <080eb898683a38fee2cc6b8048bbd17b@brandceosummit.info>
X-Ybzc-Campaign-Uid: gd339gmc8ocdb
X-Ybzc-Subscriber-Uid: tt5238ge44eaa
X-Ybzc-Customer-Uid: yc9451v43la86
X-Ybzc-Customer-Gid: 0
X-Ybzc-Delivery-Sid: 1
X-Ybzc-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://brandceosummit.info/emm/index.php/campaigns/gd339gmc8ocdb/report-abuse/db949qba8of4b/tt5238ge44eaa
Feedback-ID: gd339gmc8ocdb:tt5238ge44eaa:db949qba8of4b:yc9451v43la86
Precedence: bulk
X-Ybzc-EBS: https://brandceosummit.info/emm/index.php/lists/block-address
X-Sender: info@brandceosummit.info
X-Receiver: linux-nvdimm@lists.01.org
X-Ybzc-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: OIBAZ673WJEJGSTMI4KFMXJURYCVADBI
X-Message-ID-Hash: OIBAZ673WJEJGSTMI4KFMXJURYCVADBI
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@brandceosummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Susan Taylor <susan.taylordata@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OIBAZ673WJEJGSTMI4KFMXJURYCVADBI/>
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
DQpTdXNhbiBUYXlsb3INCkRhdGFiYXNlIENvbnN1bHRhbnQNCjQyTWlsIEIyQiBhbmQgMjEwTWls
IEIyQyBPcHQtaW4gRW1haWwgYW5kIHBob25lIGxpc3Qgd2l0aCBvdGhlciBkYXRhDQpmaWVsZHMN
CsKgDQpVbnN1YnNjcmliZQ0KaHR0cHM6Ly9icmFuZGNlb3N1bW1pdC5pbmZvL2VtbS9pbmRleC5w
aHAvbGlzdHMvZGI5NDlxYmE4b2Y0Yi91bnN1YnNjcmliZS90dDUyMzhnZTQ0ZWFhL2dkMzM5Z21j
OG9jZGINCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRv
IHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAx
Lm9yZwo=
