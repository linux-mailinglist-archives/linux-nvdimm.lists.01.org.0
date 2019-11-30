Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9505B10DDA3
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 Nov 2019 13:37:50 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6D34E100DC2A7;
	Sat, 30 Nov 2019 04:41:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.188.107.196; helo=altstake.io; envelope-from=bounty@altstake.io; receiver=<UNKNOWN> 
Received: from altstake.io (unknown [5.188.107.196])
	by ml01.01.org (Postfix) with ESMTP id D0128100DC2A4
	for <linux-nvdimm@lists.01.org>; Sat, 30 Nov 2019 04:41:08 -0800 (PST)
Received: from hzmscaup (unknown [182.111.170.135])
	by altstake.io (Postfix) with ESMTPA id 063151C3760;
	Sat, 30 Nov 2019 04:54:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=altstake.io; s=mail;
	t=1575107695; bh=ItxyS5YOU0IJqlONam21gNGs2M/UGW241O6W/p5fdfU=;
	h=From:To:Subject:Date;
	b=fqiqUZTWhKoDNY14lFEXxWePHkeffiFo015Qg9DPrMrgde3OM4TxFourn5zj3Czp0
	 +ASKM2b8t6dGYVG/SYXWik16qI5AG3gJ6SDPn5eGj1xddz6PnBM45WY9RdOxuWqV2n
	 2Ve24wUp5CMlec/zJaRNHIp0dhAbjnmm+6/D7aHK8UKBe22T5YUs+J039zkEAD8mbm
	 xfN1kZ64HLkrDnI7Wltjigx0rS9MpsfMubM7IVnlVmeaSuirZrnuDCcPA4IvHmc4iy
	 NLLEQcP2vxhgM7UZmjMJ6MX4LCLfMc6fU225CZO0h9MeFZUxm9ymAuQuhH1+UL0Ba1
	 2yRJIDkbYUUMg==
Message-ID: <292DD8B202CC5B1E9E36BE730BFE72F4@hzmscaup>
From: "aug" <bounty@altstake.io>
To: <adams1976@vieng.com>,
	<lt@mofcom.gov.cn>,
	<linux-nvdimm@lists.01.org>,
	<michael.aneiro@dowjones.com>,
	<huanjing@cau.edu.cn>,
	<quality@harvel.com>,
	<jack@raysmeats.com>,
	<vjvalis@ljgs.com>,
	<richardm@au1.ibm.com>,
	<acy@uppmedia.cn>,
	<gjxie8005@hfut.edu.cn>,
	<pqho@xol.com>,
	<charmaine@branded.asia>,
	<xinfengwang@sdu.edu.cn>,
	<hr@greatlife.cn>,
	<hr@hyde-edu.cn>,
	<huanmei2009@0576hm.com>,
	<sales@suyn.com>,
	<roofy1@kingston.net>,
	<fancia814@pku.edu.cn>,
	<job@daysview.com>
Subject: =?gb2312?B?t8ezo9L5yae1xNDUuNDN+M3gufrIy8PAydm4vrG7w/vAz83iy8W68g==?=
	=?gb2312?B?zebFqtS8stm6w8ntssS089Gnw8PX07LZtcTDw9fTvdCw1rDWxdq7+g==?=
	=?gb2312?B?trzTw8nPwcvDw9fTsbu4ybXE0ru0zrTOuN+zsQ==?=
Date: Sat, 30 Nov 2019 18:36:57 +0800
MIME-Version: 1.0
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
Message-ID-Hash: JX3VTXMS2OVXUZNFSSKMEAOZ4AJGCDOZ
X-Message-ID-Hash: JX3VTXMS2OVXUZNFSSKMEAOZ4AJGCDOZ
X-MailFrom: bounty@altstake.io
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JX3VTXMS2OVXUZNFSSKMEAOZ4AJGCDOZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============4546691397537036437=="

--===============4546691397537036437==
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PWdi
MjMxMiIgaHR0cC1lcXVpdj1Db250ZW50LVR5cGU+DQo8TUVUQSBuYW1lPUdFTkVSQVRPUiBjb250
ZW50PSJNU0hUTUwgMTAuMDAuOTIwMC4xNzU1NiI+PC9IRUFEPg0KPEJPRFk+DQo8UD48QSBocmVm
PSJodHRwOi8vaGFkMjAxNS5jb20vIj5odHRwOi8vaGFkMjAxNS5jb20vPC9BPjwvUD4NCjxQPiZu
YnNwOzwvUD4NCjxQPrfHs6PS+cmntcTQ1LjQzfjN4Ln6yMvDwMnZuL6xu8P7wM/N4svFuvLN5sWq
Jm5ic3A7IDwvUD4NCjxQPtS8stm6w8ntssS089Gnw8PX07LZtcTDw9fTvdCw1rDWxdq7+ra808PJ
z8HLw8PX07G7uMm1xNK7tM60zrjfs7E8L1A+PC9CT0RZPjwvSFRNTD4NCg==


--===============4546691397537036437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============4546691397537036437==--
