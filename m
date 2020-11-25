Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 151102C3BD8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Nov 2020 10:20:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4EEB6100EF25B;
	Wed, 25 Nov 2020 01:20:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.68.149.183; helo=ceo4.edmceoattendevent.info; envelope-from=info-linux+2dnvdimm=lists.01.org@edmceoattendevent.info; receiver=<UNKNOWN> 
Received: from ceo4.edmceoattendevent.info (ip183.ip-51-68-149.eu [51.68.149.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2CD86100EF257
	for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 01:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=edmceoattendevent.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@edmceoattendevent.info;
 bh=KPOBZYSGTIPVMeSh7/JA65e8P/Q=;
 b=d5unVO4neu5twhe8IuIZP1v6o+fHWU2oAR04taRbwUbLFWPjAkSvYyaAKJ2E7Lg0Tay6Qt3UxOZ6
   2jzVqyC0iyu6hi99l+2vPSeOYuGJQwk8WFGTdeA8miZiX0J//tm46/rrQ3vfzziciz4pdtDrpxlR
   aSk6Srgpan2+tyL77Of/ZIx2p8szTZJZ6wgpNbYxPkrHbEGIuHFXoVEAFFZUEUEkusPNc7+oWyI+
   ljxDxwAVxoh6/v1i3OEWlVDXhCULUSYJNThsXaQKL1u/+cHRr/fG/mnmbq6LdMgqUAbZ2+293nZT
   /xBQML5tPhC2fFX/o8CddEV8LttE+sWVEhryRg==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=edmceoattendevent.info;
 b=UZh83bDQN2U8o85dDGUrQ4RAFuO5PcTKJp/nwo4HMQbV7WD4cLjQ/W8fgHCMu5jEwMMrc6fm8Z1V
   TJ9gHOh/KegygU2b19bqpy5G2+ohwuK9OreYRIYRSJjmjVh6FwgnVbyaRbVKDsUh3lKff/59SsCo
   JVAKT6uJ4xRNQB4vX82XCi3pCQnszt6FkD+M8vs28Kr6GrY6VvW+xSPsmqLge+Jqus6xgGtKsAwk
   rn1pZhRI1xL62lph+LTaMY7NtGkGG4KY+hFyLbmpkOkqDlWhpom57t4yqYhzGgl1qyUm5ztZjXNG
   95wgbnihwh7w66KCdCLRcKIxjgt9Mf8qD9gj4Q==;
Received: from edmceoattendevent.info (54.37.138.114) by ceo1.edmceoattendevent.info id hnogsbi19tka for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 09:16:13 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@edmceoattendevent.info>)
Date: Wed, 25 Nov 2020 09:16:13 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Rachel Griffin <info@edmceoattendevent.info>
Subject: RE: Follow up
Message-ID: <c846e9e03c6f2c5ec83490f15eb84d8a@edmceoattendevent.info>
X-Rcde-Campaign-Uid: xb412wzm693dc
X-Rcde-Subscriber-Uid: fe430bmfo58c0
X-Rcde-Customer-Uid: kj6787n91o3e8
X-Rcde-Customer-Gid: 0
X-Rcde-Delivery-Sid: 1
X-Rcde-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://edmceoattendevent.info/latest/index.php/campaigns/xb412wzm693dc/report-abuse/nd8360ceo07ce/fe430bmfo58c0
Feedback-ID: xb412wzm693dc:fe430bmfo58c0:nd8360ceo07ce:kj6787n91o3e8
Precedence: bulk
X-Rcde-EBS: https://edmceoattendevent.info/latest/index.php/lists/block-address
X-Sender: info@edmceoattendevent.info
X-Receiver: linux-nvdimm@lists.01.org
X-Rcde-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: X65REOMD6MD5O22OQ25Q2WQPIDR7DCNC
X-Message-ID-Hash: X65REOMD6MD5O22OQ25Q2WQPIDR7DCNC
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@edmceoattendevent.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Rachel Griffin <rachelgriffinmail@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X65REOMD6MD5O22OQ25Q2WQPIDR7DCNC/>
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
cw0KVW5zdWJzY3JpYmUNCmh0dHBzOi8vZWRtY2VvYXR0ZW5kZXZlbnQuaW5mby9sYXRlc3QvaW5k
ZXgucGhwL2xpc3RzL25kODM2MGNlbzA3Y2UvdW5zdWJzY3JpYmUvZmU0MzBibWZvNThjMC94YjQx
Mnd6bTY5M2RjDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9y
ZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0
cy4wMS5vcmcK
