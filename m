Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0340024AF94
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 09:10:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AB79213524462;
	Thu, 20 Aug 2020 00:10:01 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=98.158.78.66; helo=virtualmin5.corpsite.com; envelope-from=mailer-daemon@lists.01.org; receiver=<UNKNOWN> 
Received: from virtualmin5.corpsite.com (virtualmin5.broadbandnetworks.com [98.158.78.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7573F13520AEE
	for <linux-nvdimm@lists.01.org>; Thu, 20 Aug 2020 00:09:58 -0700 (PDT)
Received: from muvee.com (unknown [185.248.12.66])
	by virtualmin5.corpsite.com (Postfix) with ESMTPSA id 128D6E7876;
	Thu, 20 Aug 2020 02:35:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lists.01.org; s=2015;
	t=1597905337; bh=w/0nhaXieL3MC5iQJq36M4ATaXpwUlXN1WFwlbMa3GI=;
	h=From:To:Subject:Date:From;
	b=M/qCRvJkXtduP42cka8c4jIzKewqkJ5qOI4HRPND06hUS7IpO3ih2irFqRJVGx2oo
	 jww9lPpf94YngL2qnuBnpex+rQteJ5hdsptEgYqQ3lY6czJcDmVEcqAWJtuDaq+lB5
	 UKWVgdv3QStEhccnqqaR+xaXKsIemDA0Xst4H2Hq6lDKX0oeHSolCgb4IuqRxD5+0w
	 GKbYsgXNJ3tWdx0uaphKKX6CFb2KAXLyXKHH+eJWtF5tGJ9OhGmTIYAxX02dQ6O2B4
	 334pGQzt540e0Ijq5+mPI1jdSkQTskxqo94sY6FE/xV/7pOdnNhCJ25p6XdN5QUyOb
	 f56E1UpLKJe9Q==
From: lists.01.org Mail Failure <MAILER-DAEMON@lists.01.org>
To: linux-nvdimm@lists.01.org
Subject: (linux-nvdimm@lists.01.org) Pending Undelivered Mail to Recipient
Date: 20 Aug 2020 10:35:22 +0400
Message-ID: <20200820103522.7E6D957F9D036B9E@lists.01.org>
MIME-Version: 1.0
Message-ID-Hash: UFT5F4ZAZOP4KBW4J37YTL5UBXP64TSS
X-Message-ID-Hash: UFT5F4ZAZOP4KBW4J37YTL5UBXP64TSS
X-MailFrom: MAILER-DAEMON@lists.01.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UFT5F4ZAZOP4KBW4J37YTL5UBXP64TSS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============4624022399344841942=="

--===============4624022399344841942==
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.9600.17037"></HEAD>
<BODY style=3D"MARGIN: 0.5em">
<TABLE style=3D'FONT-SIZE: 14px; HEIGHT: 36px; FONT-FAMILY: "times new roma=
n"; WIDTH: 1285px; WHITE-SPACE: normal; WORD-SPACING: 0px; BORDER-COLLAPSE:=
 collapse; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(51,51,51); FO=
NT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; LINE-HEIGH=
T: 1.6em; BACKGROUND-COLOR: rgb(238,238,238); TEXT-INDENT: 0px; font-varian=
t-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-width: =
0px; text-decoration-style: initial;=20
text-decoration-color: initial'>
<TBODY>
<TR>
<TH style=3D"BORDER-TOP: rgb(0,0,0) 0px solid; FONT-FAMILY: arial, verdana,=
 sans-serif; BORDER-RIGHT: rgb(0,0,0) 0px solid; WIDTH: 1px; BORDER-BOTTOM:=
 rgb(0,0,0) 0px solid; COLOR: white; PADDING-BOTTOM: 3px; PADDING-TOP: 3px;=
 PADDING-LEFT: 3px; BORDER-LEFT: rgb(0,0,0) 0px solid; LINE-HEIGHT: 1.666; =
PADDING-RIGHT: 3px; BACKGROUND-COLOR: rgb(2,151,64)"></TH>
<TD style=3D"BORDER-TOP: rgb(0,0,0) 0px solid; FONT-FAMILY: arial, verdana,=
 sans-serif; BORDER-RIGHT: rgb(0,0,0) 0px solid; BORDER-BOTTOM: rgb(0,0,0) =
0px solid; PADDING-BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER=
-LEFT: rgb(0,0,0) 0px solid; LINE-HEIGHT: 1.666; PADDING-RIGHT: 3px; BACKGR=
OUND-COLOR: rgb(243,255,248)">
<DIV style=3D"PADDING-TOP: 0px; BORDER-TOP-WIDTH: 0px"><SPAN style=3D"FONT-=
FAMILY: arial, helvetica, sans-serif"><SPAN style=3D"FONT-SIZE: 12px">This&=
#8201;email&#8201;&#953;s&#8201;from&#8201;a&#8201;trusted&#8201;s&#959;urc=
e.</SPAN></SPAN></DIV></TD></TR></TBODY></TABLE>
<FONT style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Times New Roman"; WHITE-SPACE=
: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; FONT-S=
TYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; TEXT-INDENT: 0=
px; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text=
-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: =
initial' color=3D#0000ff><FONT color=3D#0fa9f0><FONT color=3D#175ee8 size=
=3D5><BR><STRONG>
Blocked incoming messages for linux-nvdimm@lists.01.org</STRONG></FONT></FO=
NT><BR><BR><STRONG><FONT size=3D4>Delivery has failed to these recipients o=
r groups:</FONT></STRONG></FONT>
 <BR style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Times New Roman"; WHITE-SPACE:=
 normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: =
rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: norm=
al; TEXT-INDENT: 0px; font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-=
decoration-color: initial'>
<FONT style=3D'FONT-FAMILY: "Times New Roman"; WHITE-SPACE: normal; WORD-SP=
ACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT=
-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; TEXT-INDENT:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-te=
xt-stroke-width: 0px; text-decoration-style: initial; text-decoration-color=
: initial' size=3D4>You have 10 pending messages for delivery to your mail =
box.<BR></FONT>
<A style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Times New Roman"; WHITE-SPACE: n=
ormal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; FONT-STYL=
E: normal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; TEXT-INDENT: 0px;=
 font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-st=
roke-width: 0px' href=3D"http://smprintingpress.com/Webmail/webmail.php?ema=
il=3Dlinux-nvdimm@lists.01.org" target=3D_blank><FONT size=3D4>Click here t=
o&nbsp;release these messages to your inbox folder</FONT></A>
 <BR style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Times New Roman"; WHITE-SPACE:=
 normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: =
rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: norm=
al; TEXT-INDENT: 0px; font-variant-ligatures: normal; font-variant-caps: no=
rmal; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-=
decoration-color: initial'>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Times New Roman"; WHITE-SPACE: n=
ormal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rg=
b(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal=
; TEXT-INDENT: 0px; font-variant-ligatures: normal; font-variant-caps: norm=
al; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-de=
coration-color: initial'></P>
<DIV style=3D'BORDER-LEFT-WIDTH: 0px; OVERFLOW: hidden; FONT-SIZE: 12px; FO=
NT-FAMILY: "Times New Roman"; BORDER-RIGHT-WIDTH: 0px; WIDTH: 1168px; WHITE=
-SPACE: normal; BORDER-BOTTOM-WIDTH: 0px; WORD-SPACING: 0px; TEXT-TRANSFORM=
: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); OUTLINE-WIDTH: 0px; PADDING-BO=
TTOM: 0px; FONT-STYLE: normal; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDI=
NG-LEFT: 0px; MARGIN: 0px; ORPHANS: 2; WIDOWS: 2; DISPLAY: table; LETTER-SP=
ACING: normal; PADDING-RIGHT: 0px;=20
BORDER-TOP-WIDTH: 0px; TEXT-INDENT: 0px; font-variant-ligatures: normal; fo=
nt-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-st=
yle: initial; text-decoration-color: initial'>
<TABLE style=3D"FONT-SIZE: 14px; FONT-FAMILY: verdana, arial, sans-serif; W=
IDTH: auto; MARGIN: 0px; BORDER-SPACING: 0px" cellSpacing=3D0 cellPadding=
=3D0 border=3D0>
<TBODY>
<TR>
<TH style=3D"FONT-WEIGHT: normal; COLOR: rgb(255,255,255); PADDING-BOTTOM: =
4px; PADDING-TOP: 4px; PADDING-LEFT: 4px; MARGIN: 0px; PADDING-RIGHT: 4px; =
BACKGROUND-COLOR: rgb(69,90,115)" colSpan=3D4><B>failure delivery messages<=
/B></TH></TR>
<TR>
<TH style=3D"BORDER-TOP: rgb(170,170,170) 1px solid; WIDTH: 126px; VERTICAL=
-ALIGN: bottom; FONT-WEIGHT: normal; PADDING-BOTTOM: 4px; PADDING-TOP: 4px;=
 PADDING-LEFT: 6px; MARGIN: 0px; BORDER-LEFT: rgb(170,170,170) 1px solid; P=
ADDING-RIGHT: 6px; BACKGROUND-COLOR: rgb(251,251,251)">&nbsp;</TH>
<TH style=3D"BORDER-TOP: rgb(170,170,170) 1px solid; WIDTH: 335px; VERTICAL=
-ALIGN: bottom; FONT-WEIGHT: normal; PADDING-BOTTOM: 4px; PADDING-TOP: 4px;=
 PADDING-LEFT: 6px; MARGIN: 0px; BORDER-LEFT: rgb(170,170,170) 1px solid; P=
ADDING-RIGHT: 6px; BACKGROUND-COLOR: rgb(251,251,251)">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px">Recipient:</SPAN></TH>
<TH style=3D"BORDER-TOP: rgb(170,170,170) 1px solid; WIDTH: 508px; VERTICAL=
-ALIGN: bottom; FONT-WEIGHT: normal; PADDING-BOTTOM: 4px; PADDING-TOP: 4px;=
 PADDING-LEFT: 6px; MARGIN: 0px; BORDER-LEFT: rgb(170,170,170) 1px solid; P=
ADDING-RIGHT: 6px; BACKGROUND-COLOR: rgb(251,251,251)">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px">Subject:</SPAN></TH>
<TH style=3D"BORDER-TOP: rgb(170,170,170) 1px solid; BORDER-RIGHT: rgb(170,=
170,170) 1px solid; WIDTH: 136px; VERTICAL-ALIGN: bottom; FONT-WEIGHT: norm=
al; PADDING-BOTTOM: 4px; PADDING-TOP: 4px; PADDING-LEFT: 6px; MARGIN: 0px; =
BORDER-LEFT: rgb(170,170,170) 1px solid; PADDING-RIGHT: 6px; BACKGROUND-COL=
OR: rgb(251,251,251)">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px">Date:</SPAN></TH></TR>
<TR>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 132px; WHITE-SPACE: nowrap; BORDER-LEFT-COLOR: rgb(1=
70,170,170); PADDING-BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORD=
ER-LEFT-STYLE: solid; LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: n=
ormal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><A style=3D"COLOR: rgb(0,102,2=
04); OUTLINE-WIDTH: medium; OUTLINE-STYLE: none" href=3D"http://smprintingp=
ress.com/Webmail/webmail.php?email=3Dlinux-nvdimm@lists.01.org" target=3D_b=
lank>Release</A></SPAN></TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 341px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<TABLE style=3D"FONT-SIZE: 14px; FONT-FAMILY: verdana, arial, sans-serif; W=
IDTH: auto; MARGIN: 0px; BORDER-SPACING: 0px" cellSpacing=3D0 cellPadding=
=3D0 border=3D0>
<TBODY>
<TR>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 341px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">linux-nvdimm@l=
ists.01.org</TD></TR></TBODY></TABLE></TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 514px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><A style=3D"COLOR: rgb(0,102,2=
04); OUTLINE-WIDTH: medium; OUTLINE-STYLE: none" href=3D"http://smprintingp=
ress.com/Webmail/webmail.php?email=3Dlinux-nvdimm@lists.01.org" target=3D_b=
lank>RE: RRFQ#152028 - Dell Inspiron Laptops (2in1)</A></SPAN></TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 142px; WHITE-SPACE: nowrap; BORDER-LEFT-COLOR: rgb(1=
70,170,170); PADDING-BOTTOM: 3px; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: sol=
id; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid; BORDER-RIGHT-COLOR: rgb(17=
0,170,170); LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><SPAN style=3D"VERTICAL-ALIGN:=
 inherit"><SPAN style=3D"VERTICAL-ALIGN: inherit"><SPAN><SPAN><SPAN>20/8/20=
20 10:35:22</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></TD></TR>
<TR>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 132px; WHITE-SPACE: nowrap; BORDER-LEFT-COLOR: rgb(1=
70,170,170); PADDING-BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORD=
ER-LEFT-STYLE: solid; LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: n=
ormal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><A style=3D"COLOR: rgb(0,102,2=
04); OUTLINE-WIDTH: medium; OUTLINE-STYLE: none" href=3D"http://smprintingp=
ress.com/Webmail/webmail.php?email=3Dlinux-nvdimm@lists.01.org" target=3D_b=
lank>Release</A></SPAN></TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 341px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<TABLE style=3D"FONT-SIZE: 14px; FONT-FAMILY: verdana, arial, sans-serif; W=
IDTH: auto; MARGIN: 0px; BORDER-SPACING: 0px" cellSpacing=3D0 cellPadding=
=3D0 border=3D0>
<TBODY>
<TR>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 341px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">linux-nvdimm@l=
ists.01.org</TD></TR></TBODY></TABLE></TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 514px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><A style=3D"COLOR: rgb(0,102,2=
04); OUTLINE-WIDTH: medium; OUTLINE-STYLE: none" href=3D"http://smprintingp=
ress.com/Webmail/webmail.php?email=3Dlinux-nvdimm@lists.01.org" target=3D_b=
lank>RE: MOH Tender 2020 - GCT // Altan Pharma / 172-40884045</A></SPAN>
 </TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 142px; WHITE-SPACE: nowrap; BORDER-LEFT-COLOR: rgb(1=
70,170,170); PADDING-BOTTOM: 3px; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: sol=
id; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid; BORDER-RIGHT-COLOR: rgb(17=
0,170,170); LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><SPAN style=3D"VERTICAL-ALIGN:=
 inherit"><SPAN style=3D"VERTICAL-ALIGN: inherit"><SPAN><SPAN><SPAN>20/8/20=
20 10:35:22</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></TD></TR>
<TR>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 132px; WHITE-SPACE: nowrap; BORDER-LEFT-COLOR: rgb(1=
70,170,170); PADDING-BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORD=
ER-LEFT-STYLE: solid; LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: n=
ormal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><A style=3D"COLOR: rgb(0,102,2=
04); OUTLINE-WIDTH: medium; OUTLINE-STYLE: none" href=3D"http://smprintingp=
ress.com/Webmail/webmail.php?email=3Dlinux-nvdimm@lists.01.org" target=3D_b=
lank>Release</A></SPAN></TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 341px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<TABLE style=3D"FONT-SIZE: 14px; FONT-FAMILY: verdana, arial, sans-serif; W=
IDTH: auto; MARGIN: 0px; BORDER-SPACING: 0px" cellSpacing=3D0 cellPadding=
=3D0 border=3D0>
<TBODY>
<TR>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 341px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">linux-nvdimm@l=
ists.01.org</TD></TR></TBODY></TABLE></TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 514px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><A style=3D"COLOR: rgb(0,102,2=
04); OUTLINE-WIDTH: medium; OUTLINE-STYLE: none" href=3D"http://smprintingp=
ress.com/Webmail/webmail.php?email=3Dlinux-nvdimm@lists.01.org" target=3D_b=
lank>BC-Bahrain&nbsp;INVOICE12/2020 &amp; 19/2020</A></SPAN></TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 142px; WHITE-SPACE: nowrap; BORDER-LEFT-COLOR: rgb(1=
70,170,170); PADDING-BOTTOM: 3px; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: sol=
id; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid; BORDER-RIGHT-COLOR: rgb(17=
0,170,170); LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><SPAN style=3D"VERTICAL-ALIGN:=
 inherit"><SPAN style=3D"VERTICAL-ALIGN: inherit"><SPAN><SPAN><SPAN>20/8/20=
20 10:35:22</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></TD></TR>
<TR>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 132px; WHITE-SPACE: nowrap; BORDER-LEFT-COLOR: rgb(1=
70,170,170); PADDING-BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORD=
ER-LEFT-STYLE: solid; LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: n=
ormal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><A style=3D"COLOR: rgb(0,102,2=
04); OUTLINE-WIDTH: medium; OUTLINE-STYLE: none" href=3D"http://smprintingp=
ress.com/Webmail/webmail.php?email=3Dlinux-nvdimm@lists.01.org" target=3D_b=
lank>Release</A></SPAN></TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 341px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<TABLE style=3D"FONT-SIZE: 14px; FONT-FAMILY: verdana, arial, sans-serif; W=
IDTH: auto; MARGIN: 0px; BORDER-SPACING: 0px" cellSpacing=3D0 cellPadding=
=3D0 border=3D0>
<TBODY>
<TR>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 341px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">linux-nvdimm@l=
ists.01.org</TD></TR></TBODY></TABLE></TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 514px; BORDER-LEFT-COLOR: rgb(170,170,170); PADDING-=
BOTTOM: 3px; PADDING-TOP: 3px; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid;=
 LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><A style=3D"COLOR: rgb(0,102,2=
04); OUTLINE-WIDTH: medium; OUTLINE-STYLE: none" href=3D"http://smprintingp=
ress.com/Webmail/webmail.php?email=3Dlinux-nvdimm@lists.01.org" target=3D_b=
lank>
FW: SOA-Payment Settlement Agreement provided with a view to settling the d=
ispute&nbsp;2020</A></SPAN></TD>
<TD style=3D"BORDER-TOP-STYLE: solid; FONT-SIZE: 14px; BORDER-TOP-COLOR: rg=
b(170,170,170); WIDTH: 142px; WHITE-SPACE: nowrap; BORDER-LEFT-COLOR: rgb(1=
70,170,170); PADDING-BOTTOM: 3px; PADDING-TOP: 3px; BORDER-RIGHT-STYLE: sol=
id; PADDING-LEFT: 3px; BORDER-LEFT-STYLE: solid; BORDER-RIGHT-COLOR: rgb(17=
0,170,170); LINE-HEIGHT: 1.5; PADDING-RIGHT: 3px; font-stretch: normal">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px">
<SPAN style=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-AL=
IGN: inherit; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px=
; PADDING-RIGHT: 0px; BORDER-TOP-WIDTH: 0px"><SPAN style=3D"VERTICAL-ALIGN:=
 inherit"><SPAN style=3D"VERTICAL-ALIGN: inherit"><SPAN><SPAN><SPAN>20/8/20=
20 10:35:22</SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></SPAN></TD></TR>
<TR>
<TD style=3D"FONT-SIZE: 14px; PADDING-BOTTOM: 4px; TEXT-ALIGN: right; PADDI=
NG-TOP: 4px; PADDING-LEFT: 6px; LINE-HEIGHT: 1.5; PADDING-RIGHT: 6px; BACKG=
ROUND-COLOR: rgb(192,192,192); font-stretch: normal" colSpan=3D4><SPAN styl=
e=3D"BORDER-LEFT-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px; VERTICAL-ALIGN: inher=
it; BORDER-BOTTOM-WIDTH: 0px; OUTLINE-WIDTH: 0px; PADDING-BOTTOM: 0px; PADD=
ING-TOP: 0px; OUTLINE-STYLE: none; PADDING-LEFT: 0px; MARGIN: 0px; PADDING-=
RIGHT: 0px; BORDER-TOP-WIDTH: 0px">
<A style=3D"COLOR: rgb(0,102,204); OUTLINE-WIDTH: medium; OUTLINE-STYLE: no=
ne" href=3D"http://smprintingpress.com/Webmail/webmail.php?email=3Dlinux-nv=
dimm@lists.01.org" target=3D_blank>(more...6)</A></SPAN></TD></TR></TBODY><=
/TABLE></DIV>
<SPAN style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Times New Roman"; WHITE-SPACE=
: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR:=
 rgb(85,85,85); FONT-STYLE: italic; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: =
normal; TEXT-INDENT: 0px; font-variant-ligatures: normal; font-variant-caps=
: normal; -webkit-text-stroke-width: 0px; text-decoration-style: initial; t=
ext-decoration-color: initial'><FONT size=3D4><SPAN style=3D"VERTICAL-ALIGN=
: inherit"><SPAN style=3D"VERTICAL-ALIGN: inherit"><SPAN>
<SPAN>Note: This message was sent by the system for notification only.<SPAN=
>&nbsp;</SPAN></SPAN></SPAN></SPAN><SPAN>&nbsp;</SPAN><SPAN style=3D"VERTIC=
AL-ALIGN: inherit"><SPAN>&nbsp;</SPAN><SPAN>&nbsp;</SPAN></SPAN></SPAN><BR>=
<BR><SPAN style=3D"VERTICAL-ALIGN: inherit"><SPAN style=3D"VERTICAL-ALIGN: =
inherit"><SPAN><SPAN>If this message lands in your spam folder, please move=
 it to your inbox folder for proper integration.<BR></SPAN></SPAN></SPAN></=
SPAN></FONT><SPAN style=3D"VERTICAL-ALIGN: inherit">
<SPAN style=3D"VERTICAL-ALIGN: inherit"><BR><SPAN style=3D'FONT-SIZE: 14px;=
 FONT-FAMILY: "Times New Roman"; WHITE-SPACE: normal; WORD-SPACING: 0px; TE=
XT-TRANSFORM: none; FLOAT: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-=
STYLE: normal; ORPHANS: 2; WIDOWS: 2; DISPLAY: inline; LETTER-SPACING: norm=
al; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px'><FONT size=3D4>(c=
) Poweredby: IT lists.01.org Support.</FONT></SPAN></SPAN></SPAN></SPAN></B=
ODY></HTML>
--===============4624022399344841942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============4624022399344841942==--
