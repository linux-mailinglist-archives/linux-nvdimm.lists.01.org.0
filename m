Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8E14400A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jan 2020 15:57:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 10A561007B8D4;
	Tue, 21 Jan 2020 07:00:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.77.126.226; helo=bwdemo.bzn.kr; envelope-from=admin@kjtelecom.net; receiver=<UNKNOWN> 
Received: from bwdemo.bzn.kr (unknown [119.77.126.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 53F6710113668
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 07:00:36 -0800 (PST)
Received: (qmail 28309 invoked from network); 27 Nov 2019 02:47:40 +0900(KST)
Received: from unknown (HELO ju) (admin@kjtelecom.net@115.151.132.152)
  by 0 with ESMTPA; 27 Nov 2019 02:47:40 +0900(KST)
Message-ID: <CE153A988B1E885EA237C10EA20AD346@ju>
From: "tmrnjfvev" <admin@kjtelecom.net>
To: <baoht@ouc.edu.cn>,
	<steve@eplusexpo.com>,
	<vicky@mayflash.com>,
	<linux-nvdimm@lists.01.org>,
	<info@synchemco.com>,
	<gongg@nankai.edu.cn>,
	<smaiztegui@esu.edu>,
	<kathyanderson@kw.com>,
	<raschmidt@lcsc.edu>,
	<info@panlink.com>,
	<awilson@kaz.com>,
	<chomps@io.com>,
	<tru@schoneal.com>,
	<luanxiaofeng@bjfu.edu.cn>,
	<nunosouto@hempseed.com>,
	<info@richfrp.com>,
	<info@rmsmg.com>,
	<xijiy@gzmy.net>,
	<gestaambiental@codetel.net.do>,
	<ludovic@mozilla.com>,
	<info@tafsus.net>
Subject: =?gb2312?B?19S8usP+0vW12bjfs7HW3MSps/bX4re/1LzF2rWlzrvH4crsxa7H6Q==?=
	=?gb2312?B?yMvQ1LjQy7/N4LjfuPrDwM3IzPS2utaxvdPU2tH0zKi/qrLZyevS9w==?=
	=?gb2312?B?tK3Posn5tMy8pLbUsNfS+bW0zfi67L6rssrR3dLvwfTK2LTlucOxuw==?=
	=?gb2312?B?uNWyxcWpzO/Azdf3uenAtLXExanD8bTzyuXU2sWpvNLQodS6wO/Hvw==?=
	=?gb2312?B?uOM=?=
Date: Wed, 27 Nov 2019 02:29:24 +0800
MIME-Version: 1.0
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
Message-ID-Hash: KDITAXS3MVG2OUCQH5M4IHPQWSMEGSKZ
X-Message-ID-Hash: KDITAXS3MVG2OUCQH5M4IHPQWSMEGSKZ
X-MailFrom: admin@kjtelecom.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KDITAXS3MVG2OUCQH5M4IHPQWSMEGSKZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============2932898863880487393=="

--===============2932898863880487393==
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PWdi
MjMxMiIgaHR0cC1lcXVpdj1Db250ZW50LVR5cGU+DQo8TUVUQSBuYW1lPUdFTkVSQVRPUiBjb250
ZW50PSJNU0hUTUwgMTAuMDAuOTIwMC4xNzU1NiI+PC9IRUFEPg0KPEJPRFk+DQo8UD48QSBocmVm
PSJodHRwOi8vaGFkMjAxNS5jb20vIj5odHRwOi8vaGFkMjAxNS5jb20vPC9BPjwvUD4NCjxQPiZu
YnNwOzwvUD4NCjxQPtfUvLrD/tL1tdm437Ox1tzEqbP21+K3v9S8xdq1pc67x+HK7MWux+nIy9DU
uNDLv83guN+4+sPAzcjM9La61rG909Ta0fTMqL+qstnJ69L3tK3Posn5tMy8pLbUsNfS+bW0Jm5i
c3A7IDwvUD4NCjxQPs34uuy+q7LK0d3S78H0yti05bnDsbu41bLFxanM78DN1/e56cC0tcTFqcPx
tPPK5dTaxam80tCh1LrA78e/uOM8L1A+PC9CT0RZPjwvSFRNTD4NCg==


--===============2932898863880487393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============2932898863880487393==--
