Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22061321DF0
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 18:19:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D034100EB83D;
	Mon, 22 Feb 2021 09:19:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 25B79100EB839
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 09:19:25 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MHEuQ5054493;
	Mon, 22 Feb 2021 17:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=vnHr3C1bGWixmjJDDIePCQqucPq632Nd3BRKp7RVf4M=;
 b=KoJlYbsPA/wolEILAHkgfIYz3Fdd4vT4Hoq/11zrW24k8Ympp8QaMtwgYKbPUWubYahz
 aDXTMTniI1D5cKb3n9BdxD7rcFQc4YYDfge/O6wHVGZrX7ZIa2vuxppGuQEM5xxT08dS
 BmecDU3tywLmRAUwqZK0wATP9FrHPqnEBgWt/ASsdBG6pkWdGQcdy+jHkHWwn1K0eTli
 n5JdoHqgf5FtAlevDhHjnSX6slIZaj8x+acT3nXRhxVVXjk/b5tgwB98CP/SC2NCmigU
 2DjIq/5xPFc011/3+Lgyr3FKxe44zyAHJHXYWLIIiyw/rwcuG0i8EvjS5hK9++d8gSTu LQ==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 36tqxbchgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 17:19:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MHAQ5W128591;
	Mon, 22 Feb 2021 17:19:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by userp3030.oracle.com with ESMTP id 36ucbwcq1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 17:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJZRHxxqtYXvja8wVdBKv8pnn5N8CV6X5AdTWtq74DcB+Befc0tZjuqYpVyxoz211fZ9uzoQ/U9PDBx4V9n3oxphe/bxD1NrapxWdycYnpurnK/MOsMhSXBJ0a95gaCL3hQjLLNsC81Moqi7wQaIO14f9iw1QAbcZ5GM2MmYMvMS8nMHM1yBOnLPzhmCLBRVelpPp1ZpJwFF0dkP6aIRAyH9kgPKEm8T+IN01koxd3KWWUNyGUavov05NO2PqST5+Uh90ARcPWZMcSYUoeckupNdYt+NWrLE5xsDfJ63GScV+Xv2oqgmcJjrYAk1RhAQdus+SvppFm3e/MLyWYOZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnHr3C1bGWixmjJDDIePCQqucPq632Nd3BRKp7RVf4M=;
 b=IbaimMx4y+GfBVkGEewxIJW7tPVJ562gmwow5Az+dou/Az7Uc9uZFj+Isea/0hglfBClBFXr8e0AuUP/TGLtzN55zWlZ8tkK5gkNGihqRtgv1/sPKkvE4HUOUyGNCho05nucMkbtm1W4XwhXYCuCHGHSuSQYWMTMCGYqghiL5su9q1agKoGEFWFms3Fl1jnOFziqtn3gS2V7vzcethP6eHD8JyQmLNzOsGwx2bXeK97geZDryKpFdqm9TCMo2sEEEhmKWbSsekfKm1RrdHku7k9GJHNo8ZNqDeGSp32GqS2THv9AjjbwqhECiXLMDD9r/nuVhWVQrStL/6MLHXEYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnHr3C1bGWixmjJDDIePCQqucPq632Nd3BRKp7RVf4M=;
 b=TU4o9Ci7jC+10YPgydRu+m6bsXKlmKhG4lJ+bIa9s1NXgd8vB2+ksP5uaCpAyP0DCx3FwvP0xzHKF2kCutttq7v+QnqCm4kbS4QKpEWom3uP87OGtU7YzXrk8UK7v1vLldw/DDUHvVdebUsGLs1MFxwaeHePWVA/i+i4PHH/IwE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 17:19:08 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 17:19:08 +0000
Date: Mon, 22 Feb 2021 12:19:03 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH] cxl/mem: Fixes to IOCTL interface
Message-ID: <YDPnh53YUk5YWYSI@Konrads-MacBook-Pro.local>
References: <20210220215641.604535-1-ben.widawsky@intel.com>
 <CAPcyv4gfoe=QGuKV19ay51D-cqzRqTMLpD-p5whnJbYkKoGtBA@mail.gmail.com>
 <20210221034703.ncetonon7iseqd72@intel.com>
Content-Disposition: inline
In-Reply-To: <20210221034703.ncetonon7iseqd72@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SA9PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:806:23::15) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by SA9PR13CA0070.namprd13.prod.outlook.com (2603:10b6:806:23::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.8 via Frontend Transport; Mon, 22 Feb 2021 17:19:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc90fd81-4b0a-44d0-3548-08d8d755f657
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB4370A26F28C1AE632AD1F7F689819@BY5PR10MB4370.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MKVtAiBCQGJD1+MMcBaCy8Fk7roesrnXGhMzX9Vs4bIjI0gLmE4ryxn6vOtz4VHoED1kl1FpcN+3my6vcQIqMhnbvZ7bu/PmfOWZbXrPLY9yPfL0RtjA1i3IrUMkRZCZmDMZO5BBJawnjDVAkaONwcyjBdTYGDhJoyEtVGe6oGpMRXPG8Q4OgcgfbyiGYzEOy1Ka/w2EIgfuUFD1V+Y71WziDMn6i8NQJx94iobpo+A9RKrP84rdFAoa3ab8S0l/fH3+QzVDnzmTWEoEh7qqdgjkvYu18osZv80lTJlHrl6iWqa/+HXNl1hFjAu2Rqa7EZB9DYP+tVzWWNw8dzpwaWWXWEANe6GiB3GUT+CTc8Dk22vUbQTGS7/LK3uCIS8y4MZBbKuEfW88rDcxqRf1h6u4agizQkgZEtuhkGJgray/k+xk66W1lWAHpSfZfzJbgpIbo9ZlUE4dBeGKLFm0ga0MyEZgc+wxugkF0y2VyjUPLK34LbuDOcAHxSMDIcrhavKwQtpIKhuHCFidJcmTYA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(52116002)(55016002)(8676002)(86362001)(4744005)(7696005)(66476007)(2906002)(9686003)(5660300002)(66946007)(8936002)(6916009)(66556008)(6506007)(956004)(316002)(6666004)(478600001)(16526019)(4326008)(26005)(186003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?bve/BaecSSQ0Ch6/F/0jwq0Sakaz7maB0SSxP6ffrM1J6RP2dnJdnBibdADk?=
 =?us-ascii?Q?oULI9zKJjvo+RPvFMuqx2ljgRdA2Y7avrew1YrfBWY6SjkW+29jIHk+f7GyL?=
 =?us-ascii?Q?OGPLaqR9Qm6SQ32RrCq4zhIG154LfQTEQXGAY8g65jcnEN4M3QaDJlFsP6Zo?=
 =?us-ascii?Q?2JA2Le4RH6qFKs/Gmtvo6dCsNBJkQbnCJgl3lfk9hhgqlBH8HVzhi+vSZN9R?=
 =?us-ascii?Q?DJw2rXE9R5XwMt9KnNLX0UzHiT5JkvuPw67tgN8wIDklprVhk/CItnRsaosn?=
 =?us-ascii?Q?LLJ6gJaTcvRODbuHyjDhkFZUojyH+7Pdqm/1bolmJGdSW92WOh/e89FQrh3Y?=
 =?us-ascii?Q?cdwQtJO30bQ+xoDT/cbWlPtP/cRnrziNzb6D483lpM2n+v2iPkgLS2oyzZRp?=
 =?us-ascii?Q?J2e3zHEClOJni7oXRAaafMnkKlvRS0RIh3fmvX8GzAe+3sMyI0VSACT/KQ+N?=
 =?us-ascii?Q?d20KQQIOMQE84Y7EQmWN9FrMhDAjaouPyowoSEld4AmLWBndKO4t/3+8Hia1?=
 =?us-ascii?Q?4fNbfyyYXRMKhkViHIjupQ7UnHMWGI+T64ichVbZuL5iypP6w3+DY6bL5mja?=
 =?us-ascii?Q?3c7NFhxFlx1h7qc99PdPSpDdL67ya2xVgNjGCIhvvIThVqvqAcbyt62penDR?=
 =?us-ascii?Q?h0V52fH8Ls6YCBf0C0bSnvvhnrl7EOHXTp9YS9mjo9e4w3lvplWO90h+vMh/?=
 =?us-ascii?Q?nR537/SKlrTIq8KULeMW6FN/opwom8Tuea4k8ottX9LrMl7uiOt7A+XkJZ2o?=
 =?us-ascii?Q?JpFEZ9D6rbmNUXwG4azWeOIXojF4JhfV3moCBhEA82MJzWmYMeapONeyJTTi?=
 =?us-ascii?Q?jSkbQbedtQRTicpFgFq7ohteXwUFamnSL+vr5Tc4IJJM+MNQRZbNrETkx4aX?=
 =?us-ascii?Q?YC7CdQToyrISQm1sx2YOs7aU8dj9fWeQdVazmyc87hJLooinPmrqdWpXTU86?=
 =?us-ascii?Q?DuPIxwj88cm3mfYw/A4EtXmk/O4dpuwL7fMdUUKtAvArCEePrCKT7xNd7dYy?=
 =?us-ascii?Q?tsM0w82tXrtnVsl95Wth+cBd8vNOGpUg+B0jl0mwMvbVPx6gxl/UNbccFAXb?=
 =?us-ascii?Q?YM91JDmvMg8lhyW78hBAtLUAlDwj871qZLzFGuYA/aTa6arNIHHQNItkiHAc?=
 =?us-ascii?Q?an6TN5TI8DIgwU33YdrAWk5sDpoGqGAz4fvI4+mxrLSTRkY3kdovIlNNHtgZ?=
 =?us-ascii?Q?XJbo3zaUKMFtUNTYrM7ToGhCjBpOmmLI/5ktgar9YmR/Vlg3qokjqtfQGnCj?=
 =?us-ascii?Q?JxrUw8/J98BklANZIFSuLMm1wbb/0OZLo+7Gmcx84jjX/+z8gzjV/6h+B9KS?=
 =?us-ascii?Q?mfbEfuMUzifT6nhefGNMatOg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc90fd81-4b0a-44d0-3548-08d8d755f657
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 17:19:07.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zgp03ONY79w1FSC4hsuEGPBLszcCvEhj7rm5/OAWpsfE7lCmPg3cXcwgfmfX4g/tjZ3OhhKuhaHi6WRX7clj2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4370
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=760 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220154
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220154
Message-ID-Hash: D6TDF2OHT6NEZ7CZ7RE3EMQN2S54ARTE
X-Message-ID-Hash: D6TDF2OHT6NEZ7CZ7RE3EMQN2S54ARTE
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, Alison Schofield <alison.schofield@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D6TDF2OHT6NEZ7CZ7RE3EMQN2S54ARTE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

..little snip..
> > > While here, adjust the variable 'j' found in patch review by Konrad.
> > 
> > Please split this pure cleanup to its own patch. The subject says
> > "Fixes", but it's only the one fix.
> > 
> 
> This was intentional. I pinged you internally to just drop it if you don't like
> to combine these kind of things. It didn't feel worthwhile to introduce a new
> patch to change the 'j'. I agree with Konrad that 'j' is not the best variable
> name to use. Konrad, maybe you'd like to send a fixup for that one?

Sure, but let do that _after_ Dan does his git-pull so that the
scripts/get_maintainers.pl will nicely pull the right emails :-)

> 
> I will drop this hunk.

+1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
