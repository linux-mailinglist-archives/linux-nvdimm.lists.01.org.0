Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43694292C92
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Oct 2020 19:22:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B85915E63D93;
	Mon, 19 Oct 2020 10:22:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.174.127; helo=edm3.edmsysevent.info; envelope-from=info-linux+2dnvdimm=lists.01.org@edmsysevent.info; receiver=<UNKNOWN> 
Received: from edm3.edmsysevent.info (ip127.ip-51-83-174.eu [51.83.174.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5B3EC15E63D8F
	for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=edmsysevent.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@edmsysevent.info;
 bh=YJllm+2FGlsPr84AjdPx/PIAvSg=;
 b=RlLJl5ciLb+WnOtXgiUpA+A/4/Pz5Pk/Z1l07Kxcpum/hIZxKpfsR7nKECTksUNVO115y1Clpbdp
   PAl6GG8HMlB80uhTp9Z6dSufzg/SDId9egJFvj3gow1bC38+WS/7DHiiL6ed7OKicswiImSRM9XQ
   iZHEFjOA9l7B0Tc8fJhicOI5MN93BGysjeSSw1DO7FUCHI2ethdYByskAk6b2GjHzifejzjqU3zZ
   eKFuB8W2hMB7ChfI5qc5DtbBPA+9blj06s8EQvIGT721FeJPicBzdglDTh7xKiVc1MqHZT6dGzHU
   pXkW2ButHa1/z16zylNp/YF8COGNiAowa1tjPw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=edmsysevent.info;
 b=GTbPZ+JlPFbg2DNVOp3oQRoZWRv0EGijt+5tB9Zax0+C401Zmmpiz68UlXjnoMYO/VR2ttAtMYz1
   cHLCGnEgmaAm8LIE4qG/LYV5qM+6bIecZTF0iXfQUuknBGi/YdpFZ82KEYF30OlBU3gtRgi7uAk2
   lBCl+Bg/+T1t2xh1ld9bLIN7CZgIjYGkAJB8YM7zvP0yCvKQQVmV/qAW2VwxJJvIcPSlvBy+kKGX
   rWbvOU2tKw6Yx6digcmQuD/OOUtjTKMemUGlTFQqk315py3PDvNtQIGR4QFkkD5MxetWst/I8CNL
   4oRIocq/9WkzT9bVFhs6dzrLGrKYjdZJZXFxpQ==;
Received: from edmsysevent.info (127.0.0.1) by edm1.edmsysevent.info id hhn5m3i19tkk for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 17:19:47 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@edmsysevent.info>)
Date: Mon, 19 Oct 2020 17:19:47 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: KIMBERLY RODRIGUEZ <info@edmsysevent.info>
Subject: RE: Conference call request
Message-ID: <d0ba6444b0998767c9df176f883c9ace@edmsysevent.info>
X-Npfn-Campaign-Uid: gg6771m5xb9f3
X-Npfn-Subscriber-Uid: gg671rrs1ge52
X-Npfn-Customer-Uid: xy379q9k4f7b3
X-Npfn-Customer-Gid: 0
X-Npfn-Delivery-Sid: 1
X-Npfn-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://edmsysevent.info/ecm/index.php/campaigns/gg6771m5xb9f3/report-abuse/tx143bon723c4/gg671rrs1ge52
Feedback-ID: gg6771m5xb9f3:gg671rrs1ge52:tx143bon723c4:xy379q9k4f7b3
Precedence: bulk
X-Npfn-EBS: https://edmsysevent.info/ecm/index.php/lists/block-address
X-Sender: info@edmsysevent.info
X-Receiver: linux-nvdimm@lists.01.org
X-Npfn-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: 52WJNNVMC6C6SOYWWOXQDX3656WL3PKU
X-Message-ID-Hash: 52WJNNVMC6C6SOYWWOXQDX3656WL3PKU
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@edmsysevent.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: KIMBERLY RODRIGUEZ <KIMBERLY@eventattendsummits.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/52WJNNVMC6C6SOYWWOXQDX3656WL3PKU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSBob3BlIGFsbCBpcyB3ZWxsIHdpdGggeW91LCB5b3VyIGZhbWlseSwgZnJpZW5kcyBhbmQgY29s
bGVhZ3Vlcy4NCkF0IDUwJSBjb3N0IHdvdWxkIHlvdSBsaWtlIHRvIG1pZ3JhdGUgdG8gUHVibGlj
IENsb3VkcyAoQVdTLCBBenVyZSwNCkdDUCBvciBTYWxlc2ZvcmNlKT8NCldlIGhhdmUgcHJvdmVu
IGV4cGVydGlzZSBpbiBldmVyeSBhc3BlY3Qgb2YgQ2xvdWQgRW5naW5lZXJpbmcgYW5kDQpNaWdy
YXRpb24NCk91ciBjbGllbnRzIGluY2x1ZGUgU2lsaWNvbiBWYWxsZXkgTGVhZGVycywgRm9ydHVu
ZSAxMDAgY3VzdG9tZXJzIGFuZA0KbWlkLW1hcmtldCBjbGllbnRzLiBXZSBoZWxwIG91ciBjbGll
bnRzIGFjaGlldmUgdGhlIG1pZ3JhdGlvbiBpbiBhDQpUaW1lIEJveGVkLCBCdWRnZXQgQm94ZWQs
IFJpc2stbWl0aWdhdGVkIGFwcHJvYWNoLg0KV2UgYXJlIGZsZXhpYmxlIGluIG91ciBidXNpbmVz
cyBhcHByb2FjaCDigJMgd2UgY2FuIGRvIEZpeGVkIFByaWNlDQpjb250cmFjdHMgb3IgZG8gVGlt
ZSBhbmQgTWF0ZXJpYWxzDQpXZSBhcmUgcHJvZHVjdCBhZ25vc3RpYy4gV2UgYXJlIHZlcnkgZmFt
aWxpYXIgd2l0aCB0aGUgYmVzdCBpbiBjbGFzcw0KdG9vbHMgdG8gaGVscCB5b3UgaW4geW91ciBj
bG91ZCBqb3VybmV5DQpJZiB0aGlzIG1pZ2h0IGJlIG9mIGludGVyZXN0IHRvIHlvdSzCoGNhbiB5
b3Ugc3VnZ2VzdCBhIDEwIG1pbiBzbG90DQp0aGF0IHdpbGwgd29yayBmb3IgeW91Pw0KQmVzdCB3
aXNoZXMgdG8geW91IGFuZCB5b3VyIGZhbWlseSBmb3IgaGVhbHRoIGFuZCB3ZWxsbmVzcy4NClJl
Z2FyZHMsIFRoYW5rIHlvdS4NCktJTUJFUkxZIFJPRFJJR1VFWg0KQ2xvdWQgTWlncmF0aW9uICYg
QnVzaW5lc3MgRGV2ZWxvcG1lbnQNCig2NzgpIDc0NS04Mzg1DQpVbnN1YnNjcmliZQ0KaHR0cHM6
Ly9lZG1zeXNldmVudC5pbmZvL2VjbS9pbmRleC5waHAvbGlzdHMvdHgxNDNib243MjNjNC91bnN1
YnNjcmliZS9nZzY3MXJyczFnZTUyL2dnNjc3MW01eGI5ZjMNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAt
LSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwg
dG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
