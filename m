Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AF32FF05
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 May 2019 17:12:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AC8B521283A63;
	Thu, 30 May 2019 08:12:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 71670212794C6
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 08:12:40 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4UF2EUN075299
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 11:12:39 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2stfevf9g0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 11:12:39 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 30 May 2019 16:12:37 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 30 May 2019 16:12:35 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4UFCY4h20381756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2019 15:12:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0A5EA405B;
 Thu, 30 May 2019 15:12:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 836A3A4062;
 Thu, 30 May 2019 15:12:33 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.37.131])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 30 May 2019 15:12:33 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: Re: [RFC PATCH V2 1/3] mm/nvdimm: Add PFN_MIN_VERSION support
In-Reply-To: <20190522082701.6817-1-aneesh.kumar@linux.ibm.com>
References: <20190522082701.6817-1-aneesh.kumar@linux.ibm.com>
Date: Thu, 30 May 2019 20:42:32 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19053015-0020-0000-0000-000003420062
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0021-0000-0000-00002195061A
Message-Id: <874l5c563j.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-30_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300107
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


Hi Dan,

Are you ok with this patch series? If yes I can send a non-RFC version for
this series. Since we are now marking all previously created pfn_sb on
ppc64 as not supported, (pfn_sb->page_size = SZ_4K) I would like to get
this merged early.

-aneesh

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> This allows us to make changes in a backward incompatible way. I have
> kept the PFN_MIN_VERSION in this patch '0' because we are not introducing
> any incompatible changes in this patch. We also may want to backport this
> to older kernels.
>
> The error looks like
>
>   dax0.1: init failed, superblock min version 1, kernel support version 0
>
> and the namespace is marked disabled
>
> $ndctl list -Ni
> [
>   {
>     "dev":"namespace0.0",
>     "mode":"fsdax",
>     "map":"mem",
>     "size":10737418240,
>     "uuid":"9605de6d-cefa-4a87-99cd-dec28b02cffe",
>     "state":"disabled"
>   }
> ]
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/pfn.h      |  9 ++++++++-
>  drivers/nvdimm/pfn_devs.c |  8 ++++++++
>  drivers/nvdimm/pmem.c     | 26 ++++++++++++++++++++++----
>  3 files changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvdimm/pfn.h b/drivers/nvdimm/pfn.h
> index dde9853453d3..5fd29242745a 100644
> --- a/drivers/nvdimm/pfn.h
> +++ b/drivers/nvdimm/pfn.h
> @@ -20,6 +20,12 @@
>  #define PFN_SIG_LEN 16
>  #define PFN_SIG "NVDIMM_PFN_INFO\0"
>  #define DAX_SIG "NVDIMM_DAX_INFO\0"
> +/*
> + * increment this when we are making changes such that older
> + * kernel should fail to initialize that namespace.
> + */
> +
> +#define PFN_MIN_VERSION 0
>  
>  struct nd_pfn_sb {
>  	u8 signature[PFN_SIG_LEN];
> @@ -36,7 +42,8 @@ struct nd_pfn_sb {
>  	__le32 end_trunc;
>  	/* minor-version-2 record the base alignment of the mapping */
>  	__le32 align;
> -	u8 padding[4000];
> +	__le16 min_version;
> +	u8 padding[3998];
>  	__le64 checksum;
>  };
>  
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 01f40672507f..a2268cf262f5 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -439,6 +439,13 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>  	if (nvdimm_read_bytes(ndns, SZ_4K, pfn_sb, sizeof(*pfn_sb), 0))
>  		return -ENXIO;
>  
> +	if (le16_to_cpu(pfn_sb->min_version) > PFN_MIN_VERSION) {
> +		dev_err(&nd_pfn->dev,
> +			"init failed, superblock min version %ld kernel support version %ld\n",
> +			le16_to_cpu(pfn_sb->min_version), PFN_MIN_VERSION);
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (memcmp(pfn_sb->signature, sig, PFN_SIG_LEN) != 0)
>  		return -ENODEV;
>  
> @@ -769,6 +776,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
>  	memcpy(pfn_sb->parent_uuid, nd_dev_to_uuid(&ndns->dev), 16);
>  	pfn_sb->version_major = cpu_to_le16(1);
>  	pfn_sb->version_minor = cpu_to_le16(2);
> +	pfn_sb->min_version = cpu_to_le16(PFN_MIN_VERSION);
>  	pfn_sb->start_pad = cpu_to_le32(start_pad);
>  	pfn_sb->end_trunc = cpu_to_le32(end_trunc);
>  	pfn_sb->align = cpu_to_le32(nd_pfn->align);
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 845c5b430cdd..406427c064d9 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -490,6 +490,7 @@ static int pmem_attach_disk(struct device *dev,
>  
>  static int nd_pmem_probe(struct device *dev)
>  {
> +	int ret;
>  	struct nd_namespace_common *ndns;
>  
>  	ndns = nvdimm_namespace_common_probe(dev);
> @@ -505,12 +506,29 @@ static int nd_pmem_probe(struct device *dev)
>  	if (is_nd_pfn(dev))
>  		return pmem_attach_disk(dev, ndns);
>  
> -	/* if we find a valid info-block we'll come back as that personality */
> -	if (nd_btt_probe(dev, ndns) == 0 || nd_pfn_probe(dev, ndns) == 0
> -			|| nd_dax_probe(dev, ndns) == 0)
> +	ret = nd_btt_probe(dev, ndns);
> +	if (ret == 0)
>  		return -ENXIO;
> +	else if (ret == -EOPNOTSUPP)
> +		return ret;
>  
> -	/* ...otherwise we're just a raw pmem device */
> +	ret = nd_pfn_probe(dev, ndns);
> +	if (ret == 0)
> +		return -ENXIO;
> +	else if (ret == -EOPNOTSUPP)
> +		return ret;
> +
> +	ret = nd_dax_probe(dev, ndns);
> +	if (ret == 0)
> +		return -ENXIO;
> +	else if (ret == -EOPNOTSUPP)
> +		return ret;
> +	/*
> +	 * We have two failure conditions here, there is no
> +	 * info reserver block or we found a valid info reserve block
> +	 * but failed to initialize the pfn superblock.
> +	 * Don't create a raw pmem disk for the second case.
> +	 */
>  	return pmem_attach_disk(dev, ndns);
>  }
>  
> -- 
> 2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
