Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8BF2E6A93
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Dec 2020 21:15:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E4FF100EF271;
	Mon, 28 Dec 2020 12:15:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.68.149.146; helo=ceo2.trendeduedmsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@trendeduedmsummit.info; receiver=<UNKNOWN> 
Received: from ceo2.trendeduedmsummit.info (ip146.ip-51-68-149.eu [51.68.149.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 20A7F100EF267
	for <linux-nvdimm@lists.01.org>; Mon, 28 Dec 2020 12:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=trendeduedmsummit.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@trendeduedmsummit.info;
 bh=UvYyj79vRUQEewIQ9MMomgz5ejU=;
 b=rTukzKk4bhjQbdbzbPS7MrsFOQ6jsNUKfdXUnYRuKsmHou6P+L1nTJP/RjbKVA2H4n2aif8cu445
   KwDaiHWxA7pUkC9RDelIJP8plu6bMubkAz0uLWj7WKd7bLHWy1L+KAw32KC3KMssIoM5Skr0eayY
   4xKMIsNVmn/14WEMccwmq4IctVuY0dr0r79Y6MsqIttc7A/k1QCLR1a8M3fdUPT1Z/0+lZfNSvAU
   goXQVelhv6KPbvClmtwNuk8/UWkTwJhH/VymAlI0jD1Mjp88EyTdEQSzllh8f3jiKR+S6cQUQ0gr
   +hi/r3JUekkLanKsozw5tScWuEHTNWiwaKBDCQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=trendeduedmsummit.info;
 b=Vlk00QVtTflP+bu6j0L0BUKxqaMKiS9k34CvnJiDSxzbhKe6RcQVnf7Om+NA9KpABk3xcxvVS48j
   5c4Km/QayhIrVlPcRmzMrjfZvA5x+W1KWdZyHi+qS6lkXbd+V09CAwbmStsHYb6JUfPEQ6BlwCV1
   ySr1iynCtrMsiTzNH3JWpDA4Fjxp9kRpOrDznSlVrVlOa3faYai6Hz63nOUcxnwf5z8T9DrqFrsf
   gzIm000VO+BXFSHcPhC6EEztve2TgNj/FfNHGfBSWVxw47nIaNh869IASlr/CQ3GcB3tNxgHOHGv
   /eGFam4tUQ9v4S8joklXMj8VEBn3/PT+9Y257g==;
Received: from trendeduedmsummit.info (127.0.0.1) by ceo1.trendeduedmsummit.info id ht8ufji19tkl for <linux-nvdimm@lists.01.org>; Mon, 28 Dec 2020 20:15:46 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@trendeduedmsummit.info>)
Message-ID: <a86a479e42a4109097fc7261b86c2f57@trendeduedmsummit.info>
Date: Mon, 28 Dec 2020 20:15:46 +0000
Subject: RE: did you get my email
From: Susan Taylor <info@trendeduedmsummit.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@trendeduedmsummit.info
X-Report-Abuse: Please report abuse for this campaign here:
 http://trendeduedmsummit.info/emm/index.php/campaigns/tv780wb6yo61e/report-abuse/ld6539y3c9508/pk094zp7ov0b2
X-Receiver: linux-nvdimm@lists.01.org
X-Ffws-Tracking-Did: 0
X-Ffws-Subscriber-Uid: pk094zp7ov0b2
X-Ffws-Mailer: SwiftMailer - 5.4.x
X-Ffws-EBS: http://trendeduedmsummit.info/emm/index.php/lists/block-address
X-Ffws-Delivery-Sid: 1
X-Ffws-Customer-Uid: ws867mym7e562
X-Ffws-Customer-Gid: 0
X-Ffws-Campaign-Uid: tv780wb6yo61e
Precedence: bulk
Feedback-ID: tv780wb6yo61e:pk094zp7ov0b2:ld6539y3c9508:ws867mym7e562
Message-ID-Hash: TH3EE6A2WVNPI4XG5M3ONKYFIIBNR4DD
X-Message-ID-Hash: TH3EE6A2WVNPI4XG5M3ONKYFIIBNR4DD
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@trendeduedmsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Susan Taylor <susan.taylordata@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TH3EE6A2WVNPI4XG5M3ONKYFIIBNR4DD/>
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
bW9yZS4NClN1c2FuIFRheWxvcg0KRW1haWwgTWFya2V0aW5nDQpVbnN1YnNjcmliZQ0KaHR0cDov
L3RyZW5kZWR1ZWRtc3VtbWl0LmluZm8vZW1tL2luZGV4LnBocC9saXN0cy9sZDY1Mzl5M2M5NTA4
L3Vuc3Vic2NyaWJlL3BrMDk0enA3b3YwYjIvdHY3ODB3YjZ5bzYxZQ0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlz
dCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1h
aWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
