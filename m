Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A411496D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Dec 2019 23:39:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6813D10113507;
	Thu,  5 Dec 2019 14:43:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.3.62.69; helo=mail.tyrbl.com; envelope-from=hr@tyrbl.com; receiver=<UNKNOWN> 
Received: from mail.tyrbl.com (unknown [119.3.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 05CA3100DC2C2
	for <linux-nvdimm@lists.01.org>; Thu,  5 Dec 2019 14:43:13 -0800 (PST)
Received: from tufhuilz (unknown [182.111.170.135])
	by mail.tyrbl.com (Postfix) with ESMTPA id 88DD4A5A7B;
	Fri,  6 Dec 2019 06:36:50 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tyrbl.com; s=mail;
	t=1575585488; bh=lKmfb6R+vuuEwTPpSUMeJFtK3ZIV5vt2CtIzSSKVO4g=;
	h=From:To:Subject:Date:From;
	b=RVGDQOWGz6R4469fVmwDMa0MWKM7y/7hEYHceQL5sD877jVSEgHGgP8X395G3AZ9u
	 ZiSCEumr+kzj2H4sGf3/VOBqLKYsohh2hXoiSg1Aak6NjhSJLx/o+V89PMwNIv4AZ5
	 pQVwZptZOGI9b6usYw9gBk49EIrEjku7I2hNrDOM=
Message-ID: <769C7A1AF085742EDBDA1BAA85F1FE35@tufhuilz>
From: "layschep" <hr@tyrbl.com>
To: <ixl@esquare.com>,
	<xu.yantao@youde.cn>,
	<kpagano@daemen.edu>,
	<xxzx@yuhang.gov.cn>,
	<service@ebyf.com.cn>,
	<david.zhang@aicent.com>,
	<cbba@chinacb.cn>,
	<behmer@mwweb.com>,
	<chenwj@upc.edu.cn>,
	<info@werkraum.net>,
	<linux-nvdimm@lists.01.org>,
	<liusn@nwpu.edu.cn>,
	<alumupdate@american.edu>,
	<lixiangnan@shu.edu.cn>,
	<pjbclz@fzu.edu.cn>,
	<bing@j2eemx.com>,
	<guxiaofeng@caas.cn>,
	<zhangqp@castdservo.com>,
	<shikai@zzuli.edu.cn>,
	<rpeterson@rb60.com>,
	<longmujun@cqu.edu.cn>
Subject: =?gb2312?B?s8PXxcDPxsWyu9TavNLW1dPaus3QodLM19PQ3rPJ1f25+8mnscbS+Q==?=
	=?gb2312?B?tbS21LDXy+m7qMGs0sLIucnZuL67p83iubTS/cunuOe607HfwbnNpA==?=
	=?gb2312?B?safX+Mq9xb7Fvr/asay+q9K6zKvFqNKqs+m/2tHMu7q7ug==?=
Date: Fri, 6 Dec 2019 07:20:17 +0800
MIME-Version: 1.0
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
Message-ID-Hash: PQL7K4CBMAMCELIIO6OMDMCGXJHPZ7JT
X-Message-ID-Hash: PQL7K4CBMAMCELIIO6OMDMCGXJHPZ7JT
X-MailFrom: hr@tyrbl.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PQL7K4CBMAMCELIIO6OMDMCGXJHPZ7JT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============0905507620669018086=="

--===============0905507620669018086==
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PWdi
MjMxMiIgaHR0cC1lcXVpdj1Db250ZW50LVR5cGU+DQo8TUVUQSBuYW1lPUdFTkVSQVRPUiBjb250
ZW50PSJNU0hUTUwgMTAuMDAuOTIwMC4xNzU1NiI+PC9IRUFEPg0KPEJPRFk+DQo8UD48QSBocmVm
PSJodHRwOi8vaGFkMjAxNS5jb20vIj5odHRwOi8vaGFkMjAxNS5jb20vPC9BPjwvUD4NCjxQPiZu
YnNwOzwvUD4NCjxQPrPD18XAz8bFsrvU2rzS1tXT2rrN0KHSzNfT0N6zydX9ufvJp7HG0vm1tLbU
sNcmbmJzcDsgPC9QPg0KPFA+y+m7qMGs0sLIucnZuL67p83iubTS/cunuOe607HfwbnNpLGn1/jK
vcW+xb6/2rGsvqvSusyrxajSqrPpv9rRzLu6u7o8L1A+PC9CT0RZPjwvSFRNTD4NCg==


--===============0905507620669018086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============0905507620669018086==--
