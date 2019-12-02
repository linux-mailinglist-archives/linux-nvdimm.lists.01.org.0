Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46A10E539
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Dec 2019 06:10:34 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7419610113317;
	Sun,  1 Dec 2019 21:13:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.3.62.69; helo=mail.tyrbl.com; envelope-from=hr@tyrbl.com; receiver=<UNKNOWN> 
Received: from mail.tyrbl.com (unknown [119.3.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 41CD0100DC2CE
	for <linux-nvdimm@lists.01.org>; Sun,  1 Dec 2019 21:13:52 -0800 (PST)
Received: from imzify (unknown [182.111.170.135])
	by mail.tyrbl.com (Postfix) with ESMTPA id AEF9DC573B;
	Mon,  2 Dec 2019 12:56:42 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tyrbl.com; s=mail;
	t=1575262656; bh=EV8FH1iNiXfB1ZjtpOQGxLyNYaMAv85kharwjy8+Mxo=;
	h=From:To:Subject:Date:From;
	b=D+YAfm6i7IZl5O/IxwpY4Slbqhci5KlK9/UBpMQgqzE6w48x7DHS49tTcRt1GQ6j5
	 o247r0jyFHouVHU/gIpZoAC5JX+52eWcV+XkKHP07M6GoFAWUg5EQr1U+pNkkuUepU
	 tw9r4btpqo5gy2UMjpauuYmNNDFpoFH8sNS9Z1Io=
Message-ID: <F3570CAD80911B0D12AFEBC5BC17598D@imzify>
From: "cjsti" <hr@tyrbl.com>
To: <ewhite@cforums.com>,
	<account@epassporte.com>,
	<zhangxueying@hncj.edu.cn>,
	<feimin@youbangex.com>,
	<reggie.howell@rlhgroup.com>,
	<ericm@ingrian.com>,
	<ambassadors@trippy.com>,
	<girish@freshdesk.com>,
	<swilson@cohnwolfe.com>,
	<vmpack@vmpack.com>,
	<tljsj@rails.cn>,
	<tyc@tyc.com.cn>,
	<info@zuykov.com>,
	<yinguo.xia@wenjutruck.com>,
	<xmbz@tcixps.com>,
	<linux-nvdimm@lists.01.org>,
	<im@murphyl.com>,
	<ruta.rahate@sbdinc.com>,
	<esaras@fsu.edu>,
	<jgrama@educause.edu>,
	<sgorniak@uh.edu>
Subject: =?gb2312?B?t+fS98Txs6rX7tDCs/bGt7yrxre5+sSjsK7A9smvus3J49Owyqa+xg==?=
	=?gb2312?B?teq8pMfpxb7FvlC438fl09DJ+dL0sObEp7ntye2yxMWuyfHDwMWu?=
	=?gb2312?B?w8Cxq8TbtuDWrdbVvKu1973M0NS40M7Gye0=?=
Date: Mon, 2 Dec 2019 13:39:37 +0800
MIME-Version: 1.0
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
Message-ID-Hash: FYB6RUIGGZKXCPDNVDUTM5Q2RE2PKID7
X-Message-ID-Hash: FYB6RUIGGZKXCPDNVDUTM5Q2RE2PKID7
X-MailFrom: hr@tyrbl.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FYB6RUIGGZKXCPDNVDUTM5Q2RE2PKID7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============8824750846777552513=="

--===============8824750846777552513==
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PWdi
MjMxMiIgaHR0cC1lcXVpdj1Db250ZW50LVR5cGU+DQo8TUVUQSBuYW1lPUdFTkVSQVRPUiBjb250
ZW50PSJNU0hUTUwgMTAuMDAuOTIwMC4xNzU1NiI+PC9IRUFEPg0KPEJPRFk+DQo8UD48QSBocmVm
PSJodHRwOi8vaGFkMjAxNS5jb20vIj5odHRwOi8vaGFkMjAxNS5jb20vPC9BPjwvUD4NCjxQPiZu
YnNwOzwvUD4NCjxQPrfn0vfE8bOq1+7QwrP2xre8q8a3ufrEo7CuwPbJr7rNyePTsMqmvsa16ryk
x+nFvsW+ULjfx+XT0Mn50vSw5iZuYnNwOyA8L1A+DQo8UD7Ep7ntye2yxMWuyfHDwMWuw8Cxq8Tb
tuDWrdbVvKu1973M0NS40M7Gye08L1A+PC9CT0RZPjwvSFRNTD4NCg==


--===============8824750846777552513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============8824750846777552513==--
