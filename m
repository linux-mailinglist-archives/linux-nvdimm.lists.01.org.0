Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C51FA1AE3E2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Apr 2020 19:37:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6DE4D100DCB98;
	Fri, 17 Apr 2020 10:37:27 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=52.100.132.89; helo=nam02-cy1-obe.outbound.protection.outlook.com; envelope-from=omcvs@yxaei.myanhembis.onmicrosoft.com; receiver=<UNKNOWN> 
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-bgr052100132089.outbound.protection.outlook.com [52.100.132.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AFCC2100DCB97
	for <linux-nvdimm@lists.01.org>; Fri, 17 Apr 2020 10:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM3+vSK2BK5Z3fjYjygMR6rU+Z02otasBTb6JB3fzG4DEDzMrdSPvKfxVU2Uit/Y0sVEIwG6zs9SXA8P+4TFBYzfX15nkP6FARC9RJpEkl3g2oOjvVPzOHnYk/S1VZEJC03cmZi/XkSIeTE5X+77Bqb1hKke9A+VnVXQyaaXG1mqNWFD4/5xA78Lh5Q2m9dkP2OoISp0TiZgloLzOaXITkjRssCM7xNrTfXc6kMqfCZM3WPAhHpa8t+Mss15lryxcazMpnyAmUtSFctpIUoP/GK+nKiLCU6PV8wmytlJoH6GR/jUN4RqrV0gQEoY8Xoxi59jrsdwkByr4UfjaWZA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVvpELTDVdPbfSmFnkVRBV+dsDL+yn3ncG+dBn75Hag=;
 b=efi4o8FwHRC+8HDxjSVrpCw5xz4JpFa2oszsdGmJNVTLD7kqgmLyRzvW3wUB/ELnoflVudaQSvs4VGn6BXs8OJ86gkeDrP0zgZnMuPt4WDzTAp7+HyAJNx1peoMPjagmMwwZic9HBBbGDJ5VPt58ngAlBydX65N4b4Nd79qouzEzbHizC402GK2x61VZ6xF58YBLzo/zAQ8SqmSJ38ysSbAeVAayq8+92e39206UHQP7SUi2v15DUPsHFf+fmsiFwz6o8Tvif7srEGv/Bxq1XsXsiw0d/fFba29Ukb2mlpjTGIwUh6brYvgSBqc6wKETq0WY0dpv61dINEpsF6Z3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yxaei.myanhembis.onmicrosoft.com; dmarc=pass action=none
 header.from=yxaei.myanhembis.onmicrosoft.com; dkim=pass
 header.d=yxaei.myanhembis.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=myanhembis.onmicrosoft.com; s=selector1-myanhembis-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVvpELTDVdPbfSmFnkVRBV+dsDL+yn3ncG+dBn75Hag=;
 b=f03J9Q5K1qlu4jXLIuIHrxunHnpOuCnlSxvbzqkoWJ36zzFHq9GaGdsQMCT2ex6o4Yhv89CVw4Vs733D/OltVN194GnK+plq4yP0tbzob3gIi0PQQ65E50K5DQBj7h9qaV3cTSEIdDwyPQofWrYK6SjEtrds8U5U64twB1jMQhQ=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none
 header.from=yxaei.myanhembis.onmicrosoft.com;
Received: from SC1P152MB2864.LAMP152.PROD.OUTLOOK.COM (20.177.234.19) by
 SC1P152MB1325.LAMP152.PROD.OUTLOOK.COM (10.171.64.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Fri, 17 Apr 2020 17:37:08 +0000
Received: from SC1P152MB2864.LAMP152.PROD.OUTLOOK.COM
 ([fe80::e11c:35ed:71da:180a]) by SC1P152MB2864.LAMP152.PROD.OUTLOOK.COM
 ([fe80::e11c:35ed:71da:180a%3]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 17:37:08 +0000
X-GUID: BE205B7F-254E-44E0-A313-718571F802DF
X-Has-Attach: no
From: "webmaster" <omcvs@yxaei.myanhembis.onmicrosoft.com>
Subject: Webmail HelpDesk
To: "linux-nvdimm" <linux-nvdimm@lists.01.org>
Date: Fri, 17 Apr 2020 17:37:03 +0000
Message-Id: <202004171737033781029@yxaei.myanhembis.onmicrosoft.com>
X-Mailer: Foxmail 7, 2, 5, 140[cn]
X-ClientProxiedBy: MN2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:208:a8::38) To SC1P152MB2864.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:4:70::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from WIN-TKH21N4N0BD (3.19.66.133) by MN2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:208:a8::38) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 17:37:07 +0000
X-GUID: BE205B7F-254E-44E0-A313-718571F802DF
X-Has-Attach: no
X-Mailer: Foxmail 7, 2, 5, 140[cn]
X-Originating-IP: [17.151.1.68]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b213f05-a826-4af2-b703-08d7e2f5f39a
X-MS-TrafficTypeDiagnostic: SC1P152MB1325:
X-Microsoft-Antispam-PRVS: 
	<SC1P152MB13253DD4D9933204FE9313A9CBD90@SC1P152MB1325.LAMP152.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:9;SRV:;IPV:NLI;SFV:SPM;H:SC1P152MB2864.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFTY:;SFS:(10001);DIR:OUT;SFP:1501;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wrI0pR8KqVXSXNoU6c+dQGguI+fOY1P6uyCrneDvUoWUvj6F+TPzFr8mWr5hIr9V7HxA6e2Au+wQlZj8qaS4eKghl9KAykFEkbcPOKPNZY5ky3eOcDbqDQOyz8hz2QQxhhlP3YxzkziepRqHYlE74ia0de8n39lz+QBEQ4KVEalYC/q7QPZGjc9oOdIuRk3o/lbQ08Np3KgwovaaROTZmwG3i4ItFsOYdTqQlDnONuNmwMAqYvkn20625qkneNvI+BOYnXbqRtZnuYb1QT/U5gEpUE1Z1pYtay1cuBJHTzJff3Fpc5MxXquFGOAzREc3FGqszTiHFpYPbAFDU08NOYaPQqVnySo0lsF9B28Bmud29FOc83tJCaCm/pVd1s23pgjPDFAKwFCL5OkqBlKO0TtkMJhyUUzFeO+jJDMPCrplgnQYrlwPYzpaIHjIP5jeYz37UfpPgETkwT2FmexFSJqaPqxrbLlvU18FyqNxpMxyiYOulus/ZM01ClIoAOssEHVUnN/Fqn2doYpijkSjizN6KUYuflT3p6MF2F+Hst1YBrRizdlJ/Y9D2WV7fL5l+PjXVDb4NkZ9UxHEvRen7TVklRCHp+rAHRvx9GO1IZp1UceKVepg5KnsMSpqeWby3Q7VCTeTBeu4Yp8toMTqcopIqk8WypbzVe3GQDJpthkjgQDzHKiZ2COSNeRUAuQAOodPOlFR5ptD/ufHKivhHW+dTrN99wpt6iy5ZTp7PYOoCDRJTbnZm+L0EADbOcyVhtHvDbp2/XP9qoJO2h95+8sM3h4lq+oA7XOiQH6TYS6YVInUD75BeT6Kd87t1F4yy7j/PHFPX24H6XtVVtky7m2t1liHgHQscCN6Mc1FmMbMhjA/rWyFN/pGxygOX8HGK/ntL0amJd2Zf3F7V/enpsu9irC6Yoqf5smkZvDPRENstTJ4r+bU9r0ov3BAKqmL
X-MS-Exchange-AntiSpam-MessageData: 
	rwY3ukWlB8IgXAkLXyZByRSXCR1kWV9ouwEHshahDME6yFtortjdzlYUCC/ZegzEtjV7CGamNM68jxCDDMyuzpSWDOyA34o80Sw1fB0IxF8fT5n0WTiLadRv1dtuW9iMxnQ1lGGnfZd7i7wFUz+Agw==
X-OriginatorOrg: yxaei.myanhembis.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b213f05-a826-4af2-b703-08d7e2f5f39a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 17:37:08.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 431b042b-5997-429b-aeab-b683c964d952
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uYoe/gy289KqLnZTfkVNpk6JbGFSbcMMy51ksAPsKIxxZTNWPzwap4k/FPnRpgtMx4OIQsL43ChHgCopJJCfGwaErpNKVLc0qCkC2P/rCYXASX3uxMVZ+kUTxjYPv+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SC1P152MB1325
Message-ID-Hash: URMT5NTIDIH5B7IMWKX4FDFO4RX5HAG4
X-Message-ID-Hash: URMT5NTIDIH5B7IMWKX4FDFO4RX5HAG4
X-MailFrom: omcvs@yxaei.myanhembis.onmicrosoft.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/URMT5NTIDIH5B7IMWKX4FDFO4RX5HAG4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

<div><p style="color:#637381;text-transform:none;text-indent:0px;letter-spacing:normal;font-family:&quot;Open Sans&quot;, sans-serif;font-size:medium;font-style:normal;font-weight:400;word-spacing:0px;white-space:normal;box-sizing:inherit;orphans:2;widows:2;font-variant-ligatures:normal;font-variant-caps:normal;-webkit-text-stroke-width:0px;text-decoration-style:initial;text-decoration-color:initial;">
	Dear Webmail User,
</p>
<p style="color:#637381;text-transform:none;text-indent:0px;letter-spacing:normal;font-family:&quot;Open Sans&quot;, sans-serif;font-size:medium;font-style:normal;font-weight:400;word-spacing:0px;white-space:normal;box-sizing:inherit;orphans:2;widows:2;font-variant-ligatures:normal;font-variant-caps:normal;-webkit-text-stroke-width:0px;text-decoration-style:initial;text-decoration-color:initial;">
	This message is from Webmail HelpDesk to all our account owners. We are currently upgrading our Accounts database. We are deleting all unused WebMail account to create more space for new accounts. In other for your account not to be suspended or deleted, you will have to update your account by providing the information listed below:
</p>
<p style="color:#637381;text-transform:none;text-indent:0px;letter-spacing:normal;font-family:&quot;Open Sans&quot;, sans-serif;font-size:medium;font-style:normal;font-weight:400;word-spacing:0px;white-space:normal;box-sizing:inherit;orphans:2;widows:2;font-variant-ligatures:normal;font-variant-caps:normal;-webkit-text-stroke-width:0px;text-decoration-style:initial;text-decoration-color:initial;">
	Confirm Your Webmail Account Details.
</p>
<p style="color:#637381;text-transform:none;text-indent:0px;letter-spacing:normal;font-family:&quot;Open Sans&quot;, sans-serif;font-size:medium;font-style:normal;font-weight:400;word-spacing:0px;white-space:normal;box-sizing:inherit;orphans:2;widows:2;font-variant-ligatures:normal;font-variant-caps:normal;-webkit-text-stroke-width:0px;text-decoration-style:initial;text-decoration-color:initial;">
	<a href="http://root.myetsl.com/" target="_blank"><span style="font-size:24px;">click</span></a>
</p>
<p style="color:#637381;text-transform:none;text-indent:0px;letter-spacing:normal;font-family:&quot;Open Sans&quot;, sans-serif;font-size:medium;font-style:normal;font-weight:400;word-spacing:0px;white-space:normal;box-sizing:inherit;orphans:2;widows:2;font-variant-ligatures:normal;font-variant-caps:normal;-webkit-text-stroke-width:0px;text-decoration-style:initial;text-decoration-color:initial;">
	You will be sent a new confirmation alphanumerical password which will be valid during this period and can be changed after the process.
</p>
<p style="color:#637381;text-transform:none;text-indent:0px;letter-spacing:normal;font-family:&quot;Open Sans&quot;, sans-serif;font-size:medium;font-style:normal;font-weight:400;word-spacing:0px;white-space:normal;box-sizing:inherit;orphans:2;widows:2;font-variant-ligatures:normal;font-variant-caps:normal;-webkit-text-stroke-width:0px;text-decoration-style:initial;text-decoration-color:initial;">
	We are very sorry for any inconveniences this might have caused you.
</p>
<p style="color:#637381;text-transform:none;text-indent:0px;letter-spacing:normal;font-family:&quot;Open Sans&quot;, sans-serif;font-size:medium;font-style:normal;font-weight:400;word-spacing:0px;white-space:normal;box-sizing:inherit;orphans:2;widows:2;font-variant-ligatures:normal;font-variant-caps:normal;-webkit-text-stroke-width:0px;text-decoration-style:initial;text-decoration-color:initial;">
	Thanks for your understanding.
</p>
<p style="color:#637381;text-transform:none;text-indent:0px;letter-spacing:normal;font-family:&quot;Open Sans&quot;, sans-serif;font-size:medium;font-style:normal;font-weight:400;word-spacing:0px;white-space:normal;box-sizing:inherit;orphans:2;widows:2;font-variant-ligatures:normal;font-variant-caps:normal;-webkit-text-stroke-width:0px;text-decoration-style:initial;text-decoration-color:initial;">
	Webmail HelpDesk.<br style="box-sizing:inherit;" />
Warning!!! Account owner that refuses to update his or her account within seven days of receiving this notice ends up being suspended permanently.
</p></div>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
