Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33F293729
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Oct 2020 10:52:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2E97015F4B284;
	Tue, 20 Oct 2020 01:52:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3DEA115A38FA2
	for <linux-nvdimm@lists.01.org>; Tue, 20 Oct 2020 01:52:18 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09K8XeVL092857;
	Tue, 20 Oct 2020 04:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=69AcAGC/Hgz5JTSJ7wZ082gsI1rcgdpR+ELt15/wDYM=;
 b=gdMffTOD2toUWhEBMdzYpylTNqALYyjCiMJUs48Uf0ar9dZVjsZD8uMRi+OXF/DuOwcj
 ZLIGf/qKuONFpTAwBrjVHfeDnVP0n/4B5/DZ6195sP93ewJsu8Cr6mcVsy9fVLuhvHIA
 r+jxZLFRMksgKQUIAuKqoruBhwh1LpuIucPpIm1dp/dgb0pt8709kMFDYHe0Rb/E5Tpt
 4m1NdXZg/G/zC7eHnfMgMKd2aFTSciaZQmy162ciX9yN4hqCS4rNCEMhQgUaVwPhGxQd
 yXevyi7h7Fe3T0zp+qmqluvL3/le3j+73h3AlefYcechK90vEfZSej2Mo3LM6INDr7Ge 4w==
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com with ESMTP id 349vef0m14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2020 04:52:13 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09K8hR9D000413;
	Tue, 20 Oct 2020 08:52:11 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma01wdc.us.ibm.com with ESMTP id 347r88xdva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2020 08:52:11 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09K8q5nG28770774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2020 08:52:05 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A4026A43D;
	Tue, 20 Oct 2020 08:52:10 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 393B86A43B;
	Tue, 20 Oct 2020 08:52:08 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.92.7])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2020 08:52:07 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: Re: negative count with static key devmap_managed_key
In-Reply-To: <87wnzljpq0.fsf@linux.ibm.com>
References: <87wnzljpq0.fsf@linux.ibm.com>
Date: Tue, 20 Oct 2020 14:22:05 +0530
Message-ID: <87sga9jn4a.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-20_04:2020-10-20,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 bulkscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200057
Message-ID-Hash: BH6Z25NBMXE6KFIJ2XCU2AD3EB4HANDU
X-Message-ID-Hash: BH6Z25NBMXE6KFIJ2XCU2AD3EB4HANDU
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BH6Z25NBMXE6KFIJ2XCU2AD3EB4HANDU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Hi Christoph,
>
> commit 6f42193fd86e ("memremap: don't use a separate devm action for
> devmap_managed_enable_get") changed the static key updates such that we
> are now calling	devmap_managed_enable_put() without doing the equivalent
> devmap_managed_enable_get().
>
> devmap_managed_enable_get() is only called for MEMORY_DEVICE_PRIVATE and
> MEMORY_DEVICE_FS_DAX, But memunmap_pages() get called for other pgmap
> types too. This result in the below. I can recreate this by repeatedly
> switching between system-ram and devdax mode for devdax namespace. 
>
>


mm/memremap.c | 19 +++++++++++++++----

modified   mm/memremap.c
@@ -158,6 +158,16 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 {
 	unsigned long pfn;
 	int i;
+	bool need_devmap_managed = false;
+
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_FS_DAX:
+		need_devmap_managed = true;
+		break;
+	default:
+		break;
+	}
 
 	dev_pagemap_kill(pgmap);
 	for (i = 0; i < pgmap->nr_range; i++)
@@ -169,7 +179,8 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 		pageunmap_range(pgmap, i);
 
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
-	devmap_managed_enable_put();
+	if (need_devmap_managed)
+		devmap_managed_enable_put();
 }
 EXPORT_SYMBOL_GPL(memunmap_pages);
 
@@ -307,7 +318,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		.pgprot = PAGE_KERNEL,
 	};
 	const int nr_range = pgmap->nr_range;
-	bool need_devmap_managed = true;
+	bool need_devmap_managed = false;
 	int error, i;
 
 	if (WARN_ONCE(!nr_range, "nr_range must be specified\n"))
@@ -327,6 +338,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 			WARN(1, "Missing owner\n");
 			return ERR_PTR(-EINVAL);
 		}
+		need_devmap_managed = true;
 		break;
 	case MEMORY_DEVICE_FS_DAX:
 		if (!IS_ENABLED(CONFIG_ZONE_DEVICE) ||
@@ -334,13 +346,12 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 			WARN(1, "File system DAX not supported\n");
 			return ERR_PTR(-EINVAL);
 		}
+		need_devmap_managed = true;
 		break;
 	case MEMORY_DEVICE_GENERIC:
-		need_devmap_managed = false;
 		break;
 	case MEMORY_DEVICE_PCI_P2PDMA:
 		params.pgprot = pgprot_noncached(params.pgprot);
-		need_devmap_managed = false;
 		break;
 	default:
 		WARN(1, "Invalid pgmap type %d\n", pgmap->type);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
