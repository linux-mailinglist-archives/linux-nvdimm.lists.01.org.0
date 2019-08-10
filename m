Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A3F887EC
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Aug 2019 06:21:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AD791212FD408;
	Fri,  9 Aug 2019 21:24:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D7432212FD3EC
 for <linux-nvdimm@lists.01.org>; Fri,  9 Aug 2019 21:24:12 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7A4HDhk016204
 for <linux-nvdimm@lists.01.org>; Sat, 10 Aug 2019 00:21:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u9p9ngty0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Sat, 10 Aug 2019 00:21:31 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Sat, 10 Aug 2019 05:21:29 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 10 Aug 2019 05:21:28 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7A4LRST44498958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 10 Aug 2019 04:21:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80F1752054;
 Sat, 10 Aug 2019 04:21:27 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.46.182])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C26105204E;
 Sat, 10 Aug 2019 04:21:26 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: Re: [PATCH v5 2/4] mm/nvdimm: Add page size and struct page size to
 pfn superblock
In-Reply-To: <20190809074520.27115-3-aneesh.kumar@linux.ibm.com>
References: <20190809074520.27115-1-aneesh.kumar@linux.ibm.com>
 <20190809074520.27115-3-aneesh.kumar@linux.ibm.com>
Date: Sat, 10 Aug 2019 09:51:23 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19081004-0028-0000-0000-0000038DF3D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081004-0029-0000-0000-0000244FFB55
Message-Id: <8736i9r6po.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-10_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908100046
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

  	case PFN_MODE_PMEM:
> @@ -475,6 +484,20 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>  		align = 1UL << ilog2(offset);
>  	mode = le32_to_cpu(pfn_sb->mode);
>  
> +	if (le32_to_cpu(pfn_sb->page_size) != PAGE_SIZE) {
> +		dev_err(&nd_pfn->dev,
> +			"init failed, page size mismatch %d\n",
> +			le32_to_cpu(pfn_sb->page_size));
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (le16_to_cpu(pfn_sb->page_struct_size) < sizeof(struct page)) {
> +		dev_err(&nd_pfn->dev,
> +			"init failed, struct page size mismatch %d\n",
> +			le16_to_cpu(pfn_sb->page_struct_size));
> +		return -EOPNOTSUPP;
> +	}
> +

We need this here?

From 9885b2f9ed81a2438fc81507cfcdbdb1aeab756c Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Fri, 9 Aug 2019 22:10:08 +0530
Subject: [PATCH] nvdimm: check struct page size only if pfn node is PMEM

We should do the check only with PFN_MODE_PMEM. If we use
memory for backing vmemmap, we should be able to enable
the namespace even if struct page size change.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/pfn_devs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index f43d1baa6f33..f3e9a4b826da 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -509,7 +509,8 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		return -EOPNOTSUPP;
 	}
 
-	if (le16_to_cpu(pfn_sb->page_struct_size) < sizeof(struct page)) {
+	if ((le16_to_cpu(pfn_sb->page_struct_size) < sizeof(struct page)) &&
+	     (mode == PFN_MODE_PMEM)) {
 		dev_err(&nd_pfn->dev,
 			"init failed, struct page size mismatch %d\n",
 			le16_to_cpu(pfn_sb->page_struct_size));
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
