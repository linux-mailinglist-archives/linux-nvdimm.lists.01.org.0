Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EAA308774
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 Jan 2021 10:39:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C3ED100EAB0B;
	Fri, 29 Jan 2021 01:39:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.72.233.132; helo=wrqvzwvq.outbound-mail.sendgrid.net; envelope-from=bounces+7689-cf7e-linux-nvdimm=lists.01.org@email.proprofs.com; receiver=<UNKNOWN> 
Received: from wrqvzwvq.outbound-mail.sendgrid.net (wrqvzwvq.outbound-mail.sendgrid.net [149.72.233.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5E44A100EB346
	for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 01:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proprofs.com;
	h=content-transfer-encoding:content-type:from:mime-version:subject:
	reply-to:to;
	s=smtpapi; bh=um8tC8EfF8C5OPeH66VcoYGBrJ+Qx/44PH38rQjQwKY=;
	b=KhVP5+sdfXniziFWEd0qygp7u1R5B4PQD70hDYmp2kQMhry3G9nxpVEmf0hm82aoMlM7
	MohourV+Tb2D8zMm7//fIZKuPPiEM31lgPQaZnKnzeJ8fOmhM0RxIvxUhUuoUZrSCFOKWC
	33d2/eDoRlgS3J3+KgoH1tHpIAIRhTMws=
Received: by filterdrecv-p1las1-asgard-b-644f7d6f57-mxrfr with SMTP id filterdrecv-p1las1-asgard-b-644f7d6f57-mxrfr-14-6013D7C7-78
        2021-01-29 09:39:19.725882204 +0000 UTC m=+34959.663854711
Received: from NzY4OQ (unknown)
	by geopod-ismtpd-4-3 (SG) with HTTP
	id HvIbSNUeT1OJqOKFCCcmDg
	Fri, 29 Jan 2021 09:39:19.581 +0000 (UTC)
Date: Fri, 29 Jan 2021 09:39:19 +0000 (UTC)
From: Mariawillasey44 <no-reply@proprofs.com>
Mime-Version: 1.0
Message-ID: <HvIbSNUeT1OJqOKFCCcmDg@geopod-ismtpd-4-3>
Subject: Email message from Ms Maria Willasey
X-SG-EID: 
 =?us-ascii?Q?WhKQZfIcxPpTdvSEMRWdisSe=2FQ8CZV1GdlE2FNjkB51Vlj=2FOOTeGVEKHtEuRXu?=
 =?us-ascii?Q?iNqIm12+Mf5Mq9Um1QVlNJ4VT9xHT21eJ+m5+P3?=
 =?us-ascii?Q?xpVUgcEUT9xTHnUpKHV3bOm6I18xyz7feJ+OLAN?=
 =?us-ascii?Q?fKzaB5m20CYMVV5XzlzAX7OrNL1v4rpJcHMvsJf?=
 =?us-ascii?Q?P6RgzmejsdnmW1KCkiv6Tb6Ozxx63dQArgX=2FchN?=
 =?us-ascii?Q?4UpL0UtcV=2FWKFvf46e5IdtGH38AeBeyhC=2FAkhYX?=
 =?us-ascii?Q?qSQlyEC0EzMgtyjzw0Gwg=3D=3D?=
X-SG-ID: 
 =?us-ascii?Q?N2C25iY2uzGMFz6rgvQsb7cbaDyJZLA7KVzRy=2FCHJRk+97Hv4lxyB6S8=2FimLFf?=
 =?us-ascii?Q?P0F2aAyaCSZ+aYzFkowleB5gPWr2ykZdA18jOkF?=
 =?us-ascii?Q?iJpFL=2FVuC2LpDCiAzfFHBj+m8HA?=
To: linux-nvdimm@lists.01.org
X-Entity-ID: nJqfvQ3eGVSRS3fDZMPvHg==
Message-ID-Hash: 2SHRJZOQG6UMUKQNHURSN2X6LBP4X6GH
X-Message-ID-Hash: 2SHRJZOQG6UMUKQNHURSN2X6LBP4X6GH
X-MailFrom: bounces+7689-cf7e-linux-nvdimm=lists.01.org@email.proprofs.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mariawillasey44@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2SHRJZOQG6UMUKQNHURSN2X6LBP4X6GH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============2968984053347432009=="

--===============2968984053347432009==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=iso-8859-1

<html><head></head><body>
                                            <div bgcolor=3D"#FAFAFA">
                                            <table width=3D"100%" bgcolor=
=3D"#FAFAFA" border=3D"0" cellpadding=3D"0" cellspacing=3D"0" align=3D"cent=
er">
                                            <tbody>
                                            <tr>
                                            <td align=3D"center">
                                            <table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" style=3D"width:164px;margin:12px auto 0 auto;">
                                            <tbody>
                                            <tr>
                                            <td valign=3D"bottom" align=3D"=
center">
                                            <a href=3D"http://www.proprofs.=
com/classroom/3005330">
                                            <img style=3D"padding-left:5px;=
height:35px" src=3D"https://www.proprofs.com/api/classroom/images/Classroom=
.png?v=3D1" alt=3D"ProProfs Classroom" border=3D"0" class=3D"CToWUd">
                                            </a>
                                            </td>
                                            </tr>
                                            </tbody>
                                            </table>
                                            <table width=3D"90%" style=3D"m=
ax-width:600px;margin-top:0%!important;margin-bottom:2%!important">
                                            <tbody><tr style=3D"height:80px=
;background:#2c7db7">
                                            <td style=3D"text-align:center;=
font-size:27px">
                                            <span style=3D"color: #fff;text=
-decoration: none;">Your Classroom Link</span>
                                            </td>
                                            </tr>
                                            <tr>
                                            <td>
                                            <div style=3D"color:#505050;fon=
t-family:Arial;font-size:15px;line-height:150%;background:#fff;padding:4%">
                                            <p>Dear one<br />
<br />
With your permission I want to present to you my sincere initiatives and pr=
oposals.<br />
<br />
In the spirit of faith, solidarity, humanity and common sense appeal to you=
r wisdom and kindness as a human of this planet with the request friendship=
 sustains me if you consider setting up a foundation for humanitarian work =
with 6.650 million American United States dollars inherited from my late hu=
sband who was an industrialist.<br />
<br />
I decided to donate these funds because I have no child and my days are num=
bered according to my physician who always examines my health because I was=
 diagnosed by serious lung and breast cancer and will be going for my third=
 surgical operation next week, I want you to use these funds nationally and=
 internationally to people without hope, against which we must not be carel=
ess.<br />
<br />
I am Mrs Maria Willasey, and childless, always cheerful with a desire to do=
 good and give those who need help. The principles which I rely in life are=
 faith, humanity, solidarity, respect and trust.<br />
<br />
Please always put me in your daily prayers so that God will grant more days=
 to my leaving and confirm these funds into your hand.<br />
<br />
Hoping to hearing from you soonest with your information that I will submit=
 to the bank for the transfer of this money to your account and your delays=
 in replying to this message will create an avenue of searching for another=
 person that will understand the nature of my situation in other to handle =
this donation funds gloriously to the Kingdom of God.<br />
<br />
I am urgently expecting your kind acceptance reply through my private email=
 address (<a href=3D"mailto:mariawillasey44@gmail.com" target=3D"_blank">ma=
riawillasey44@gmail.com</a>) Remain blessed with your family.<br />
Mrs. Maria Willasey</p>

                                            </div>
                                            </td>
                                            </tr>
                                            <tr>
                                            <td align=3D"center" style=3D"b=
order-top:1px #f1f1f1 solid;padding:10px 0px 10px 0px"><font face=3D"Arial"=
 style=3D"font-size:11px;color:#cccccc">
                                            <span style=3D"font-size:12px">=
Copyright =A9 2005 - 2021 ProProfs.com</span></font>
                                            </td>
                                            </tr>
                                            </tbody>
                                            </table>
                                            </td>
                                            </tr>
                                            </tbody>
                                            </table>
                                            </div><img src=3D"http://email.=
proprofs.com/wf/open?upn=3DoDb6ny51mUB6FExYn3rQhp9v-2BSEotJ75cJ9XNLugTFBDNC=
KocIMEiOVVzZvvf98CT68NGif3biJmPlrWAAP6zvR6WmJBlCsHEcwLp32CKPbv4CIRrIu-2B2lV=
moXkp2R6SYAbbzRxJLZ2JFA7g51rboee6InE8f6-2FgPZ4JgI1tdjXofKAMttr5q52ouiuiM5GI=
trvJ2Zh53gh46F-2F1DBTZnGCdQ4QgRMBOS4dS5UTzrKJBHvCh3zhHpc88y2h5fONnMg8YMz8qC=
vuI3fXkRVXlI6qLyZwNmzZGoFnC4875GqfOhLk3sxG-2FFhzCcpheNEWCUPdXpwiUiMhnf-2FKi=
-2B2jZoQ-3D-3D" alt=3D"" width=3D"1" height=3D"1" border=3D"0" style=3D"hei=
ght:1px !important;width:1px !important;border-width:0 !important;margin-to=
p:0 !important;margin-bottom:0 !important;margin-right:0 !important;margin-=
left:0 !important;padding-top:0 !important;padding-bottom:0 !important;padd=
ing-right:0 !important;padding-left:0 !important;"/></body>
                                            </html>
--===============2968984053347432009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============2968984053347432009==--
