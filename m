Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9E349CB0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8AA3C100F227A;
	Thu, 25 Mar 2021 16:10:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 36AD6100EC1C8
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:33 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNA64n136801;
	Thu, 25 Mar 2021 23:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=/edl4LK0LqLECQ3jS/x7z7ezoamA2mW6jrxS8EmJzc4=;
 b=X/JRygtpxPmElsQfgSNw5BoGZhxSHc7Wpp+M0Vc/eVOTbg209UYOCH4P8EaXF/SACUDu
 IcfWlu1VLDMAOv8p818oArS83vTElXvW3WmDbmhqR/hDME2QrxahLKRJNFFunsn5h9xu
 QRT7+OhWdG5H/GQvKtrheK6qjlld4lX1pZXDWRKbw8NGnbVPFaAubbdMCaax/2CPWAZk
 4NTayKaeuL6KPeTEbdx0YagkRx5eFNdVACbTX0epbYyRoN5fPl95f1s+Zb+uUjv3vDSo
 qyqlO79LwLkVlFJY8z4yHUHIeZ+RuhishSHpWx/rby4RQqWbmfT+KLKjUrZkhblacBu3 DQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 37h13e8dwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PN0JKO161365;
	Thu, 25 Mar 2021 23:10:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
	by userp3020.oracle.com with ESMTP id 37h14gdpp3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:09:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUTor0emwFTNiyMXNuA/A6jxcVmr5ufreklJ+4oJvKiNED7rg0xcetKX+dFYXQHwf94qrpBiR65a80f3vjRtIm7bcWGWRUJkBJcme0tfp9X/6/luTThIujGhVntF8QJu4EXLTaRya5GaN605pdEQ3KmntZZ9GKoyA7j3G3GKU+sWL4nbIjZJgi0l0mZeYEB2EoCxo7zup2KEox8GYK+FYxZo+RJaqYaqJqZ+3JLXwXtTFnL5IGDBaBU7d7QPUwhLjnwjWyu1XebZQVScRcdraYHAxVtJE2SMWiq0rYadPuiexp+WF7g5LF28QVeMAGLp+iCbWiLv2E0sXsXNjnPPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/edl4LK0LqLECQ3jS/x7z7ezoamA2mW6jrxS8EmJzc4=;
 b=mACaqF1QvzGhySlrQ2JyeYVtbm2vJ6HnLbd27FuqQW6qrUsutSeqSYSCOX/Hey8K+m5eZU/NU0Dnypimo05fTQlpGSYLELp8YFAxj0vH158VPyikQAxcN7Ny0PDhq44gbeIFXTpJBX/rN974xDfCEMSyH5BklGGjtqu8MIV8EXDvpr9lqFiuqlyp39Hf4PrbSgl2mvxTmkeXaIGygV4IpZSe6hm9cLidgEjepzeZ//iqtqzSrM4IjF9Mjkp6C4MtNT7xobfTq2t34PEi5MbNBaaDhzm1/a8+/I3NNl9j/dJHnmy4lMt92blwPAVqsyCTkHpcv+KxLhKA1+YBEZdGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/edl4LK0LqLECQ3jS/x7z7ezoamA2mW6jrxS8EmJzc4=;
 b=RExkBMiXwb5JPh9oGHArSRbrGukp+WL6tU7m62VnGZc9X5X4q7AJKeSA7OZZivQgILFzYSrl7PHObVVNk1OM02gOEPDOepv0JLJ6+Kq2CCZzT+WT/5f8SJuZR2V4gCvuDeU6+izkaqX9fXi6xuLb//KU4jfL/fn/vJJrlmJ0QOY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3987.namprd10.prod.outlook.com (2603:10b6:a03:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 23:09:54 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:09:54 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 01/11] memory-failure: fetch compound_head after pgmap_pfn_valid()
Date: Thu, 25 Mar 2021 23:09:28 +0000
Message-Id: <20210325230938.30752-2-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:09:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 267fda0f-1be3-42e9-94f9-08d8efe319df
X-MS-TrafficTypeDiagnostic: BY5PR10MB3987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB3987E15BDBF493B2F97E2C03BB629@BY5PR10MB3987.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QLHA2ST4uRkJVxdULmKtdl50iS2x9tZ7gsdap5UQ89THG/nrKOEJNc5HnCSwnBMhpV92WIQ51zfglzWwmzvk0J285W03ci9g4qON5MciiLUJ+hah3ZFeiMtzr7WYF6iN5ZhGzJQppEYPGjTBboat/BgM9AWF91APsMHSvCwUUMiz3SZId37zaPJV7e1QKNNGvO2IIwCi3gQJ+PY5B1leZL4zq3YKOH2gGTrXiRGUIcxuRxwoq7VxzoCStcg7Leh/u3anSoYLcmEfmE84boBs151O6nGk/sLo6z4K+i/UjWPIMhap4Xziozs51x1v/XayCPTzLdpKKycS7LyjVw6l3FwNIwx3WsmVLViL5+b6NJiYpA54gLQUEaHQi9lwDpdX85KuRs/DPt56bLIEaSkxLomND7kWUQ4oMI8/MzLAnoFkMg75ONQ5S24Z0t6bKL2FGwpJvcoS+4TyTe5NkXB9D2qMgxkJkLjtQo/hRFWu6GySt/Ey59GwLn8jb4I7E0wLPSEd41UQErF+YjVaJ/EXzB+UpGf0vsrfI2dDnvf+j6ZPUVfM9f//endKNAUoGEA5WYeDO7qdfWWKrL5BhomGIknH85ufdXim9edeP5iwZ0NjpWSmvNPsUiAASx7ZLU0+m2kteI0B14h6I1eHd5smBMctKazPh4hjHCjs1TsiAwo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(83380400001)(4326008)(26005)(107886003)(6916009)(36756003)(7696005)(52116002)(66476007)(66556008)(478600001)(66946007)(186003)(316002)(2906002)(8936002)(54906003)(2616005)(86362001)(8676002)(4744005)(956004)(5660300002)(103116003)(1076003)(6666004)(38100700001)(16526019)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?F/ULqB6nBjBbbthr+K9wCDTC6Py7CNStvWjeNpJm8HnVlUqpfv0S1SREHyp0?=
 =?us-ascii?Q?qKqHbjhTR4hYkvI4Np8RFvwdyFvHVypjrFpL+JONYToHhxsgv70NIA7tL52t?=
 =?us-ascii?Q?SxHa81SzSfe6EszKLOxMiik1pVeWSzsoFkASuKMfN/tF12Db3dLp7GmuyO1C?=
 =?us-ascii?Q?q+9igWgZ/zIGIbTCoQlqDpvIwCfWT6dZVf+0jh8oaUtcr/hN98sfW7Yb9zyg?=
 =?us-ascii?Q?kuOpGQqlgtVcS0X04kcJu7GB/nVEnWHRwurNJ4jhw++XaEMGFLQ4hKTk+Wik?=
 =?us-ascii?Q?IH2vQZcnHV6zReihF5FI83/om7D2DbH8E8hWvFZ3t1KtQ2wOOTlQNTmWgWzh?=
 =?us-ascii?Q?SiSJc17U2GbFpSCHADJuc4VrpJZeK9vAc6fAdM/TIgaxXpkh3N4AThwphIZx?=
 =?us-ascii?Q?c8DLQ0Iu58+l+/ZgaH2pV+JIpB1uf4VC3RSgm+9IlMcXpcI0T/V0rNNIrDPd?=
 =?us-ascii?Q?er0ozVjyF9JDsOx6xxWUKwhOHpi7+H8fpjrOWHNMem6gxhL4KEir1Ht6N/J+?=
 =?us-ascii?Q?7mgykaQubPrgdhi+ckawgPhxd6+2zj6yKoq/xKorHxtPLRzjq7ok8QqaTKOQ?=
 =?us-ascii?Q?/+D7oo2zrROjmfgwnMlQPhfoj8RZzzDlQD22+SGnVZBOPrwObOcErv6cqm+e?=
 =?us-ascii?Q?jHMsKI9PfvpGWed1ieXGr5DVLSivS/hulGb457yqMtPILraI07mCjtRXXzZP?=
 =?us-ascii?Q?MCD37XnvFt4Yo1SAZf/OPzRvTLn9OLPwvVvcqaP0K7nzJ859WhggQl1TETdR?=
 =?us-ascii?Q?QgbDpcyY7Y+D2mzQMzQTvdGvDRmI/ytLgsFVnrtFl3wISU96UYeqbrPUKKGr?=
 =?us-ascii?Q?S6seRosDAdi7l3cw6GdPDtCL26Oj90uyz/Wm1FKA7qj7CsiVgG0ylexLGFkF?=
 =?us-ascii?Q?41T1HAd1PHAGNXNi/7cy3M2SKvyw7/GAPpXwosuWVOCdc80mZPgbTkLss0aX?=
 =?us-ascii?Q?gw4lvJBVFrkC/weXODug7Nyx1xU6zL6TEWAV5lPz3MuDmahNKvGdL3GCctjT?=
 =?us-ascii?Q?YF+Y98/KzbO5cnpyanqBSo6yi6xdOuJxaNtkYbeHioWUFfAP6wPKDTLRZl5/?=
 =?us-ascii?Q?8USiGduOwv/v4ZoeYGYTwZ1b5SFe0sRcvwX5rQzzJInueEVzk9+XZco0VNgn?=
 =?us-ascii?Q?IVYUDawQtYp3Wf2MpEQMLKmB3Okdzj+rr+sWdkqND86n1FrZCjhcvaxchgBF?=
 =?us-ascii?Q?Ul00qimQf0J6RAXr1X7t9Q6XJyhZWT1UdbaD+AxxYJjO++ndNoq4WsYj9xOk?=
 =?us-ascii?Q?DBcfs3CJHL3bppLFg+PaoVIYenaN13K8ZeRCq5fHqlBe82zVGEUtpWVj13YD?=
 =?us-ascii?Q?wo6+zx9PAjgmp7FTxw3Q68jt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267fda0f-1be3-42e9-94f9-08d8efe319df
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:09:54.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oEGPP9H5EBw0VQUtHISK2JaKCykpRa64VKzJXKaZ52euYCehOT6TkScqZiRLGbSzLRjnFEtA8hwSZxU6SsGFX5pZUVWJsv4oz4Y1yM3PhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3987
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=874 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250170
X-Proofpoint-ORIG-GUID: XapoKmfb8yxsnSR8QRLdPQxxlG7CuzKo
X-Proofpoint-GUID: XapoKmfb8yxsnSR8QRLdPQxxlG7CuzKo
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=916 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250171
Message-ID-Hash: PGXM4XJC4CLVXE4QXKIX7LW5GDHZSGSR
X-Message-ID-Hash: PGXM4XJC4CLVXE4QXKIX7LW5GDHZSGSR
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PGXM4XJC4CLVXE4QXKIX7LW5GDHZSGSR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

memory_failure_dev_pagemap() at the moment assumes base pages (e.g.
dax_lock_page()).  For pagemap with compound pages fetch the
compound_head in case we are handling a tail page memory failure.

Currently this is a nop, but in the advent of compound pages in
dev_pagemap it allows memory_failure_dev_pagemap() to keep working.

Reported-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/memory-failure.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 24210c9bd843..94240d772623 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1318,6 +1318,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		goto out;
 	}
 
+	page = compound_head(page);
+
 	/*
 	 * Prevent the inode from being freed while we are interrogating
 	 * the address_space, typically this would be handled by
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
