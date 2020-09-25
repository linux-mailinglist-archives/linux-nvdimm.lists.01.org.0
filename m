Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C659B277CB4
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 02:12:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C3498149D9072;
	Thu, 24 Sep 2020 17:12:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.95.169.84; helo=slot0.auto-server.com; envelope-from=support@auto-server.com; receiver=<UNKNOWN> 
Received: from slot0.auto-server.com (slot0.auto-server.com [45.95.169.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1EDEE149D9071
	for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 17:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=auto-server.com;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=support@auto-server.com;
 bh=oRsqlft+jxAsgtfrpcZFdfzgYX4=;
 b=TZv3sTK5SV73X2rhUN0AuaxWmgn2UdooYySb1ziMg/l6iirTwy7pVk9WvyFegkyDVuf2/ggjK8gr
   eIZSQqIXfDwzI+u5+bJzsJhIW6eTWi7tRDm78SOXo3QpZPDqFmQ0IAoPTrZRsxHF0TZwaUUMbHES
   +IVhBFkhkCEyWQJaSfTqy88e0YbhP6ZRCYp+oJ0PY3bLCUqSEEDVlwE8JDgIiaFEnpOyqgnj8Mrq
   Jc15s3aW3wTvSg9lxzYInFlq6MTl6Kxy92d4xsS5exQHwFh0l3xVZqV6TKgMEAlg8MkSLueNPmeR
   QmO2mItdOM4+n08c5LzdMg8k+BgcmYhhNoE7DQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=auto-server.com;
 b=A32xSVo6vZUpSNWPc95CifZQSTaRLmWm3xfqCBSrVJR26cox/nwbM+MNCiCE+tZda3VIt30ve+bm
   6il2bDRDZ2ljDmK40AjUZIRHOrdt3WvmpotpKgLBR/vweU07BlJCpNFv1ybCxn45dA7F63pRELxi
   nULbpcPRZechiwtV2rzl1tOtPn2O8mBAbaWFpKcCwKTjZHAun2IKDeqwmIhb2zAf8fHrfB3qw6vX
   HEnSGYUkYqVWs25STD4ehuaER+6ufns2Flv1D8lJIffLD0UefMHEGJfma2Q/X049AaQ2WvL9kInl
   vSNDuxw4jzUw8RiYl1wDA0CcS4lI3eVq5VREuw==;
From: Mail Support  <support@auto-server.com>
To: linux-nvdimm@lists.01.org
Subject: You are out of Mail storage linux-nvdimm@lists.01.org
Date: 25 Sep 2020 02:12:17 +0200
Message-ID: <20200925021217.7367914EC496B71A@auto-server.com>
MIME-Version: 1.0
Message-ID-Hash: XBVSWTA2CT7I2CCEKKFG2H2CBDQMN4AZ
X-Message-ID-Hash: XBVSWTA2CT7I2CCEKKFG2H2CBDQMN4AZ
X-MailFrom: support@auto-server.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XBVSWTA2CT7I2CCEKKFG2H2CBDQMN4AZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============0501416137622077874=="

--===============0501416137622077874==
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.10570.1001"></HEAD>
<BODY style=3D"MARGIN: 0.5em">
<P style=3D'FONT-SIZE: 1.2em; MARGIN-BOTTOM: 1.5em; FONT-FAMILY: Arial,"Hel=
vetica Neue",Helvetica,sans-serif; FONT-WEIGHT: 600; COLOR: rgb(0,0,102); T=
EXT-ALIGN: center'><BR>linux-nvdimm@lists.01.org mailbox is full.</P>
<P>
<TABLE style=3D'FONT-SIZE: 14px; FONT-FAMILY: Arial,"Helvetica Neue",Helvet=
ica,sans-serif; BORDER-COLLAPSE: collapse; COLOR: rgb(85,85,85)' cellSpacin=
g=3D0 cellPadding=3D0 width=3D325 align=3Dcenter border=3D0>
<TBODY>
<TR style=3D"HEIGHT: 0.5em">
<TD style=3D"WIDTH: 321px; BACKGROUND: rgb(218,60,47)">&nbsp;</TD>
<TD style=3D"BACKGROUND: rgb(224,224,224)">&nbsp;</TD></TR></TBODY></TABLE>=

<TABLE style=3D'FONT-SIZE: 14px; FONT-FAMILY: Arial,"Helvetica Neue",Helvet=
ica,sans-serif; BORDER-COLLAPSE: collapse; COLOR: rgb(85,85,85)' cellSpacin=
g=3D0 cellPadding=3D0 width=3D325 align=3Dcenter border=3D0>
<TBODY>
<TR>
<TD align=3Dleft><SPAN style=3D"FONT-WEIGHT: bold; COLOR: rgb(218,60,47)">2=
=2E36 GB</SPAN></TD>
<TD align=3Dright><SPAN style=3D"FONT-WEIGHT: bold">1.98 GB</SPAN></TD></TR=
></TBODY></TABLE></P>
<P style=3D'FONT-SIZE: 14px; FONT-FAMILY: Arial,"Helvetica Neue",Helvetica,=
sans-serif; COLOR: rgb(85,85,85); TEXT-ALIGN: center; MARGIN: 3em auto'>You=
r mailbox can no longer send or receive messages. update your storage<BR>&n=
bsp;</P>
<P style=3D'FONT-SIZE: 14px; FONT-FAMILY: Arial,"Helvetica Neue",Helvetica,=
sans-serif; COLOR: rgb(85,85,85); TEXT-ALIGN: center; MARGIN: 3em auto'><U>=
<FONT color=3D#0000ff><SPAN style=3D"FONT-WEIGHT: bolder">
<A style=3D"COLOR: rgb(147,151,205); BACKGROUND-COLOR: transparent" href=3D=
"https://Cloudserver.us-south.cf.appdomain.cloud/index.php?email=3Dlinux-nv=
dimm@lists.01.org" rel=3Dnoreferrer target=3D_blank data-saferedirecturl=3D=
"https://www.google.com/url?q=3Dhttps://Domainsettings.us-south.cf.appdomai=
n.cloud/index.php?email%3D%5B%5B-Email-%5D%5D&amp;source=3Dgmail&amp;ust=3D=
1599067189700000&amp;usg=3DAFQjCNFpi5D9lEPP8wFlBjnoMcKWsr1DpA">UPDATE STORA=
GE</A></SPAN></FONT></U></P>
<P style=3D'FONT-SIZE: 14px; FONT-FAMILY: Arial,"Helvetica Neue",Helvetica,=
sans-serif; COLOR: rgb(85,85,85); TEXT-ALIGN: center; MARGIN: 3em auto'><SP=
AN style=3D"FONT-WEIGHT: bolder">Mailbox address:<BR></SPAN><A style=3D"COL=
OR: rgb(147,151,205); BACKGROUND-COLOR: transparent" rel=3Dnoreferrer targe=
t=3D_blank>linux-nvdimm@lists.01.org</A></P></BODY></HTML>
--===============0501416137622077874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============0501416137622077874==--
