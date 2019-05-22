Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EA925E15
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 May 2019 08:35:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E23A621962301;
	Tue, 21 May 2019 23:35:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5513821256BD9
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 23:35:53 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4M6WLV1070772
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 02:35:52 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2smyayv4ra-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 02:35:51 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 22 May 2019 07:35:51 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 22 May 2019 07:35:48 +0100
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4M6ZlS124510908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 May 2019 06:35:48 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC79778066;
 Wed, 22 May 2019 06:35:47 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92C897805C;
 Wed, 22 May 2019 06:35:46 +0000 (GMT)
Received: from [9.124.31.87] (unknown [9.124.31.87])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 22 May 2019 06:35:46 +0000 (GMT)
Subject: Re: [RFC PATCH 1/3] mm/nvdimm: Add PFN_MIN_VERSION support
To: dan.j.williams@intel.com
References: <20190522062057.26581-1-aneesh.kumar@linux.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 22 May 2019 12:05:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522062057.26581-1-aneesh.kumar@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19052206-0020-0000-0000-00000EEE87E9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011141; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01206848; UDB=6.00633758; IPR=6.00987824; 
 MB=3.00026997; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-22 06:35:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052206-0021-0000-0000-000065EBBC02
Message-Id: <27bcf0e4-ba1d-2a7e-c181-ff60a9413bce@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-22_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220048
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/22/19 11:50 AM, Aneesh Kumar K.V wrote:
> This allows us to make changes in a backward incompatible way. I have
> kept the PFN_MIN_VERSION in this patch '0' because we are not introducing
> any incompatible changes in this patch. We also may want to backport this
> to older kernels.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>   drivers/nvdimm/pfn.h      |  9 ++++++++-
>   drivers/nvdimm/pfn_devs.c |  4 ++++
>   drivers/nvdimm/pmem.c     | 26 ++++++++++++++++++++++----
>   3 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvdimm/pfn.h b/drivers/nvdimm/pfn.h
> index dde9853453d3..1b10ae5773b6 100644
> --- a/drivers/nvdimm/pfn.h
> +++ b/drivers/nvdimm/pfn.h
> @@ -20,6 +20,12 @@
>   #define PFN_SIG_LEN 16
>   #define PFN_SIG "NVDIMM_PFN_INFO\0"
>   #define DAX_SIG "NVDIMM_DAX_INFO\0"
> +/*
> + * increment this when we are making changes such that older
> + * kernel should fail to initialize that namespace.
> + */
> +
> +#define PFN_MIN_VERSION 0
>   
>   struct nd_pfn_sb {
>   	u8 signature[PFN_SIG_LEN];
> @@ -36,7 +42,8 @@ struct nd_pfn_sb {
>   	__le32 end_trunc;
>   	/* minor-version-2 record the base alignment of the mapping */
>   	__le32 align;
> -	u8 padding[4000];
> +	__le16 min_verison;
> +	u8 padding[3998];
>   	__le64 checksum;
>   };
>   
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 01f40672507f..3250de70a7b3 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -439,6 +439,9 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>   	if (nvdimm_read_bytes(ndns, SZ_4K, pfn_sb, sizeof(*pfn_sb), 0))
>   		return -ENXIO;
>   
> +	if (le16_to_cpu(pfn_sb->min_version > PFN_MIN_VERSION))
> +		return -EOPNOTSUPP;

+	if (le16_to_cpu(pfn_sb->min_version) > PFN_MIN_VERSION)
+		return -EOPNOTSUPP;



-aneesh

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
