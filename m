Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D84E30839A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 Jan 2021 03:13:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94C0E100EB846;
	Thu, 28 Jan 2021 18:13:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.191.223; helo=app4.appendleadedm.info; envelope-from=contact-linux+2dnvdimm=lists.01.org@appendleadedm.info; receiver=<UNKNOWN> 
Received: from app4.appendleadedm.info (ip223.ip-51-83-191.eu [51.83.191.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D3959100EB83A
	for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 18:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=appendleadedm.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=contact@appendleadedm.info;
 bh=DqwdjrtIffoRp1EbvBVbqlVHnO4=;
 b=m6BYVcv/n1A4d2EkTBtrcC4EVyfUSYB1yZNrh2hH+92P6MwgEpzycCLLvVEeeZpXa2LjaxEn+wKt
   r+m7/ThMK35LnU/iVzbD8uKzwbd6hBLkKm8Eo0gDjJ9pWT/tPzKm+lo5l2/oMA+ZVtq84SLLdgEu
   DtIfHbS41elDDtg2vl6QbOVyDRg5Pffq0apbML3/fvStL4+T8SlAY0yiS8Bj6XQhaJr/tkGgMdnA
   OjjMSEfVMH5ppavHTQUiWIuCkQvZshT3ZHkboemZ7dt9tsdZCz85f7u/yJooJuQeyLoOdAFuuIjb
   x5q5K7sn6Qf24a2t3H+1pzfs0EjL8hwqQk50/w==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=appendleadedm.info;
 b=hgejMaAYQxIWF/zlaJcgHsOnDdTeXRWWrUQJCKcHL2Rdvn7lLEVrW7ywvTWSL+dRdeYE3Mz5Dnse
   IcEknMEFPH5xNjHm0bgrnYjZeGS0ahXFWk7ILF66zOlsqbUn259pdmMOk1y9r+jkd+0/WyN779Vz
   /9EV03MGI8eAxr459KQRWysNZ4Zz2K0ZgurTsfXeQrIxWm8MPpK813RaalyTZJkKff/SZx8MRhmg
   +k7ZDkWnT1TiPMnGIjGvJLaNHtj2LJXWcUM3izBcjXmiqHJGf+P/v5IC1rXc1rmebGunUbccezR4
   liD2KJ2a2KYFKdushQtjQhxMIgDPXIRpp75xXA==;
Received: from appendleadedm.info (127.0.0.1) by app1.appendleadedm.info id h2dnjpi19tkg for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 02:07:58 +0000 (envelope-from <contact-linux+2Dnvdimm=lists.01.org@appendleadedm.info>)
Date: Fri, 29 Jan 2021 02:07:58 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Emily Johnson <contact@appendleadedm.info>
Subject: RE: 10K LinkedIn Leads at 500
Message-ID: <bfe5b4d0bc12ddbf3be916e083574234@appendleadedm.info>
X-Ooqx-Campaign-Uid: zt3694bzp83e2
X-Ooqx-Subscriber-Uid: al733opd9n292
X-Ooqx-Customer-Uid: fv107j3jh8cf0
X-Ooqx-Customer-Gid: 0
X-Ooqx-Delivery-Sid: 1
X-Ooqx-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: http://appendleadedm.info/emm/index.php/campaigns/zt3694bzp83e2/report-abuse/tm309l31m36a2/al733opd9n292
Feedback-ID: zt3694bzp83e2:al733opd9n292:tm309l31m36a2:fv107j3jh8cf0
Precedence: bulk
X-Ooqx-EBS: http://appendleadedm.info/emm/index.php/lists/block-address
X-Sender: contact@appendleadedm.info
X-Receiver: linux-nvdimm@lists.01.org
X-Ooqx-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: RDK6T4CDDJTKHX5YWBJHVLAA77FO4QPB
X-Message-ID-Hash: RDK6T4CDDJTKHX5YWBJHVLAA77FO4QPB
X-MailFrom: contact-linux+2Dnvdimm=lists.01.org@appendleadedm.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Emily Johnson <emily.johnsontarget@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RDK6T4CDDJTKHX5YWBJHVLAA77FO4QPB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXJlIHlvdSBpbnRlcmVzdGVkIHRvIHB1cmNoYXNlIDEwMCUgYWNjdXJhdGUgMTAsMDAwIFRhcmdl
dGVkIExlYWRzDQpmcm9tIExpbmtlZEluIGF0ICQ1MDAoQW55IHRpdGxlcy9pbmR1c3RyeS9sb2Nh
dGlvbi9rZXl3b3Jkcyk/DQpJZiB5b3UgaGF2ZSBhIHZlcnkgdGFyZ2V0ZWQgZGF0YSByZXF1aXJl
bWVudCBhbmQgeW91IG5lZWQgTGlua2VkSW4NCmRhdGFiYXNlLCB3ZSB3aWxsIHB1bGwgdGFyZ2V0
ZWQgZGF0YWJhc2VzIGZvciB5b3Ugd2l0aCB0aGVpciBMaW5rZWRJbg0KcHJvZmlsZSBsaW5rLCBu
YW1lLCB0aXRsZSwgZW1haWwgYWRkcmVzcywgY29tcGFueSBuYW1lLCBjaXR5LCBjb21wYW55DQpz
aXplIGV0Yy4gUGxlYXNlIHNoYXJlIHlvdXIgdGFyZ2V0IGF1ZGllbmNlIGFuZCBJIHdpbGwgc3Vw
cGx5IHRoZQ0Kc2FtcGxlIHdpdGhpbiAxIGJ1c2luZXNzIGRheXPigJkgdGltZS4NClRoYW5rcyBh
bmQgbGV0IG1lIGtub3cuDQpFbWlseSBKb2huc29uDQpMaW5rZWRJbiBEYXRhYmFzZSBQcm92aWRl
cg0KKzEtKDY3OCkgNzQ1LTgzODUNClVuc3Vic2NyaWJlDQpodHRwOi8vYXBwZW5kbGVhZGVkbS5p
bmZvL2VtbS9pbmRleC5waHAvbGlzdHMvdG0zMDlsMzFtMzZhMi91bnN1YnNjcmliZS9hbDczM29w
ZDluMjkyL3p0MzY5NGJ6cDgzZTINCsKgDQrCoA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4
LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51
eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
