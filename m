Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E9C26046
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 May 2019 11:17:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 01D8721276770;
	Wed, 22 May 2019 02:17:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=sathnaga@linux.vnet.ibm.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3EE5E2126D822
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 02:17:05 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4M92WTX013913
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 05:17:04 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2sn37y154j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 05:17:03 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <sathnaga@linux.vnet.ibm.com>;
 Wed, 22 May 2019 10:17:02 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 22 May 2019 10:17:01 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4M9H0WN59375656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 May 2019 09:17:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25DFCA4060;
 Wed, 22 May 2019 09:17:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 024B1A405B;
 Wed, 22 May 2019 09:16:59 +0000 (GMT)
Received: from sathnaga86.d4t-in.ibmmobiledemo.com (unknown [9.122.211.101])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 22 May 2019 09:16:58 +0000 (GMT)
Date: Wed, 22 May 2019 14:46:56 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH V2 3/3] mm/nvdimm: Use correct #defines instead of
 opencoding
References: <20190522082701.6817-1-aneesh.kumar@linux.ibm.com>
 <20190522082701.6817-3-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190522082701.6817-3-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-TM-AS-GCONF: 00
x-cbid: 19052209-0008-0000-0000-000002E93770
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052209-0009-0000-0000-00002255F114
Message-Id: <20190522091656.GA19800@sathnaga86.d4t-in.ibmmobiledemo.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-22_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220067
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
Reply-To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 22, 2019 at 01:57:01PM +0530, Aneesh Kumar K.V wrote:
> The nfpn related change is needed to fix the kernel message
> 
> "number of pfns truncated from 2617344 to 163584"
> 
> The change makes sure the nfpns stored in the superblock is right value.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/label.c       | 2 +-
>  drivers/nvdimm/pfn_devs.c    | 6 +++---
>  drivers/nvdimm/region_devs.c | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
> index f3d753d3169c..bc6de8fb0153 100644
> --- a/drivers/nvdimm/label.c
> +++ b/drivers/nvdimm/label.c
> @@ -361,7 +361,7 @@ static bool slot_valid(struct nvdimm_drvdata *ndd,
> 
>  	/* check that DPA allocations are page aligned */
>  	if ((__le64_to_cpu(nd_label->dpa)
> -				| __le64_to_cpu(nd_label->rawsize)) % SZ_4K)
> +				| __le64_to_cpu(nd_label->rawsize)) % PAGE_SIZE)
>  		return false;
> 
>  	/* check checksum */
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 39fa8cf8ef58..9fc2e514e28a 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -769,8 +769,8 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
>  		 * when populating the vmemmap. This *should* be equal to
>  		 * PMD_SIZE for most architectures.
>  		 */
> -		offset = ALIGN(start + reserve + 64 * npfns,
> -				max(nd_pfn->align, PMD_SIZE)) - start;
> +		offset = ALIGN(start + reserve + sizeof(struct page) * npfns,
> +			       max(nd_pfn->align, PMD_SIZE)) - start;
>  	} else if (nd_pfn->mode == PFN_MODE_RAM)
>  		offset = ALIGN(start + reserve, nd_pfn->align) - start;
>  	else
> @@ -782,7 +782,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
>  		return -ENXIO;
>  	}
> 
> -	npfns = (size - offset - start_pad - end_trunc) / SZ_4K;
> +	npfns = (size - offset - start_pad - end_trunc) / PAGE_SIZE;
>  	pfn_sb->mode = cpu_to_le32(nd_pfn->mode);
>  	pfn_sb->dataoff = cpu_to_le64(offset);
>  	pfn_sb->npfns = cpu_to_le64(npfns);
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index b4ef7d9ff22e..2d8facea5a03 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -994,10 +994,10 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
>  		struct nd_mapping_desc *mapping = &ndr_desc->mapping[i];
>  		struct nvdimm *nvdimm = mapping->nvdimm;
> 
> -		if ((mapping->start | mapping->size) % SZ_4K) {
> -			dev_err(&nvdimm_bus->dev, "%s: %s mapping%d is not 4K aligned\n",
> -					caller, dev_name(&nvdimm->dev), i);
> -
> +		if ((mapping->start | mapping->size) % PAGE_SIZE) {
> +			dev_err(&nvdimm_bus->dev,
> +				"%s: %s mapping%d is not 4K aligned\n",

s/not 4K aligned/not PAGE_SIZE aligned ?

hope the error msg need to be changed as well..

Regards,
-Satheesh.
> +				caller, dev_name(&nvdimm->dev), i);
>  			return NULL;
>  		}
> 
> -- 
> 2.21.0
> 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
