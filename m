Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1286331DF0B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 19:22:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A55A100EBB81;
	Wed, 17 Feb 2021 10:22:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.77.33.216; helo=ceo1.ceoemailfinder.info; envelope-from=info-linux+2dnvdimm=lists.01.org@ceoemailfinder.info; receiver=<UNKNOWN> 
Received: from ceo1.ceoemailfinder.info (ip216.ip-51-77-33.eu [51.77.33.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F126C100EBBDB
	for <linux-nvdimm@lists.01.org>; Wed, 17 Feb 2021 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=ceoemailfinder.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@ceoemailfinder.info;
 bh=pdc3MxiHKjJqBSLkUD1u8B5X9ug=;
 b=Q99LzyijElAQxOkv7jZn/U2gDqoHBV0pAYoL4Ig3B9aHGc3Ld/22YVd3nqb85xFYKQgg558Q0pYR
   /yHAKgHmG2bQf9zDrO5ffZoCfU83LIooTZ6nt2zzeCkQgRAlg/I5EncECWoEqx4y0lRLDB/V+Vcu
   QC5dHMNtUY0gNWZfW1L5Mwj6W8FJBwV7LZU3uCYOHadY8LcR24C5226L3+cQoq3kkAJGmSlek+In
   jc8d5AZh81m/dHxeR4PBuhsZl9WxUBpOq3buApz4hF6LCEiwYYt31zpxQCJjamypSs+OjqEcM5GA
   bqMH/6MpkPz/00xLWIkQP/J+cUUwfybdC6qPaQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=ceoemailfinder.info;
 b=aejVTtyVl/4oFr3gbil2NxwidIaezmceReBLHoM9BBzO14EnExNVa+SaL4eMtsqR6bDJBMrOM/oC
   ZtiR9KQYwfP4OtqMGrg1yRtP7Q2e+7XNq5dHBTp9xzHF/oHhgBLs92Ipcxbv21ieGmwmR+oO4GEb
   9sxPLP+UdL1jNjFDfcpGVhoAKfusp+oWAAzyE7JeWEVI7HsfNVtp+5tQNBkjIeBHmLKd8EFgfURg
   PvqFtg2DiKEjvJvkv08PPfjMYY7yww4ou+/XywNn5babb/9wD3kYvLEHHI8QYqoNBmlWMYrFoTE5
   zDRvmPd6fDS2RP6PJw3soDmduK/sWgpgBMI6uw==;
Received: from ceoemailfinder.info (127.0.0.1) by ceo1.ceoemailfinder.info id h5lfcni19tk6 for <linux-nvdimm@lists.01.org>; Wed, 17 Feb 2021 18:21:57 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@ceoemailfinder.info>)
Message-ID: <b8246e6791b09ab4bbfa990cfcde6eb8@ceoemailfinder.info>
Date: Wed, 17 Feb 2021 18:21:57 +0000
Subject: RE: 100k at 250
From: Rachel Griffin <info@ceoemailfinder.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@ceoemailfinder.info
X-Report-Abuse: Please report abuse for this campaign here:
 http://ceoemailfinder.info/app/index.php/campaigns/ep324g713pe89/report-abuse/vt3541rbjs34d/zt837z15co2f7
X-Receiver: linux-nvdimm@lists.01.org
X-Cfhh-Tracking-Did: 0
X-Cfhh-Subscriber-Uid: zt837z15co2f7
X-Cfhh-Mailer: SwiftMailer - 5.4.x
X-Cfhh-EBS: http://ceoemailfinder.info/app/index.php/lists/block-address
X-Cfhh-Delivery-Sid: 1
X-Cfhh-Customer-Uid: on987d5f1x791
X-Cfhh-Customer-Gid: 0
X-Cfhh-Campaign-Uid: ep324g713pe89
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: ep324g713pe89:zt837z15co2f7:vt3541rbjs34d:on987d5f1x791
Message-ID-Hash: GNEYGSQGSDUWWMEWLWUTFAMUSPSVUOAB
X-Message-ID-Hash: GNEYGSQGSDUWWMEWLWUTFAMUSPSVUOAB
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@ceoemailfinder.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Rachel Griffin <rachelgriffinmail@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GNEYGSQGSDUWWMEWLWUTFAMUSPSVUOAB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RW1haWwgbWFya2V0aW5nIHRvIHlvdXIgdGFyZ2V0IGF1ZGllbmNlKGFueSBjaXR5L2FueSBjb3Vu
dHJ5KSBmcm9tIG91cg0KZGF0YWJhc2Ugd2lsbCBnZW5lcmF0ZSBtYXNzaXZlIGxlYWRzIGFuZCBz
ZXQgYXBwb2ludG1lbnRzLCB3ZSBoYXZlDQp2ZXJpZmllZCBhbmQgdGFyZ2V0ZWQgNjBNaWwgQjJC
IGFuZCAxODAgTWlsIEIyQyBkYXRhIGZvciBhbGwNCmNhdGVnb3JpZXMgZ2xvYmFsbHkuIFdlIHdp
bGwgc2hhcmUgb3BlbnMgYW5kIGNsaWNrcyBhbHNvIHdpdGggdGhlDQpjb21wbGV0ZcKgcmVwb3J0
DQrCoCAqwqAgwqBCYXNpYyBQbGFuOiBBdMKgJDI1MMKgd2Ugd2lsbCBzZW5kIDEwMCwwMDAgRW1h
aWxzIHdpdGhpbiBhDQptb250aCB0byB5b3VyIHRhcmdldCBhdWRpZW5jZQ0KwqAgKsKgIMKgU3Rh
bmRhcmQgUGxhbjogQXQgJDc1MCB3ZSB3aWxsIHNlbmQgMU1pbCBFbWFpbHMgd2l0aGluIGENCm1v
bnRoIHRvIHlvdXIgdGFyZ2V0IGF1ZGllbmNlDQrCoCAqwqAgwqBQcmVtaXVtIHBsYW46IEF0ICQx
LDk5OSB3ZSB3aWxsIHNlbmQgNU1pbCBFbWFpbHMgd2l0aGluIGENCm1vbnRoIHRvIHlvdXIgdGFy
Z2V0IGF1ZGllbmNlDQpUaGFua3MgYW5kIGxldCBtZSBrbm93IGlmIHlvdSB3aXNoIHRvIGtub3cg
bW9yZS4NClJhY2hlbCBHcmlmZmluDQpFbWFpbCBNYXJrZXRpbmcNCisxLSg2NzgpIDc0NS04Mzg1
DQpVbnN1YnNjcmliZQ0KaHR0cDovL2Nlb2VtYWlsZmluZGVyLmluZm8vYXBwL2luZGV4LnBocC9s
aXN0cy92dDM1NDFyYmpzMzRkL3Vuc3Vic2NyaWJlL3p0ODM3ejE1Y28yZjcvZXAzMjRnNzEzcGU4
OQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vi
c2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
