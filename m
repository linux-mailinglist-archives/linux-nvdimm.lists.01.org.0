Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2822ADF76
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Nov 2020 20:32:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D67381680501B;
	Tue, 10 Nov 2020 11:32:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.68.149.179; helo=ceo8.kmsattendceo.info; envelope-from=info-linux+2dnvdimm=lists.01.org@kmsattendceo.info; receiver=<UNKNOWN> 
Received: from ceo8.kmsattendceo.info (ip179.ip-51-68-149.eu [51.68.149.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 85712166F4B92
	for <linux-nvdimm@lists.01.org>; Tue, 10 Nov 2020 11:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=kmsattendceo.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@kmsattendceo.info;
 bh=w21TDGh9X4NiYim05Arf7RfMFRM=;
 b=dkrxTqcOXCwxfpzpN8TLZqQ0tlIdcBRA29FhYTXswxYBuAjL/W2r54lwkbHPMRUF/HKqQBGWaxGO
   RNLGhLDXxPQXcjYM0YDhwDijl8IbEEmsnvORL/Iae06u7e2e8Ra3+aEhfML3Na3yaOv7I/oA90hG
   a9qXTKDoCNsyniSTqlNBvjzgepq21IyOUf6W+CwLXlZ51G2zahgK7WReSRWIEv889ksyR4NbOJK9
   lM+L29f7ihxdksUQaZFlm87boo3/L/iZeWxR42deKtdXtt20TKeML7m2DqwzKnoyw/AEcp05VxQE
   t1wQymkDUwo1pcdz8pwvAXb4FeIrP2w4iyHFnw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=kmsattendceo.info;
 b=TeiFgHSFqgLaVq6Nkk0AxX0HPveW4tqm7O9/S61RBTnEx8UaOxvngaP4pQlgtOTykbn5SS2veWcR
   em+zNhUDdXPDFo/jPkfOxd0qd6WRTf028dFOMLsIMrmtyS5q8NQCvNcn6bZnjbU1YpFqNr98UIpc
   00vAsrFMs9H+tXV+sLU4mBibNbmgiCNKEh4B2F32+iEDNV/dVwtV+a++ubrLQpG9ZFU47PamSQkj
   K8QjyEK02RJsQzuIaVY6wHSWFENjxll9aBlzCbv3sn6g1INlx5IUbo0x17XN3snLe1RdioCX4817
   4Df2uiBJ1PUvJDeavTA5NBIKEhT+gb0R56GvHg==;
Received: from kmsattendceo.info (54.37.138.114) by ceo1.kmsattendceo.info id hlblb3i19tk1 for <linux-nvdimm@lists.01.org>; Tue, 10 Nov 2020 19:31:58 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@kmsattendceo.info>)
Date: Tue, 10 Nov 2020 19:31:58 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Sara Miller <info@kmsattendceo.info>
Subject: RE: 10K LinkedIn Leads from your Target Audience at 500
Message-ID: <e4162a3e05d8de6380cdcde610df20f8@kmsattendceo.info>
X-Rcde-Campaign-Uid: jz931jm0qd2cc
X-Rcde-Subscriber-Uid: cb251besc17a0
X-Rcde-Customer-Uid: kj6787n91o3e8
X-Rcde-Customer-Gid: 0
X-Rcde-Delivery-Sid: 1
X-Rcde-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://kmsattendceo.info/latest/index.php/campaigns/jz931jm0qd2cc/report-abuse/wb269z8o5b85d/cb251besc17a0
Feedback-ID: jz931jm0qd2cc:cb251besc17a0:wb269z8o5b85d:kj6787n91o3e8
Precedence: bulk
X-Rcde-EBS: https://kmsattendceo.info/latest/index.php/lists/block-address
X-Sender: info@kmsattendceo.info
X-Receiver: linux-nvdimm@lists.01.org
X-Rcde-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: NMJCZZOWPFU5HBV35DOC46ILNVH5WQBZ
X-Message-ID-Hash: NMJCZZOWPFU5HBV35DOC46ILNVH5WQBZ
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@kmsattendceo.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Sara Miller <sara@b2bcedmevent.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NMJCZZOWPFU5HBV35DOC46ILNVH5WQBZ/>
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
bmQgbGV0IG1lIGtub3cuDQpTYXJhIE1pbGxlcg0KUHJlbWl1bSBMaW5rZWRJbiBEYXRhYmFzZQ0K
MTAwJSBBY2N1cmF0ZSBEYXRhYmFzZQ0KVW5zdWJzY3JpYmUNCmh0dHBzOi8va21zYXR0ZW5kY2Vv
LmluZm8vbGF0ZXN0L2luZGV4LnBocC9saXN0cy93YjI2OXo4bzViODVkL3Vuc3Vic2NyaWJlL2Ni
MjUxYmVzYzE3YTAvano5MzFqbTBxZDJjYw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
