Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD96354186
	for <lists+linux-nvdimm@lfdr.de>; Mon,  5 Apr 2021 13:31:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8BD3C100EBB6A;
	Mon,  5 Apr 2021 04:31:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 449A4100EBB67
	for <linux-nvdimm@lists.01.org>; Mon,  5 Apr 2021 04:31:25 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 135B3Vrp114404;
	Mon, 5 Apr 2021 07:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=U4WuMtx1tAABGCdgazA57G26e8rSeLPSEoNluxY1+L8=;
 b=UPbck8PEdFITmQKvFKKeNl7/p6OlvCnQK06AniiSMC2hF2Bqmknglg9wrd1otZ16Gs/2
 B7X4K1V0h0GoMng4HuBtad+wN+ZEZNGrbT/KOd8Yeqp9Q+EGN4JkOiDI8JD3IRZgP/uc
 OKjDo9BIHrTSGd31xymnmIGoalStFhvNeBcS9kEFJfr/4LNDPV4xeXAM81OYTuR8LGPN
 gXAsDkaDV+kKRd9hFe51pi+E1juPXDDVd6gDIJcqHYXgqKVG1v5sQCZdjOM3G9Ao62SA
 Rn+TnQUqFHQYf0qkYqT1Sjxq4kNMsVYAhLR2e1QnVBSNJPq5M6jUrhmMqgVO5TFC4lgP 9g==
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37q5p9y899-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Apr 2021 07:31:16 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 135BNTQ8020402;
	Mon, 5 Apr 2021 11:31:15 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
	by ppma04wdc.us.ibm.com with ESMTP id 37q2n18ce0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Apr 2021 11:31:15 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 135BVFNA29819248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Apr 2021 11:31:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44A99B205F;
	Mon,  5 Apr 2021 11:31:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98549B2066;
	Mon,  5 Apr 2021 11:31:13 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.75.170])
	by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon,  5 Apr 2021 11:31:13 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm/region: Update nvdimm_has_flush() to handle
 ND_REGION_ASYNC
In-Reply-To: <20210402092555.208590-1-vaibhav@linux.ibm.com>
References: <20210402092555.208590-1-vaibhav@linux.ibm.com>
Date: Mon, 05 Apr 2021 17:01:10 +0530
Message-ID: <87a6qd6k8x.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NlxNha6FWa8qU91aGJllL-eeoISrGjQ0
X-Proofpoint-GUID: NlxNha6FWa8qU91aGJllL-eeoISrGjQ0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_08:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050074
Message-ID-Hash: 4ZK3XP3P7G6NLELONWFE673GFZV4BCM5
X-Message-ID-Hash: 4ZK3XP3P7G6NLELONWFE673GFZV4BCM5
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, mpe@ellerman.id.au, Shivaprasad G Bhat <sbhat@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4ZK3XP3P7G6NLELONWFE673GFZV4BCM5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> In case a platform doesn't provide explicit flush-hints but provides an
> explicit flush callback via ND_REGION_ASYNC region flag, then
> nvdimm_has_flush() still returns '0' indicating that writes do not
> require flushing. This happens on PPC64 with patch at [1] applied,
> where 'deep_flush' of a region was denied even though an explicit
> flush function was provided.
>
> Fix this by adding a condition to nvdimm_has_flush() to test for the
> ND_REGION_ASYNC flag on the region and see if a 'region->flush'
> callback is assigned.
>

May be this should have
Fixes: c5d4355d10d4 ("libnvdimm: nd_region flush callback support")

Without this we will mark the pmem disk not having FUA support?


> References:
> [1] "powerpc/papr_scm: Implement support for H_SCM_FLUSH hcall"
> https://lore.kernel.org/linux-nvdimm/161703936121.36.7260632399	582101498.stgit@e1fbed493c87
>
> Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  drivers/nvdimm/region_devs.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ef23119db574..e05cc9f8a9fd 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1239,6 +1239,11 @@ int nvdimm_has_flush(struct nd_region *nd_region)
>  			|| !IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API))
>  		return -ENXIO;
>  
> +	/* Test if an explicit flush function is defined */
> +	if (test_bit(ND_REGION_ASYNC, &nd_region->flags) && nd_region->flush)
> +		return 1;

> +
> +	/* Test if any flush hints for the region are available */
>  	for (i = 0; i < nd_region->ndr_mappings; i++) {
>  		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
>  		struct nvdimm *nvdimm = nd_mapping->nvdimm;
> @@ -1249,8 +1254,8 @@ int nvdimm_has_flush(struct nd_region *nd_region)
>  	}
>  
>  	/*
> -	 * The platform defines dimm devices without hints, assume
> -	 * platform persistence mechanism like ADR
> +	 * The platform defines dimm devices without hints nor explicit flush,
> +	 * assume platform persistence mechanism like ADR
>  	 */
>  	return 0;
>  }
> -- 
> 2.30.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
