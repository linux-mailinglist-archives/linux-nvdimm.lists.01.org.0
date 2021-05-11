Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6237A845
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 May 2021 15:57:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 75EEC100EB32C;
	Tue, 11 May 2021 06:57:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=82.202.160.247; helo=ceo8.b2blinkeddatabase.info; envelope-from=info-linux+2dnvdimm=lists.01.org@b2blinkeddatabase.info; receiver=<UNKNOWN> 
Received: from ceo8.b2blinkeddatabase.info (unknown [82.202.160.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 348BD100EBBDD
	for <linux-nvdimm@lists.01.org>; Tue, 11 May 2021 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=b2blinkeddatabase.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@b2blinkeddatabase.info;
 bh=bLpBD8wtXOtUFYUf9J1ZFgecqVs=;
 b=I6LDpkyRofHJ36cNTSJAOnJ7VT07dvJa9aIOQwkkApXoj5VGbHJG7wgq7CbsgU914VBR9qmoCt94
   lOgpxxGomUkD3GNxYi7fWiW07Rme3z8hnp/g40sZvmSq3dOixvlg9q2OPDrRF5Gd+koqJWbx8j71
   7y0nfusbrG+QMwB2E8r67cnDyFe156u8ZUhCD/4hmQZw1+h5xCXA9lr0Gs2EzxN7dd5w/4IyWanY
   tmczV9VuPaWzgfrHk6iixhtzrkyTk+/Qjex+KEzAF0qJbI4EisOEmv4+MRWcfZnKximxBL3OjVUv
   czBFpqDeTns54tt/KuNyrW2gvaQbYpceANvwIg==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=b2blinkeddatabase.info;
 b=fleZRG9xzOctCBwFHCaRX9O2IM1cJC92df/y7p7BT4Zs6NfZHxmm2tS4/HB1vfzb6eyOxQuq2v55
   8+eV5Ko00EnU0J2ls6Bmkcovg4W169gWyIvkdwVEjXDAYLaktLBoU7pshHalsUdGIb4TPZ8T3x0m
   swqkjrQsEEtFgDEg+Ogedpw/aCINQXJDG6MIeHnVoWx5o/SAPPTOkzECSFx1iIaFux4D4QM6vrOA
   ew4VxjJkBdz8xVvPGV9DNEFvs7/6dHOicQnCz2uIKRjuaYi4jysUmp4Ki+SSCf/aOHMSmz/9gYdB
   iRFYxu9h45XURw4NRKi79ROmxODvLN0uwCf/Ag==;
Received: from b2blinkeddatabase.info (127.0.0.1) by ceo1.b2blinkeddatabase.info id hja6jti19tkj for <linux-nvdimm@lists.01.org>; Tue, 11 May 2021 04:09:38 +0300 (envelope-from <info-linux+2Dnvdimm=lists.01.org@b2blinkeddatabase.info>)
Message-ID: <3f9d2232be379b50d10a1a83ca000b48@b2blinkeddatabase.info>
Date: Tue, 11 May 2021 01:09:38 +0000
Subject: RE: 100k Client details at $500
From: Sara Taylor <info@b2blinkeddatabase.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@b2blinkeddatabase.info
X-Report-Abuse: Please report abuse for this campaign here:
 https://b2blinkeddatabase.info/emm/index.php/campaigns/fn986akphhdea/report-abuse/fw854rkhve69a/kh853511etd7e
X-Receiver: linux-nvdimm@lists.01.org
X-Poyq-Tracking-Did: 0
X-Poyq-Subscriber-Uid: kh853511etd7e
X-Poyq-Mailer: SwiftMailer - 5.4.x
X-Poyq-EBS: https://b2blinkeddatabase.info/emm/index.php/lists/block-address
X-Poyq-Delivery-Sid: 1
X-Poyq-Customer-Uid: jt8014h46gbc0
X-Poyq-Customer-Gid: 0
X-Poyq-Campaign-Uid: fn986akphhdea
Precedence: bulk
Feedback-ID: fn986akphhdea:kh853511etd7e:fw854rkhve69a:jt8014h46gbc0
Message-ID-Hash: LR4LQV7SW7TWQV5SAJGDHZVGYFLVYVO2
X-Message-ID-Hash: LR4LQV7SW7TWQV5SAJGDHZVGYFLVYVO2
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@b2blinkeddatabase.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Sara Taylor <sarajohntaylor@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LR4LQV7SW7TWQV5SAJGDHZVGYFLVYVO2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QmVjYXVzZSBvZiBidXNpbmVzc2VzIGFyZSBzbG93IHdlIGFyZSBvZmZlcnJpbmcgMTAwLDAwMCBl
bWFpbA0KZGF0YWJhc2VzIGp1c3QgYXQgJDUwMCBvbmx5IGZvciBNYXkuDQpPdXIgZGF0YWJhc2Vz
IGNvdmVyIGFsbCBjaXRpZXMuDQoqIENFT3MsIG93bmVycywgUHJlc2lkZW50cyBhbmQgTURzIGVt
YWlsIGxpc3QNCiogQ0lPLCBDVE8sIENJU08sIFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgSVQsIElU
IENvbXBsaWFuY2UsIElUIFJpc2ssDQpCSSwgQ2xvdWQsIERhdGFiYXNlIGFuZCBJVCBTZWN1cml0
eSBtYW5hZ2VycyBlbWFpbCBsaXN0DQoqIENGTywgQ29udHJvbGxlciwgVlAvRGlyZWN0b3IvTWFu
YWdlciBvZiBGaW5hbmNlLCBBY2NvdW50cyBQYXlhYmxlLA0KQWNjb3VudHMgUmVjZWl2YWJsZSwg
QXVkaXQgbWFuYWdlcnMgZW1haWwgbGlzdA0KKiBWUC9EaXJlY3Rvci9NYW5hZ2VyIG9mIEN1c3Rv
bWVyIFNlcnZpY2UgYW5kIEN1c3RvbWVyIFN1Y2Nlc3MNCm1hbmFnZXJzIGVtYWlsIGxpc3QNCiog
VHJhZGVyL2ludmVzdG9ycyBlbWFpbCBsaXN0DQoqIFRlbGVjb20gbWFuYWdlcnMsIFZPSVAgbWFu
YWdlcnMsIENsb3VkIGFyY2hpdGVjdCwgQ2xvdWQgbWFuYWdlcnMsDQpTdG9yYWdlIG1hbmFnZXJz
IGVtYWlsIGxpc3QNCiogU21hbGwgQnVzaW5lc3Mgb3duZXJzIGVtYWlsIGxpc3QNCiogUHVyY2hh
c2luZyBhbmQgUHJvY3VyZW1lbnQgTWFuYWdlcnMgZW1haWwgbGlzdA0KKiBQaHlzaWNpYW5zLCBE
b2N0b3JzLCBOdXJzZXMsIERlbnRpc3RzLCBUaGVyYXBpc3RzIGVtYWlsIGxpc3QNCiogUGhhcm1h
Y2lzdCBhbmQgcGhhcm1hY3kgb3duZXJzIGVtYWlsIGxpc3QNCiogT2lsLCBHYXMgYW5kIHV0aWxp
dHkgaW5kdXN0cnkgZGVjaXNpb24gbWFrZXJzIGVtYWlsIGxpc3QNCiogTmV3ICYgVXNlZCBDYXIg
RGVhbGVycyBlbWFpbCBsaXN0DQoqIE1hcmtldGluZywgc29jaWFsIG1lZGlhLCBTYWxlcywgZGVt
YW5kIGdlbmVyYXRpb24sIExlYWQgZ2VuZXJhdGlvbg0KZGVjaXNpb24gbWFrZXJzIGVtYWlsIGxp
c3QNCiogTWFudWZhY3R1cmluZyBJbmR1c3RyeSBkZWNpc2lvbiBtYWtlcnMgZW1haWwgbGlzdA0K
KiBMb2dpc3RpY3MsIHNoaXBwaW5nLCBhbmQgc3VwcGx5IGNoYWluIG1hbmFnZXJzIGVtYWlsIGxp
c3QNCiogSVNWL1ZBUnMvUmVzZWxsZXJzIGVtYWlsIGxpc3QNCiogSW5kaXZpZHVhbCBpbnN1cmFu
Y2UgYWdlbnRzIGVtYWlsIGxpc3QNCiogSFIsIFRyYWluaW5nLCBMZWFybmluZyAmIERldmVsb3Bt
ZW50LCBFbXBsb3llZSBCZW5lZml0cywgVGFsZW50DQpBY3F1aXNpdGlvbiwgUmVjcnVpdGluZyBk
ZWNpc2lvbiBtYWtlcnMgZW1haWwgbGlzdA0KKiBIb3NwaXRhbHMsIGNsaW5pY3MsIHByaXZhdGUg
cHJhY3RpY2VzLCBQaGFybWFjZXV0aWNhbCBhbmQNCmJpb3RlY2hub2xvZ3kgY29tcGFueeKAmXMg
dG9wIGRlY2lzaW9uIG1ha2VycyBlbWFpbCBsaXN0DQoqIEhvbWVvd25lcnMsIEFwYXJ0bWVudCBv
d25lcnMsIEJ1aWxkaW5nIG93bmVyIGVtYWlsIGxpc3QNCiogSGlnaCBuZXQgd29ydGggaW5kaXZp
ZHVhbHMvaW52ZXN0b3JzIGVtYWlsIGxpc3QNCiogSGVhbHRoLCBlbnZpcm9ubWVudCAmIFNhZmV0
eSBtYW5hZ2VycyBlbWFpbCBsaXN0DQoqIEdvdmVybm1lbnQgZGVjaXNpb24gbWFrZXJzIGVtYWls
IGxpc3QNCiogR2VuZXJhbCBhbmQgY29ycG9yYXRlIGNvdW5zZWxzIGVtYWlsIGxpc3QNCiogRmxl
ZXQgbWFuYWdlcnMsIFRydWNraW5nIGNvbXBhbnkgb3duZXJzIGVtYWlsIGxpc3QNCiogRmluYW5j
aWFsIHBsYW5uZXIvYWR2aXNvcnMgZW1haWwgbGlzdA0KKiBGYWNpbGl0aWVzLCBvZmZpY2UgYW5k
IG1haW50ZW5hbmNlIG1hbmFnZXJzIGVtYWlsIGxpc3QNCiogRXZlbnQgYW5kIE1lZXRpbmcgcGxh
bm5lcnMsIG9yZ2FuaXplcnMsIGFuZCBleGhpYml0b3JzIGVtYWlsIGxpc3QNCiogRW5naW5lZXJz
IGVtYWlsIGxpc3QNCiogRWR1Y2F0aW9uIGluZHVzdHJ5IGV4ZWN1dGl2ZXMgZW1haWwgbGlzdCAt
IFByaW5jaXBhbHMsIERlYW4sDQpBZG1pbnMgYW5kIHRlYWNoZXJzIGZyb20gU2Nob29scywgQ29s
bGVnZXMgYW5kIFVuaXZlcnNpdGllcw0KKiBFLWNvbW1lcmNlIG9yIG9ubGluZSByZXRhaWxlcnMg
ZW1haWwgbGlzdA0KKiBEYXRhIHNjaWVudGlzdCwgRGF0YSBBbmFseXRpY3MgYW5kIERhdGFiYXNl
IEFkbWluaXN0cmF0b3JzIGVtYWlsDQpsaXN0DQoqIENQQSBhbmQgQm9va2tlZXBlcnMgZW1haWwg
bGlzdA0KKiBDb21wbGlhbmNlIGFuZCBSaXNrIE1hbmFnZW1lbnQgbWFuYWdlcnMgZW1haWwgbGlz
dA0KKiBDb21tZXJjaWFsIHByb3BlcnR5IG93bmVycyBlbWFpbCBsaXN0DQoqIEJ1aWxkZXJzLCBw
cm9wZXJ0eSBkZXZlbG9wZXJzIGFuZCBjb25zdHJ1Y3Rpb24gaW5kdXN0cnkgZGVjaXNpb24NCm1h
a2VycyBlbWFpbCBsaXN0DQoqIEF0dG9ybmV5cyBhbmQgTGF3eWVycyBlbWFpbCBsaXN0DQoqIEFy
Y2hpdGVjdHMgYW5kIGludGVyaW9yIGRlc2lnbmVycyBlbWFpbCBsaXN0DQpQbGVhc2UgbGV0IG1l
IGtub3cgeW91ciB0aG91Z2h0cy4NClNhcmEgdGF5bG9yDQpFbWFpbCBEYXRhYmFzZSBQcm92aWRl
cg0KVW5zdWJzY3JpYmUNCmh0dHBzOi8vYjJibGlua2VkZGF0YWJhc2UuaW5mby9lbW0vaW5kZXgu
cGhwL2xpc3RzL2Z3ODU0cmtodmU2OWEvdW5zdWJzY3JpYmUva2g4NTM1MTFldGQ3ZS9mbjk4NmFr
cGhoZGVhDQrCoA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3Jn
ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3Rz
LjAxLm9yZwo=
