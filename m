Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C662F954C
	for <lists+linux-nvdimm@lfdr.de>; Sun, 17 Jan 2021 21:59:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 48B40100EC1DD;
	Sun, 17 Jan 2021 12:59:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.191.225; helo=app10.appendleadedm.info; envelope-from=contact-linux+2dnvdimm=lists.01.org@appendleadedm.info; receiver=<UNKNOWN> 
Received: from app10.appendleadedm.info (ip225.ip-51-83-191.eu [51.83.191.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D01C6100EC1D9
	for <linux-nvdimm@lists.01.org>; Sun, 17 Jan 2021 12:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=appendleadedm.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=contact@appendleadedm.info;
 bh=k5wtHeXpWzbkHQ/1Lu80KP0ZDPM=;
 b=SdhurFLHfpA+betoYxPK4ouEVSNzmU8Lk49ObAloNhPsZgH1KQPdd6R93Zl1Gemrvr48B2UYX4q8
   yI/PQlwrD1RFCpcG8Sn9lwg15XGVxibdF3/J7Rm5bh4qBQmNhby/a4b4R3J9L68sucWACE+NtM9C
   UQKSurl5EkgCAZXxy85AbvX5RvtOBstO9nKcxLU5OAecDdoa/dfnpjsUF3iHBKCUEVdjHRYKEeKa
   2XnnLx1VVqzCl3TKOmoZm4F2H7Cl83qNUBo3QVeb/pRlDRyOIzI7KKSxN/pNEpTB2wFSTGtHRPJ8
   xQkv3Sj5vwoTdLaEkYJQ/B2CP/jjzDHG2B/cEw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=appendleadedm.info;
 b=SaP2kSr4YoPDbhGR9G2K3XGFhAK14VDW3NXwJdK38kBWy5WN3CBbXAG1tC7qPY0oAHgxbnCoPJB/
   zFtapKLWwj+BXausB1lP3Cf2ks4UNLUUAts+mbCLdTxSDSJnmLW8tSh05TCzII+Gm1IP0lImScmK
   /80LEKsD5nNXKSGgvRBTVblYiu8YMLmBx4m5tmxcahRzf3di6A9eC97ISEGcAWRZpe2WfIV0uu/m
   J9ABMgHtWDSfjbdrSX4VITGiwJ5RVfEoZ0STBiChewszEGALQ7UTppXIVSrgwy4JVHHD7/5ER7K2
   XAU0DQh+R1boawU/pcETwANxeupbbFdnNo7N0A==;
Received: from appendleadedm.info (127.0.0.1) by app1.appendleadedm.info id h0iiibi19tkr for <linux-nvdimm@lists.01.org>; Sun, 17 Jan 2021 20:59:14 +0000 (envelope-from <contact-linux+2Dnvdimm=lists.01.org@appendleadedm.info>)
Message-ID: <38f66035387ff18a75696882ca28e98f@appendleadedm.info>
Date: Sun, 17 Jan 2021 20:59:14 +0000
Subject: RE: Campaign report
From: Rachel Griffin <contact@appendleadedm.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: contact@appendleadedm.info
X-Report-Abuse: Please report abuse for this campaign here:
 http://appendleadedm.info/emm/index.php/campaigns/ps936f0z7w730/report-abuse/fc852ksheaa89/rp659hnss9052
X-Receiver: linux-nvdimm@lists.01.org
X-Ooqx-Tracking-Did: 0
X-Ooqx-Subscriber-Uid: rp659hnss9052
X-Ooqx-Mailer: SwiftMailer - 5.4.x
X-Ooqx-EBS: http://appendleadedm.info/emm/index.php/lists/block-address
X-Ooqx-Delivery-Sid: 1
X-Ooqx-Customer-Uid: fv107j3jh8cf0
X-Ooqx-Customer-Gid: 0
X-Ooqx-Campaign-Uid: ps936f0z7w730
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: ps936f0z7w730:rp659hnss9052:fc852ksheaa89:fv107j3jh8cf0
Message-ID-Hash: RSHVLKQIMYPQUGNFTU6MRXAKMNEQQOGQ
X-Message-ID-Hash: RSHVLKQIMYPQUGNFTU6MRXAKMNEQQOGQ
X-MailFrom: contact-linux+2Dnvdimm=lists.01.org@appendleadedm.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Rachel Griffin <rachelgriffinmail@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RSHVLKQIMYPQUGNFTU6MRXAKMNEQQOGQ/>
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
bW9yZS4NClJhY2hlbCBHcmlmZmluDQpFbWFpbCBNYXJrZXRpbmcNClVuc3Vic2NyaWJlDQpodHRw
Oi8vYXBwZW5kbGVhZGVkbS5pbmZvL2VtbS9pbmRleC5waHAvbGlzdHMvZmM4NTJrc2hlYWE4OS91
bnN1YnNjcmliZS9ycDY1OWhuc3M5MDUyL3BzOTM2ZjB6N3c3MzANCsKgDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBs
aXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBl
bWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
