Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8389231414D
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 22:09:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4C0C100EAB52;
	Mon,  8 Feb 2021 13:09:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.193.117; helo=ceo7.ceoemailfinder.info; envelope-from=info-linux+2dnvdimm=lists.01.org@ceoemailfinder.info; receiver=<UNKNOWN> 
Received: from ceo7.ceoemailfinder.info (ip117.ip-51-83-193.eu [51.83.193.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 258E3100F225A
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 13:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=ceoemailfinder.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@ceoemailfinder.info;
 bh=UhEgK/QS52ShFWaSwwAxEDtL7H4=;
 b=w09Ol5z3mSRVyUJFjDT3u+HQx0SlEY0zwAzAIHReigPoSR356MOS9qHhFGM4tXJrxGXfOniNmzEm
   UUHQf31ckzLZELARNGimOpYDi/zILHIMnJ9bR+eJzo+WHrWLy0tI4J/O/SbkLSUHB6H+H16TTuRV
   UOD36EtloKLg8+Pm2NFCyYLp9qZqpvsCrJ5OdXs09EnhC07i9MYg03Ww/yboultaV7VesmajBCGx
   2ds4DLwF8T2iERXI3dMH9bOUhmxwXqdLDVVSGXvbDfgRzWU9qcSjbFTyfkWJ238vPhTSTFZAkock
   yGNbcXld2NgrQ82uVLyB+o6KOhgjnC2kEpKPhw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=ceoemailfinder.info;
 b=goDYOWNTNeBs594lKb5m8VY03+aE/F6Qp2e+PZ089lNSLSGHqQi98F9ukebWtjNa/IuLFJ3iTLBh
   /1omLF3hEsq5SH/m73IVuuGx+KEvhjJzRNBk3Oqq0WPniMWPjwzavRrDoTb9csnS1btG+01yGhCj
   QMoaVC+W9dpMs+BNtvDuJcyHFzXofSmZvjozpR+XmKUbkps1sjmly/JTzokxFc+l8GMGjC58h+31
   DCShxX1aQXMtMAlN6zXRqV3OGrR3yaC0u/+YGwELSZ9sC/Di6NgXz45In/b4vS2X7Q1w8EEjU38T
   c8C5PEwX3jehttJHgXa1sNdBFeczO83CR3jGNQ==;
Received: from ceoemailfinder.info (127.0.0.1) by ceo1.ceoemailfinder.info id h46k6pi19tkb for <linux-nvdimm@lists.01.org>; Mon, 8 Feb 2021 21:00:34 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@ceoemailfinder.info>)
Message-ID: <908a07cbf25a52bc1aa851260a7b0baa@ceoemailfinder.info>
Date: Mon, 08 Feb 2021 21:00:34 +0000
Subject: RE: Follow up
From: Sophia Williams <info@ceoemailfinder.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@ceoemailfinder.info
X-Report-Abuse: Please report abuse for this campaign here:
 http://ceoemailfinder.info/app/index.php/campaigns/pz6686bo1h814/report-abuse/vt3541rbjs34d/zt837z15co2f7
X-Receiver: linux-nvdimm@lists.01.org
X-Cfhh-Tracking-Did: 0
X-Cfhh-Subscriber-Uid: zt837z15co2f7
X-Cfhh-Mailer: SwiftMailer - 5.4.x
X-Cfhh-EBS: http://ceoemailfinder.info/app/index.php/lists/block-address
X-Cfhh-Delivery-Sid: 1
X-Cfhh-Customer-Uid: on987d5f1x791
X-Cfhh-Customer-Gid: 0
X-Cfhh-Campaign-Uid: pz6686bo1h814
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: pz6686bo1h814:zt837z15co2f7:vt3541rbjs34d:on987d5f1x791
Message-ID-Hash: 67RRIUW6LQ2CQBK2JMXXV4H67KQH5N5N
X-Message-ID-Hash: 67RRIUW6LQ2CQBK2JMXXV4H67KQH5N5N
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@ceoemailfinder.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Sophia Williams <sophia.williams@edmstarmarketing.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/67RRIUW6LQ2CQBK2JMXXV4H67KQH5N5N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Q2FuIEkgc2hhcmUgeW91ciBjbGllbnRzIGRhdGEgc2FtcGxlIHdpdGggeW91Pw0KKiBBcmNoaXRl
Y3RzIGFuZCBpbnRlcmlvciBkZXNpZ25lcnMgZW1haWwgbGlzdA0KKiBDRU8sIG93bmVyLCBQcmVz
aWRlbnQgYW5kIENPTyBjb250YWN0cw0KKiBDRk8sIENvbnRyb2xsZXIsIFZQL0RpcmVjdG9yL01h
bmFnZXIgb2YgRmluYW5jZSwgQWNjb3VudHMgUGF5YWJsZSwNCkFjY291bnRzIFJlY2VpdmFibGUs
IEF1ZGl0IENvbnRhY3RzDQoqIENoaWVmIEh1bWFuIFJlc291cmNlcyBPZmZpY2VyLCBWUC9EaXJl
Y3Rvci9NYW5hZ2VyIG9mIEhSLCBFbXBsb3llZQ0KQmVuZWZpdHMsIEVtcGxveWVlIENvbW11bmlj
YXRpb25zLCBFbXBsb3llZSBDb21wZW5zYXRpb24sIEVtcGxveWVlDQpFbmdhZ2VtZW50LCBFbXBs
b3llZSBFeHBlcmllbmNlIGFuZCBFbXBsb3llZSBSZWxhdGlvbnMsIFRhbGVudA0KQWNxdWlzaXRp
b24sIFRhbGVudCBEZXZlbG9wbWVudCwgVGFsZW50IE1hbmFnZW1lbnQsIFJlY3J1aXRpbmcNCkNv
bnRhY3RzDQoqIENJTyxDVE8sIENJU08sIFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgSVQsIElUIENv
bXBsaWFuY2UsIElUIFJpc2ssDQpCSSwgQ2xvdWQsIERhdGFiYXNlIGFuZCBJVCBTZWN1cml0eSBD
b250YWN0cw0KKiBDTU8sIFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgTWFya2V0aW5nLCBzb2NpYWwg
bWVkaWEsIFNhbGVzLCBkZW1hbmQNCmdlbmVyYXRpb24sIExlYWQgZ2VuZXJhdGlvbiwgaW5zaWRl
IHNhbGVzLCBNYXJrZXRpbmcgQ29tbXVuaWNhdGlvbnMNCmNvbnRhY3RzIGV0Yy4NCiogQ29tcGxp
YW5jZSBhbmQgUmlzayBNYW5hZ2VtZW50IENvbnRhY3RzDQoqIENQQSBhbmQgQm9va2tlZXBlcnMg
ZW1haWwgbGlzdA0KKiBEYXRhIEFuYWx5dGljcyBhbmQgRGF0YWJhc2UgQWRtaW5pc3RyYXRvcnMg
Y29udGFjdHMNCiogRGlzYXN0ZXIgUmVjb3ZlcnkgQ29udGFjdHMNCiogRS1jb21tZXJjZSBvciBv
bmxpbmUgcmV0YWlsZXJzIGVtYWlsIGxpc3QNCiogRWR1Y2F0aW9uIGluZHVzdHJ5IGV4ZWN1dGl2
ZXMgZW1haWwgbGlzdCAtIFByaW5jaXBhbHMsIERlYW4sDQpBZG1pbnMgYW5kIHRlYWNoZXJzIGZy
b20gU2Nob29scywgQ29sbGVnZXMgYW5kIFVuaXZlcnNpdGllcw0KKiBFbmdpbmVlcnMgZW1haWwg
bGlzdA0KKiBFdmVudCBhbmQgbWVldGluZyBwbGFubmVycyBlbWFpbCBsaXN0DQoqIEZhY2lsaXRp
ZXMgYW5kIG9mZmljZSBtYW5hZ2VyIENvbnRhY3RzDQoqIEdlbmVyYWwgYW5kIGNvcnBvcmF0ZSBj
b3Vuc2VsIGFzIHdlbGwgbGVnYWwgcHJvZmVzc2lvbmFscyBsaXN0DQoqIEdvdmVybm1lbnQgY29u
dHJhY3RvcnMgZW1haWwgbGlzdA0KKiBIZWFsdGggJiBTYWZldHkgQ29udGFjdHMNCiogSGlnaCBu
ZXQgd29ydGggaW5kaXZpZHVhbHMvaW52ZXN0b3JzIGVtYWlsIGxpc3QNCiogSG9zcGl0YWxzLCBj
bGluaWNzLCBwcml2YXRlIHByYWN0aWNlcywgUGhhcm1hY2V1dGljYWwgYW5kDQpiaW90ZWNobm9s
b2d5IGNvbXBhbnnigJlzIHRvcCBkZWNpc2lvbiBtYWtlcnMgZW1haWwgbGlzdA0KKiBIdW1hbiBD
YXBpdGFsIE1hbmFnZW1lbnQgQ29udGFjdHMNCiogSW5kaXZpZHVhbCBpbnN1cmFuY2UgYWdlbnRz
IGxpc3QNCiogSVNWL1ZBUnMgbGlzdA0KKiBMZWFybmluZyAmIERldmVsb3BtZW50IENvbnRhY3Rz
DQoqIExvZ2lzdGljcywgc2hpcHBpbmcgYW5kIHN1cHBseSBjaGFpbiBtYW5hZ2VycyBlbWFpbCBs
aXN0DQoqIE1hbnVmYWN0dXJpbmcgSW5kdXN0cnkgZXhlY3V0aXZlcyBsaXN0DQoqIE5ldHdvcmsg
bWFuYWdlciwgU3VydmVpbGxhbmNlLCBTeXN0ZW0gQWRtaW5pc3RyYXRvciwgVGVjaG5pY2FsDQpT
dXBwb3J0IENvbnRhY3RzDQoqIE5ldyAmIFVzZWQgQ2FyIERlYWxlcnMgZW1haWwgbGlzdA0KKiBP
aWwsIEdhcyBhbmQgdXRpbGl0eSBpbmR1c3RyeSBjb250YWN0cw0KKiBQaHlzaWNpYW5zLCBEb2N0
b3JzLCBOdXJzZXMsIERlbnRpc3RzLCBUaGVyYXBpc3RzIGVtYWlsIGxpc3QNCiogUGxhbnQgTWFu
YWdlciBDb250YWN0cw0KKiBQcm9kdWN0IGFuZCBwcm9qZWN0IG1hbmFnZW1lbnQgbGlzdA0KKiBQ
dXJjaGFzaW5nIGFuZCBQcm9jdXJlbWVudCBDb250YWN0cw0KKiBTcGVjaWZpYyBFdmVudCBhdHRl
bmRlZXMgbGlzdA0KKiBUZWxlY29tIG1hbmFnZXJzLCBWT0lQIG1hbmFnZXJzLCBDbG91ZCBhcmNo
aXRlY3QsIENsb3VkIG1hbmFnZXJzLA0KU3RvcmFnZSBtYW5hZ2VycyBlbWFpbCBsaXN0DQoqIFZQ
L0RpcmVjdG9yL01hbmFnZXIgb2YgQ3VzdG9tZXIgU2VydmljZSBhbmQgQ3VzdG9tZXIgU3VjY2Vz
cw0KVGhhbmtzIGFuZCBsZXQgbWUga25vdy4NClNvcGhpYSBXaWxsaWFtcw0KRGF0YWJhc2UgTWFy
a2V0aW5nDQpVbnN1YnNjcmliZQ0KaHR0cDovL2Nlb2VtYWlsZmluZGVyLmluZm8vYXBwL2luZGV4
LnBocC9saXN0cy92dDM1NDFyYmpzMzRkL3Vuc3Vic2NyaWJlL3p0ODM3ejE1Y28yZjcvcHo2Njg2
Ym8xaDgxNA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRv
IHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAx
Lm9yZwo=
