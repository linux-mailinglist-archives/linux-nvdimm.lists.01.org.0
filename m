Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D119315165
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 15:18:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 917B4100EAB68;
	Tue,  9 Feb 2021 06:18:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=167.89.93.53; helo=o1678993x53.outbound-mail.sendgrid.net; envelope-from=bounces+2656461-f357-linux-nvdimm=lists.01.org@email.housecallpro.com; receiver=<UNKNOWN> 
Received: from o1678993x53.outbound-mail.sendgrid.net (o1678993x53.outbound-mail.sendgrid.net [167.89.93.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0F6D1100EAB41
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 06:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=housecallpro.com;
	h=from:subject:mime-version:reply-to:to:content-type:
	content-transfer-encoding;
	s=s1; bh=xW3UaOnepRn/43IROaCH3symQU5gBbxvoz4JlInZRQ0=;
	b=ZONUJZGLpFxrM1/eoE9U1SUxEOUZzmBczM4gisfi0SwnoSjgvIJisc/Q+/9xNImG47rU
	/1ZoUuDptsgPRgBjKWvgG+7dn9aFipva4PTJmfWwlT7i76efw4dinJ7PQJiaHXCjRkDMkk
	G4K2jvViF7coIEYA7+ZepZv1ZBM2wVodo=
Received: by filterdrecv-p1iad2-asgard-b-65bd4668d7-65dvd with SMTP id filterdrecv-p1iad2-asgard-b-65bd4668d7-65dvd-14-60229995-1DC
        2021-02-09 14:17:58.128497855 +0000 UTC m=+505422.108475537
Received: from housecallpro.com (unknown)
	by ismtpd0003p1sjc2.sendgrid.net (SG) with ESMTP id HGoZXiMeQrKaXsor8Nmh_A
	for <linux-nvdimm@lists.01.org>; Tue, 09 Feb 2021 14:17:57.836 +0000 (UTC)
Date: Tue, 09 Feb 2021 14:17:58 +0000 (UTC)
From: mariawillasey <notifications@housecallpro.com>
Message-ID: <6022999591be5_2e3fdb15dc0bb0138160cc@2dc0e978d377.mail>
Subject: Email message from Mrs Maria Willasey
Mime-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?muQMaUMqe5wiUWeHxt+qie012LxcIU5ZPlw8XHdbNMGvhWBwii8kyJffhraeOh?=
 =?us-ascii?Q?zy5bgSRJGUpzuJG0W2QrDLzDqW02LzWQrs7PoMK?=
 =?us-ascii?Q?Z9U=2FSUChXAjwGeNjke92L5laYMioBUWiaqQIiwn?=
 =?us-ascii?Q?2iKOL1VaWIxY+R0FQssdDECnueWQbK6sf7tcvkV?=
 =?us-ascii?Q?WhIXADd7fZtCyR=2F8+yAcTsmfUipgSXQ8R7PEDh9?=
 =?us-ascii?Q?iE31OVdCApvPALqvzDBs9G=2FxKDa+iFfWaRevJCQ?=
 =?us-ascii?Q?SCZEdc0cp83yWC86YFAq+tY+xewSSOw2kdjT89m?= =?us-ascii?Q?pM0=3D?=
X-SG-ID: 
 =?us-ascii?Q?N2C25iY2uzGMFz6rgvQsb8raWjw0ZPf1VmjsCkspi=2FJ2mDLwjOC2JKzENxExhG?=
 =?us-ascii?Q?ARmtwdP48PNLunaBRHCDlsk+7CNgIVAh8JeRLGF?=
 =?us-ascii?Q?glc=2FbrgtGGpTx55ZsDT2d4niODlUWsi=2FuEW+woq?=
 =?us-ascii?Q?iz=2F5RuNnWN=2F0c6WFEXQ+f7PhqHtQD7uP=2F56Jzwn?=
 =?us-ascii?Q?yyP9gXu3ycQddrsByGFhXEC=2FtFBxTUtO475ZR0W?=
 =?us-ascii?Q?ETN9yFdHVSCf+obfc=3D?=
To: linux-nvdimm@lists.01.org
X-Entity-ID: Hdqpuju+7cZN4/+lxjI9vg==
Content-Type: multipart/mixed;
 boundary="--==_mimepart_60229995914f8_2e3fdb15dc0bb013815933";
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: IXKLUJQL2PROOMDTALXHFLEBRFEFM5TX
X-Message-ID-Hash: IXKLUJQL2PROOMDTALXHFLEBRFEFM5TX
X-MailFrom: bounces+2656461-f357-linux-nvdimm=lists.01.org@email.housecallpro.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mariawillasey44@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IXKLUJQL2PROOMDTALXHFLEBRFEFM5TX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>


----==_mimepart_60229995914f8_2e3fdb15dc0bb013815933
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

----==_mimepart_60229995914f8_2e3fdb15dc0bb013815933--
