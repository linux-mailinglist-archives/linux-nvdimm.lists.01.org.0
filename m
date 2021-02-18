Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390B331EB0E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Feb 2021 15:43:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 46D7C100EBB73;
	Thu, 18 Feb 2021 06:43:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=94.229.167.116; helo=94.229.167.116.srvlist.ukfast.net; envelope-from=noreply@seawardems-dev.com; receiver=<UNKNOWN> 
Received: from 94.229.167.116.srvlist.ukfast.net (94.229.167.116.srvlist.ukfast.net [94.229.167.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C20E7100EC1E1
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 06:43:34 -0800 (PST)
Received: from seawardems-dev.com (unknown [74.208.31.47])
	by 94.229.167.116.srvlist.ukfast.net (Postfix) with ESMTPSA id 60FCB968BC
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 12:18:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seawardems-dev.com;
	s=default; t=1613650710;
	bh=czyu/dwtqv+rvZfJPhn0601vtly6UhnwA5gbmL3ijCU=; l=2672;
	h=From:To:Subject;
	b=Qx4CNJJHohGd7ekhRCkl5RF7/jCY4VT0paLTgnj3K3eW7rVTcYql9Nw64ZJIcSad8
	 m+T9QR3bWPG/JRFW1BNDdycdFtXOT+NDG3J6nqrmRkEPxEMXF8v35qo77onACtGT/6
	 F0MmOh8nBNLDiJMlPFgOUxzRMWhIJeCdG8ePVdNo=
Authentication-Results: 94.229.167.116.srvlist.ukfast.net;
        spf=pass (sender IP is 74.208.31.47) smtp.mailfrom=noreply@seawardems-dev.com smtp.helo=seawardems-dev.com
Received-SPF: pass (94.229.167.116.srvlist.ukfast.net: connection is authenticated)
Replyto: ydoo974@gmail.com
From: "Mr. Yusin 670738807549" <noreply@seawardems-dev.com>
To: linux-nvdimm@lists.01.org
Subject: 
 =?utf-8?B?UGFydG5lcnNoaXAgcmVxdWVzdC4gLSBSZWY6IDU1MjIzNDg0MDM4OSAtOiBUaHVyc2RheSwgRmVicnVhcnkgMTgsIDIwMjEgMjoyODozOA==?=
Message-ID: <4ef512cd-25bb-f19b-8be7-c8180ca191a6@seawardems-dev.com>
X-Priority: 1 (Highest)
X-Msmail-Priority: High
Importance: High
Date: Thu, 18 Feb 2021 02:29:43 +0000
MIME-Version: 1.0
Message-ID-Hash: SHJLF5GX76LQFVVW4PTMI7WPVVYF3LDL
X-Message-ID-Hash: SHJLF5GX76LQFVVW4PTMI7WPVVYF3LDL
X-MailFrom: noreply@seawardems-dev.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: ydoo974@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SHJLF5GX76LQFVVW4PTMI7WPVVYF3LDL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============4326498513459970917=="

--===============4326498513459970917==
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable


        <style>
            .rx {
                color: transparent;
                display: none;
                height: 0;
                max-height: 0; max-width: 0; opacity: 0; mso-hide: all; =
visibility: hidden; width: 0;
            }
        </style>
        <div style=3D"display: none;"></div>
        <DIV =
style=3D"FONT-SIZE: 6px; COLOR: #ffffff; LINE-HEIGHT: =
1"></DIV><html><head>
<meta name=3D"GENERATOR" content=3D"MSHTML 11.00.10570.1001">
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body><div class=3D"gmail_quote"><div class=3D"gmail_attr" =
dir=3D"ltr"><br></div><div class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; =
padding-left: 1ex; border-left-color: rgb(204, 204, 204); =
border-left-width: 1px; border-left-style: solid;"><u></u>
<div style=3D"margin: 0px; padding: 0px; width: 100%;">
<div style=3D"color: rgb(255, 255, 255); line-height: 1; font-size: =
6px;">##- 6Znhy6rNLwSjYyi04qUco Please 6Znhy6rNLwSjYyi04qUco type your =
6Znhy6rNLwSjYyi04qUco reply above 6Znhy6rNLwSjYyi04qUco this =
6Znhy6rNLwSjYyi04qUco line -##</div>
<div style=3D'padding: 0px 10px; color: rgb(51, 51, 51); line-height: 22px;=
 font-family: "Helvetica","Arial",sans-serif; font-size: 18px; margin-top: =
0px; margin-bottom: 15px;'>
<p><font color=3D"#000000" face=3D"Times New Roman" size=3D"3">
<font color=3D"#000000" face=3D"Times New Roman" size=3D"3">Hello,=
</font></font></p>
<p><br>At Fidelity Investment International;</p>
<p>The World's Largest Fund Management Company with over USD 1.2 Trillion =
Capital Investment Fund. Nevertheless, as The Fidelity Fund Manager,</p>
<p>I handle all our Investor's Direct Capital Funds and secretly extracted =
1.2% Excess Maximum Return Capital Profit (EMRCP) per annum on each of the =
Investor's Marginal Capital Fund. As an expert, I have made substantial =
profit from the Investor's EMRCP and hereby looking for a trust company or =
an agent who will stand as an investor to receive the fund as annual =
investment proceeds from Fidelity Marginal Capital Fund.</p>
<p>It is good to know that I have worked out the modalities and =
technicalities whereby the fund can be requested for in any of our 6 =
clearing houses without any hitches. All confirm-able documents to =
ascertain our request (should the clearing house ask for them) will be made=
 available to you.</p>
<p>Waiting for your reply,<br>Yusin</p>
<p><a href=3D"http://www.fidelity.co.uk">www.fidelity.co.uk</a> Fidelity =
Brokerage Services LLC<br>Best ISAs, SIPPs and Funds - Fidelity Worldwide =
Investment<br><a href=3D"http://www.fidelity.co.uk">www.fidelity.co.=
uk</a></p></div></div></blockquote></div></div></body></html>
--===============4326498513459970917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============4326498513459970917==--
