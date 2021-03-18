Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2E3409FA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Mar 2021 17:21:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 68EC1100EB34E;
	Thu, 18 Mar 2021 09:21:22 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=185.253.33.127; helo=cli2.clientprospectsts.info; envelope-from=info-linux+2dnvdimm=lists.01.org@clientprospectsts.info; receiver=<UNKNOWN> 
Received: from cli2.clientprospectsts.info (unknown [185.253.33.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B3EAF100EB34D
	for <linux-nvdimm@lists.01.org>; Thu, 18 Mar 2021 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=clientprospectsts.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@clientprospectsts.info;
 bh=Ane7VCksVfK53Y/+GFbxBGc2fbA=;
 b=SR+PAsrdJKBl/irOJrDFnofbBh0X7r6arGZ3cbM3P8v+M5GUhEBUTlQNtWBKQDdCyyMBhk4Cy+wW
   jDRAALSVmQMfgGiJu40jj2mXrSTUiOq9V2vvNevTQ+HMxL+zuuAcqQJOZiKifcaAnNXGec3J0+ai
   EBCByXPAD2xQssjLGzP0Xy8sMl42ilaHf0pHCLzU6PITrwdzHPDC0LXCRx9T34h6DvVllUIK9FYD
   R5t3h3c3OoI+tRRg4qiQW5omCEKfdG5O7by8bLrC2ahu+YjcG/aYOL+dCpxjwdjBlCLzYyuFTcJU
   DbCp3JPH8QqRc1EtTiji1SiIHHjtUNMriqo52Q==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=clientprospectsts.info;
 b=CekCB9DJlguKbKHMke9ZcgBOa4NtGGY51L1CE3y8NImMvwoAXNyoIUfRd/fJkEt4pTe759/MOmUe
   KqsrTSxmHMhhAzYs/tOAhwAORZCTpPMukTA5ZqEV3jllehVF61beV3YfenbWlGEguBqJ9ziEZ7wJ
   9XrC89Ef6MJT5bOUXaXd8OBXe/CIGb2yynokDQZvwN6YiCzDv4tUB1Dn2NN4YImlQuuofat5lT/e
   jSq/jQWxJtlBVN5FJ6voLYw1X9tyKu8cpBEphBO3IRtHvDwccZS2B55tXrRXc26EoWAXv84Kcbxg
   0vZ8Bz4ae2JRFdt1pCCo3e3aRnW3vOmvEQuVIw==;
Received: from clientprospectsts.info (127.0.0.1) by cli1.clientprospectsts.info id haduvvi19tkr for <linux-nvdimm@lists.01.org>; Thu, 18 Mar 2021 08:01:15 +0300 (envelope-from <info-linux+2Dnvdimm=lists.01.org@clientprospectsts.info>)
Message-ID: <3e1711fee79f5d569cc0339d9b61a883@clientprospectsts.info>
Date: Thu, 18 Mar 2021 05:01:15 +0000
Subject: RE: campaign setup done
From: Christian Griffin <info@clientprospectsts.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Zccg-Tracking-Did: 0
X-Zccg-Subscriber-Uid: tt025nvngm53a
X-Zccg-Mailer: SwiftMailer - 5.4.x
X-Zccg-EBS: https://clientprospectsts.info/emm/index.php/lists/block-address
X-Zccg-Delivery-Sid: 1
X-Zccg-Customer-Uid: qm31179hs914d
X-Zccg-Customer-Gid: 0
X-Zccg-Campaign-Uid: ol128xdsr051b
X-Sender: info@clientprospectsts.info
X-Report-Abuse: Please report abuse for this campaign here:
 https://clientprospectsts.info/emm/index.php/campaigns/ol128xdsr051b/report-abuse/mg210l97bg965/tt025nvngm53a
X-Receiver: linux-nvdimm@lists.01.org
Precedence: bulk
Feedback-ID: ol128xdsr051b:tt025nvngm53a:mg210l97bg965:qm31179hs914d
Message-ID-Hash: MVWHOEFL32RXAVUCQ6U7L55EMTHUVINT
X-Message-ID-Hash: MVWHOEFL32RXAVUCQ6U7L55EMTHUVINT
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@clientprospectsts.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Christian Griffin <christian.griffinceo@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MVWHOEFL32RXAVUCQ6U7L55EMTHUVINT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXJlIHlvdSBpbnRlcmVzdGVkIGluIGVtYWlsIG1hcmtldGluZyB0byB5b3VyIHRhcmdldCBhdWRp
ZW5jZShhbnkNCmNpdHkvYW55IHRpdGxlL2FueSBpbmR1c3RyeS9hbnkgY291bnRyeSkgZnJvbSBv
dXIgZGF0YWJhc2U/DQpXZSB3aWxsIGdlbmVyYXRlIG1hc3NpdmUgYW1vdW50IG9mIGxlYWRzIGFu
ZCBzZXQgYXBwb2ludG1lbnRzLCB3ZQ0KaGF2ZSB2ZXJpZmllZCBhbmQgdGFyZ2V0ZWQgNjBNaWwg
QjJCIGFuZCAxODAgTWlsIEIyQyBkYXRhIGZvciBhbGwNCmNhdGVnb3JpZXMgZ2xvYmFsbHkuIFdl
IHdpbGwgc2VuZCBlbWFpbHMgb24geW91ciBiZWhhbGYsIHNoYXJlDQpyZXBvcnRzL3Byb29mLCBz
aGFyZSBvcGVucyBhbmQgY2xpY2tzIGxpc3QuDQrCoCAqwqAgwqBCYXNpYyBQbGFuOiBBdMKgJDI1
MMKgd2Ugd2lsbCBzZW5kIDEwMCwwMDAgRW1haWxzIHdpdGhpbiBhDQptb250aCB0byB5b3VyIHRh
cmdldCBhdWRpZW5jZQ0KwqAgKsKgIMKgU3RhbmRhcmQgUGxhbjogQXQgJDc1MCB3ZSB3aWxsIHNl
bmQgMU1pbCBFbWFpbHMgd2l0aGluIGENCm1vbnRoIHRvIHlvdXIgdGFyZ2V0IGF1ZGllbmNlDQrC
oCAqwqAgwqBQcmVtaXVtIHBsYW46IEF0ICQxLDk5OSB3ZSB3aWxsIHNlbmQgNU1pbCBFbWFpbHMg
d2l0aGluIGENCm1vbnRoIHRvIHlvdXIgdGFyZ2V0IGF1ZGllbmNlDQpUaGFua3MgYW5kIGxldCBt
ZSBrbm93IGlmIHlvdSB3aXNoIHRvIGtub3cgbW9yZS4NCkNocmlzdGlhbiBHcmlmZmluDQpCdWxr
IEVtYWlsIE1hcmtldGluZyAmIExlYWQgZ2VuZXJhdGlvbiBzcGVjaWFsaXN0DQorMS0gKDY3OCkg
NzQ1LTgzODUNClVuc3Vic2NyaWJlDQpodHRwczovL2NsaWVudHByb3NwZWN0c3RzLmluZm8vZW1t
L2luZGV4LnBocC9saXN0cy9tZzIxMGw5N2JnOTY1L3Vuc3Vic2NyaWJlL3R0MDI1bnZuZ201M2Ev
b2wxMjh4ZHNyMDUxYg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxp
c3RzLjAxLm9yZwo=
